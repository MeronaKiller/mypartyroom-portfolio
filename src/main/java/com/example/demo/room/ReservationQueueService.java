package com.example.demo.room;

import com.example.demo.dto.ReservationDto;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.context.ApplicationContext;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.ConcurrentHashMap;
import java.util.HashMap;
import java.util.Map;

@Service
public class ReservationQueueService {
    
    @Autowired
    private ApplicationContext applicationContext;
    
    // 큐와 스레드 풀
    private final BlockingQueue<ReservationDto> queue = new LinkedBlockingQueue<>(1000);
    private final ExecutorService executor = Executors.newFixedThreadPool(16);
    
    // 통계용
    private final AtomicInteger successCount = new AtomicInteger(0);
    private final AtomicInteger failCount = new AtomicInteger(0);
    private final AtomicInteger totalProcessed = new AtomicInteger(0);
    private final long startTime = System.currentTimeMillis();
    
    // 처리 중인 요청 추적
    private final Map<String, Long> processingRequests = new ConcurrentHashMap<>();
    
    // 배치 모드 플래그
    private volatile boolean batchMode = false;
    
    // Lazy loading으로 의존성 해결
    private RoomMapper getRoomMapper() {
        try {
            return applicationContext.getBean(RoomMapper.class);
        } catch (Exception e) {
            System.err.println("RoomMapper Bean을 찾을 수 없습니다: " + e.getMessage());
            return null;
        }
    }
    
    private BatchReservationService getBatchReservationService() {
        try {
            return applicationContext.getBean(BatchReservationService.class);
        } catch (Exception e) {
            System.err.println("BatchReservationService Bean을 찾을 수 없습니다: " + e.getMessage());
            return null;
        }
    }
    
    private void publishEvent(ReservationStatusUpdateEvent event) {
        try {
            applicationContext.publishEvent(event);
        } catch (Exception e) {
            System.err.println("이벤트 발행 실패: " + e.getMessage());
        }
    }
    
