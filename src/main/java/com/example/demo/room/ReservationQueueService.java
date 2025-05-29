package com.example.demo.room;

import com.example.demo.dto.ReservationDto;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;

@Service
public class ReservationQueueService {
    
    @Autowired
    private RoomMapper roomMapper;
    
    @Autowired
    private BatchReservationService batchReservationService;
    
    // ✅ 8코어 최적화: 스레드 수와 큐 크기 조정
    private final BlockingQueue<ReservationDto> queue = new LinkedBlockingQueue<>(1000);
    private final ExecutorService executor = Executors.newFixedThreadPool(16);
    
    // 통계용
    private final AtomicInteger successCount = new AtomicInteger(0);
    private final AtomicInteger failCount = new AtomicInteger(0);
    private final AtomicInteger totalProcessed = new AtomicInteger(0);
    private final long startTime = System.currentTimeMillis();
    
    // 처리 중인 요청 추적 (중복 방지용)
    private final Map<String, Long> processingRequests = new ConcurrentHashMap<>();
    
    // ✅ 배치 모드 플래그
    private volatile boolean batchMode = false;
    
    @PostConstruct
    public void init() {
        System.out.println("====================================");
        System.out.println("⚡ 8코어 16스레드 최적화 - 워커 수: 16");
        System.out.println("====================================");
        
        // ✅ 16개 워커 스레드 시작 (8코어 최적화)
        for (int i = 0; i < 16; i++) {
            final int workerId = i + 1;
            executor.submit(() -> {
                System.out.println("⚡ 워커 " + workerId + " 시작됨 (8C16T 최적화)");
                while (!Thread.currentThread().isInterrupted()) {
                    try {
                        // ✅ 대기 시간 단축 (CPU 효율)
                        ReservationDto dto = queue.poll(500, TimeUnit.MILLISECONDS);
                        if (dto != null) {
                            // ✅ 배치 모드 체크 (임계값 조정)
                            if (batchMode && queue.size() > 50) {
                                // 배치 처리로 전환
                                batchReservationService.addToBatch(dto);
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
        
        // ✅ 동적 배치 모드 전환 스레드 (임계값 조정)
        executor.submit(() -> {
            while (!Thread.currentThread().isInterrupted()) {
                try {
                    Thread.sleep(2000);
                    
                    int queueSize = queue.size();
                    
                    // ✅ 8코어 기준 임계값 조정
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
        
        // 처리 중인 요청 정리 스레드 (주기 단축)
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
    
    // ✅ 개선된 큐 추가 로직 (8코어 최적화)
    public boolean enqueue(ReservationDto dto) {
        // 템플릿 변수 검증
        if (dto.getStartTime().contains("{{") || dto.getEndTime().contains("{{")) {
            System.err.println("❌ 템플릿 변수가 치환되지 않음: " + dto.getStartTime());
            return false;
        }
        
        String key = dto.getRcode() + "_" + dto.getStartTime() + "_" + dto.getEndTime();
        long currentTime = System.currentTimeMillis();
        
        // ✅ 중복 체크 시간 단축 (3초 → 2초)
        Long lastProcessTime = processingRequests.get(key);
        if (lastProcessTime != null && (currentTime - lastProcessTime) < 2000) {
            System.out.println("🔄 최근 중복 요청 무시: " + key + " (2초 이내)");
            return false;
        }
        
        // ✅ 큐 포화 방지 (80% 임계값)
        if (queue.size() > 800) {
            System.err.println("❌ 큐 포화 방지: " + queue.size() + "/1000");
            return false;
        }
        
        // 처리 중인 요청으로 등록
        processingRequests.put(key, currentTime);
        
        // ✅ 배치 모드일 때는 배치 큐로 직접 전송 (임계값 조정)
        if (batchMode && queue.size() > 100) {
            boolean added = batchReservationService.addToBatch(dto);
            if (added) {
                System.out.println("🚀 배치 큐 추가: " + dto.getRcode());
            }
            return added;
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
    
    // 처리 중인 요청 정리 (시간 단축)
    private void cleanupProcessingRequests() {
        long currentTime = System.currentTimeMillis();
        processingRequests.entrySet().removeIf(entry -> 
            (currentTime - entry.getValue()) > 10000
        );
        System.out.println("🧹 처리 중인 요청 정리 완료. 남은 수: " + processingRequests.size());
    }
    
    // ✅ 최적화된 예약 처리 (락 제거)
    @Transactional
    private void processReservationWithLock(ReservationDto dto, int workerId) {
        String key = dto.getRcode() + "_" + dto.getStartTime() + "_" + dto.getEndTime();
        
        try {
            System.out.println("🔍 워커 " + workerId + " 처리 시작: " + dto.getRcode() + 
                " | " + dto.getStartTime() + " ~ " + dto.getEndTime());
            
            // 실제 예약 처리
            boolean success = processReservation(dto, workerId);
            
            if (success) {
                successCount.incrementAndGet();
                System.out.println("✅ 워커 " + workerId + " 성공: " + dto.getRcode());
            } else {
                failCount.incrementAndGet();
                System.out.println("⚠️ 워커 " + workerId + " 실패: " + dto.getRcode());
            }
            
            // ✅ 로그 주기 조정 (8코어 기준)
            int total = totalProcessed.incrementAndGet();
            if (total % 20 == 0) {
                logProgress(total);
            }
            
        } catch (Exception e) {
            failCount.incrementAndGet();
            System.err.println("💥 워커 " + workerId + " 처리 에러: " + e.getMessage());
            e.printStackTrace();
        } finally {
            processingRequests.remove(key);
        }
    }

    // 실제 예약 처리 로직 (개선됨)
    private boolean processReservation(ReservationDto dto, int workerId) {
        try {
            System.out.println("🔍 워커 " + workerId + " DB 처리 시작: " + dto.getRcode());
            
            // 데이터 검증
            if (dto.getRcode() == null || dto.getStartTime() == null || dto.getEndTime() == null) {
                System.err.println("❌ 워커 " + workerId + " 필수 데이터 누락");
                return false;
            }
            
            // ✅ 시간 유효성 검사 추가
            if (dto.getStartTime().compareTo(dto.getEndTime()) >= 0) {
                System.err.println("❌ 워커 " + workerId + " 잘못된 시간 범위");
                return false;
            }
            
            long checkStart = System.currentTimeMillis();
            int conflictCount = roomMapper.countConflictingReservations(dto);
            long checkEnd = System.currentTimeMillis();
            
            System.out.println("🔍 워커 " + workerId + " 충돌 검사 완료: " + conflictCount + "건 (" + 
                (checkEnd - checkStart) + "ms)");
            
            if (conflictCount > 0) {
                System.out.println("⚠️ 워커 " + workerId + " 시간 충돌로 실패: " + dto.getRcode());
                return false;
            }
            
            System.out.println("💾 워커 " + workerId + " INSERT 실행 중...");
            long insertStart = System.currentTimeMillis();
            int result = roomMapper.insertReservationSimple(dto);
            long insertEnd = System.currentTimeMillis();
            
            System.out.println("💾 워커 " + workerId + " INSERT 완료: " + result + " (" + 
                (insertEnd - insertStart) + "ms)");
            
            return result > 0;
            
        } catch (Exception e) {
            System.err.println("💥 워커 " + workerId + " DB 에러: " + e.getMessage());
            return false;
        }
    }
    
    // 진행 상황 로그 (8코어 최적화 정보 포함)
    private void logProgress(int total) {
        long elapsed = System.currentTimeMillis() - startTime;
        double tps = total / Math.max(elapsed / 1000.0, 1.0);
        
        System.out.printf("\n⚡===== 8코어 최적화 처리 현황 =====\n");
        System.out.printf("총 처리: %d건\n", total);
        System.out.printf("성공: %d건\n", successCount.get());
        System.out.printf("실패: %d건\n", failCount.get());
        System.out.printf("성공률: %.1f%%\n", (successCount.get() * 100.0) / Math.max(total, 1));
        System.out.printf("TPS: %.2f (8코어 최적화)\n", tps);
        System.out.printf("대기 큐: %d건 (최대: 1000)\n", queue.size());
        System.out.printf("처리 중: %d건\n", processingRequests.size());
        System.out.printf("배치 모드: %s\n", batchMode ? "활성" : "비활성");
        System.out.printf("워커 스레드: 16개 (8코어 최적화)\n");
        System.out.printf("경과 시간: %.2f초\n", elapsed / 1000.0);
        System.out.println("==================\n");
    }
    
    // ✅ 확장된 통계 조회 (8코어 정보 포함)
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
        Map<String, Object> batchStats = batchReservationService.getBatchStatistics();
        stats.putAll(batchStats);
        
        return stats;
    }
    
    // 배치 모드 수동 전환
    public void setBatchMode(boolean enabled) {
        this.batchMode = enabled;
        System.out.println("🔧 배치 모드 " + (enabled ? "활성화" : "비활성화") + " (8코어 최적화)");
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
        batchReservationService.resetBatchStats();
        System.out.println("📊 모든 통계 및 큐 초기화 완료 (8코어 최적화)");
    }
}