    @PostConstruct
    public void init() {
        System.out.println("====================================");
        System.out.println("⚡ ReservationQueueService 시작");
        System.out.println("====================================");
        
        // 16개 워커 스레드 시작
        for (int i = 0; i < 16; i++) {
            final int workerId = i + 1;
            executor.submit(() -> {
                System.out.println("⚡ 워커 " + workerId + " 시작됨");
                while (!Thread.currentThread().isInterrupted()) {
                    try {
                        ReservationDto dto = queue.poll(500, TimeUnit.MILLISECONDS);
                        if (dto != null) {
                            // 배치 모드 체크
                            if (batchMode && queue.size() > 50) {
                                BatchReservationService batchService = getBatchReservationService();
                                if (batchService != null) {
                                    batchService.addToBatch(dto);
                                }
                                continue;
                            }
                            
                            processReservationWithLock(dto, workerId);
                        }
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                        break;
                    } catch (Exception e) {
                        failCount.incrementAndGet();
                        System.err.println("💥 워커 " + workerId + " 예외 발생: " + e.getMessage());
                        e.printStackTrace();
                    }
                }
                System.out.println("워커 " + workerId + " 종료됨");
            });
        }
        
        // 배치 모드 전환 스레드
        executor.submit(() -> {
            while (!Thread.currentThread().isInterrupted()) {
                try {
                    Thread.sleep(2000);
                    
                    int queueSize = queue.size();
                    
                    if (queueSize > 200 && !batchMode) {
                        batchMode = true;
                        System.out.println("🚀 배치 모드 활성화 - 큐 크기: " + queueSize);
                    } else if (queueSize < 50 && batchMode) {
                        batchMode = false;
                        System.out.println("⚡ 실시간 모드 전환 - 큐 크기: " + queueSize);
                    }
                    
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
        });
        
        // 정리 스레드
        executor.submit(() -> {
            while (!Thread.currentThread().isInterrupted()) {
                try {
                    Thread.sleep(10000);
                    cleanupProcessingRequests();
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
        });
    }
    
    @PreDestroy
    public void destroy() {
        System.out.println("예약 처리 서비스 종료 중...");
        executor.shutdown();
        try {
            if (!executor.awaitTermination(10, TimeUnit.SECONDS)) {
                executor.shutdownNow();
            }
        } catch (InterruptedException e) {
            executor.shutdownNow();
        }
    }
    
    // 처리 중인 요청 정리
    private void cleanupProcessingRequests() {
        long currentTime = System.currentTimeMillis();
        processingRequests.entrySet().removeIf(entry -> 
            (currentTime - entry.getValue()) > 10000
        );
        System.out.println("🧹 처리 중인 요청 정리 완료. 남은 수: " + processingRequests.size());
    }

    // 실제 예약 처리 로직
    private boolean processReservation(ReservationDto dto, int workerId) {
        try {
            System.out.println("🔍 워커 " + workerId + " DB 처리 시작: " + dto.getRcode());
            
            // 데이터 검증
            if (dto.getRcode() == null || dto.getStartTime() == null || dto.getEndTime() == null) {
                System.err.println("❌ 워커 " + workerId + " 필수 데이터 누락");
                return false;
            }
            
            // 시간 유효성 검사
            if (dto.getStartTime().compareTo(dto.getEndTime()) >= 0) {
                System.err.println("❌ 워커 " + workerId + " 잘못된 시간 범위");
                return false;
            }
            
            RoomMapper mapper = getRoomMapper();
            if (mapper == null) {
                System.err.println("❌ 워커 " + workerId + " RoomMapper를 찾을 수 없음");
                return false;
            }
            
            long checkStart = System.currentTimeMillis();
            int conflictCount = mapper.countConflictingReservations(dto);
            long checkEnd = System.currentTimeMillis();
            
            System.out.println("🔍 워커 " + workerId + " 충돌 검사 완료: " + conflictCount + "건 (" + 
                (checkEnd - checkStart) + "ms)");
            
            if (conflictCount > 0) {
                System.out.println("⚠️ 워커 " + workerId + " 시간 충돌로 실패: " + dto.getRcode());
                return false;
            }
            
            System.out.println("💾 워커 " + workerId + " INSERT 실행 중...");
            long insertStart = System.currentTimeMillis();
            int result = mapper.insertReservationSimple(dto);
            long insertEnd = System.currentTimeMillis();
            
            System.out.println("💾 워커 " + workerId + " INSERT 완료: " + result + " (" + 
                (insertEnd - insertStart) + "ms)");
            
            return result > 0;
            
        } catch (Exception e) {
            System.err.println("💥 워커 " + workerId + " DB 에러: " + e.getMessage());
            return false;
        }
    }
    
    // 진행 상황 로그
    private void logProgress(int total) {
        long elapsed = System.currentTimeMillis() - startTime;
        double tps = total / Math.max(elapsed / 1000.0, 1.0);
        
        System.out.printf("\n⚡===== 처리 현황 =====\n");
        System.out.printf("총 처리: %d건\n", total);
        System.out.printf("성공: %d건\n", successCount.get());
        System.out.printf("실패: %d건\n", failCount.get());
        System.out.printf("성공률: %.1f%%\n", (successCount.get() * 100.0) / Math.max(total, 1));
        System.out.printf("TPS: %.2f\n", tps);
        System.out.printf("대기 큐: %d건\n", queue.size());
        System.out.printf("처리 중: %d건\n", processingRequests.size());
        System.out.printf("배치 모드: %s\n", batchMode ? "활성" : "비활성");
        System.out.printf("경과 시간: %.2f초\n", elapsed / 1000.0);
        System.out.println("==================\n");
    }
    
    // 배치 모드 수동 전환
    public void setBatchMode(boolean enabled) {
        this.batchMode = enabled;
        System.out.println("🔧 배치 모드 " + (enabled ? "활성화" : "비활성화"));
    }
    
    // 큐 크기 조회
    public int getQueueSize() {
        return queue.size();
    }
    
    // 통계 초기화
    public void resetStats() {
        successCount.set(0);
        failCount.set(0);
        totalProcessed.set(0);
        processingRequests.clear();
        queue.clear();
        BatchReservationService batchService = getBatchReservationService();
        if (batchService != null) {
            batchService.resetBatchStats();
        }
        System.out.println("📊 모든 통계 및 큐 초기화 완료");
    }
    
    // UUID 추적이 가능한 큐 추가 메서드
    public boolean enqueueWithUuid(ReservationDto dto, String uuid) {
        // 기존 검증 로직
        if (dto.getStartTime().contains("{{") || dto.getEndTime().contains("{{")) {
            System.err.println("❌ 템플릿 변수가 치환되지 않음: " + dto.getStartTime());
            publishEvent(new ReservationStatusUpdateEvent(this, uuid, "failed", "잘못된 시간 형식", null));
            return false;
        }
        
        String key = dto.getRcode() + "_" + dto.getStartTime() + "_" + dto.getEndTime();
        long currentTime = System.currentTimeMillis();
        
        // 중복 체크
        Long lastProcessTime = processingRequests.get(key);
        if (lastProcessTime != null && (currentTime - lastProcessTime) < 2000) {
            System.out.println("🔄 최근 중복 요청 무시: " + key + " (2초 이내)");
            publishEvent(new ReservationStatusUpdateEvent(this, uuid, "failed", "중복 요청", null));
            return false;
        }
        
        // 큐 포화 체크
        if (queue.size() > 800) {
            System.err.println("❌ 큐 포화 방지: " + queue.size() + "/1000");
            publishEvent(new ReservationStatusUpdateEvent(this, uuid, "failed", "서버 과부하", null));
            return false;
        }
        
        // UUID를 DTO에 저장
        dto.setModified_at(uuid);
        
        // 처리 중인 요청으로 등록
        processingRequests.put(key, currentTime);
        
        // 배치 모드 체크
        if (batchMode && queue.size() > 100) {
            BatchReservationService batchService = getBatchReservationService();
            if (batchService != null) {
                boolean added = batchService.addToBatch(dto);
                if (added) {
                    System.out.println("🚀 배치 큐 추가: " + dto.getRcode() + " | UUID: " + uuid);
                    publishEvent(new ReservationStatusUpdateEvent(this, uuid, "processing", null, null));
                }
                return added;
            }
        }
        
        boolean added = queue.offer(dto);
        if (added) {
            System.out.println("✅ 큐 추가 완료: " + dto.getRcode() + " | 큐 크기: " + queue.size() + " | UUID: " + uuid);
            publishEvent(new ReservationStatusUpdateEvent(this, uuid, "processing", null, null));
        } else {
            System.err.println("❌ 큐 포화상태! 큐 크기: " + queue.size());
            processingRequests.remove(key);
            publishEvent(new ReservationStatusUpdateEvent(this, uuid, "failed", "큐 포화", null));
        }
        return added;
    }

    // 기존 enqueue 메서드
    public boolean enqueue(ReservationDto dto) {
        String uuid = dto.getModified_at();
        
        if (uuid != null && !uuid.isEmpty()) {
            return enqueueWithUuid(dto, uuid);
        } else {
            return enqueueLegacy(dto);
        }
    }

    // 기존 enqueue 로직
    private boolean enqueueLegacy(ReservationDto dto) {
        if (dto.getStartTime().contains("{{") || dto.getEndTime().contains("{{")) {
            System.err.println("❌ 템플릿 변수가 치환되지 않음: " + dto.getStartTime());
            return false;
        }
        
        String key = dto.getRcode() + "_" + dto.getStartTime() + "_" + dto.getEndTime();
        long currentTime = System.currentTimeMillis();
        
        Long lastProcessTime = processingRequests.get(key);
        if (lastProcessTime != null && (currentTime - lastProcessTime) < 2000) {
            System.out.println("🔄 최근 중복 요청 무시: " + key + " (2초 이내)");
            return false;
        }
        
        if (queue.size() > 800) {
            System.err.println("❌ 큐 포화 방지: " + queue.size() + "/1000");
            return false;
        }
        
        processingRequests.put(key, currentTime);
        
        if (batchMode && queue.size() > 100) {
            BatchReservationService batchService = getBatchReservationService();
            if (batchService != null) {
                boolean added = batchService.addToBatch(dto);
                if (added) {
                    System.out.println("🚀 배치 큐 추가: " + dto.getRcode());
                }
                return added;
            }
        }
        
        boolean added = queue.offer(dto);
        if (added) {
            System.out.println("✅ 큐 추가 완료: " + dto.getRcode() + " | 큐 크기: " + queue.size());
        } else {
            System.err.println("❌ 큐 포화상태! 큐 크기: " + queue.size());
            processingRequests.remove(key);
        }
        return added;
    }

    // UUID 추적이 가능한 예약 처리 메서드
    @Transactional
    private void processReservationWithLock(ReservationDto dto, int workerId) {
        String key = dto.getRcode() + "_" + dto.getStartTime() + "_" + dto.getEndTime();
        String uuid = dto.getModified_at();
        
        try {
            System.out.println("🔍 워커 " + workerId + " 처리 시작: " + dto.getRcode() + 
                " | " + dto.getStartTime() + " ~ " + dto.getEndTime() + 
                (uuid != null ? " | UUID: " + uuid : ""));
            
            // UUID가 있으면 상태 업데이트
            if (uuid != null && !uuid.isEmpty()) {
                publishEvent(new ReservationStatusUpdateEvent(this, uuid, "processing", null, null));
            }
            
            boolean success = processReservation(dto, workerId);
            
            if (success) {
                successCount.incrementAndGet();
                System.out.println("✅ 워커 " + workerId + " 성공: " + dto.getRcode() + 
                    (uuid != null ? " | UUID: " + uuid : ""));
                
                if (uuid != null && !uuid.isEmpty()) {
                    publishEvent(new ReservationStatusUpdateEvent(this, uuid, "completed", null, dto.getJumuncode()));
                }
            } else {
                failCount.incrementAndGet();
                System.out.println("⚠️ 워커 " + workerId + " 실패: " + dto.getRcode() + 
                    (uuid != null ? " | UUID: " + uuid : ""));
                
                if (uuid != null && !uuid.isEmpty()) {
                    publishEvent(new ReservationStatusUpdateEvent(this, uuid, "failed", "시간 중복 또는 DB 오류", null));
                }
            }
            
            int total = totalProcessed.incrementAndGet();
            if (total % 20 == 0) {
                logProgress(total);
            }
            
        } catch (Exception e) {
            failCount.incrementAndGet();
            System.err.println("💥 워커 " + workerId + " 처리 에러: " + e.getMessage());
            
            if (uuid != null && !uuid.isEmpty()) {
                publishEvent(new ReservationStatusUpdateEvent(this, uuid, "failed", "시스템 에러: " + e.getMessage(), null));
            }
            
            e.printStackTrace();
        } finally {
            processingRequests.remove(key);
        }
    }

    // UUID별 처리 현황 조회
    public Map<String, Object> getReservationProgress(String uuid) {
        Map<String, Object> progress = new HashMap<>();
        
        boolean inQueue = queue.stream().anyMatch(dto -> 
            uuid.equals(dto.getModified_at())
        );
        
        boolean processing = processingRequests.values().stream().anyMatch(time -> 
            (System.currentTimeMillis() - time) < 30000
        );
        
        progress.put("inQueue", inQueue);
        progress.put("processing", processing);
        progress.put("queueSize", queue.size());
        progress.put("processingCount", processingRequests.size());
        
        return progress;
    }

    // 확장된 통계 정보
    public Map<String, Object> getStatistics() {
        Map<String, Object> stats = new ConcurrentHashMap<>();
        stats.put("success", successCount.get());
        stats.put("fail", failCount.get());
        stats.put("total", totalProcessed.get());
        stats.put("queueSize", queue.size());
        stats.put("queueCapacity", 1000);
        stats.put("processingCount", processingRequests.size());
        stats.put("threadPoolSize", 16);
        stats.put("batchMode", batchMode);
        stats.put("optimization", "8Core16Thread");
        
        long elapsed = System.currentTimeMillis() - startTime;
        double tps = totalProcessed.get() / Math.max(elapsed / 1000.0, 1.0);
        stats.put("tps", String.format("%.2f", tps));
        stats.put("successRate", String.format("%.1f%%", 
            (successCount.get() * 100.0) / Math.max(totalProcessed.get(), 1)));
        
        // 배치 통계 추가
        BatchReservationService batchService = getBatchReservationService();
        if (batchService != null) {
            Map<String, Object> batchStats = batchService.getBatchStatistics();
            stats.putAll(batchStats);
        }
        
        stats.put("uuidTrackedReservations", "UUID 추적 예약 수");
        
        return stats;
    }
}