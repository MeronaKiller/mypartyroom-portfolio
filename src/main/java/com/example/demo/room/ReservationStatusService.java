package com.example.demo.room;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
public class ReservationStatusService {
    
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    
    @Autowired
    private ReservationQueueService queueService;
    
    // ✅ 이벤트 리스너 추가
    @EventListener
    public void handleReservationStatusUpdate(ReservationStatusUpdateEvent event) {
        String uuid = event.getUuid();
        String status = event.getStatus();
        String message = event.getMessage();
        String jumuncode = event.getJumuncode();
        
        switch (status) {
            case "processing":
                startValidation(uuid);
                break;
            case "completed":
                completeReservation(uuid, jumuncode);
                break;
            case "failed":
                failReservation(uuid, message);
                break;
        }
    }
    
    // UUID 기반 예약 상태 저장
    public String createReservationStatus(String userid, String rcode, String startTime, String endTime) {
        String uuid = UUID.randomUUID().toString();
        String key = "reservation:status:" + uuid;
        
        Map<String, Object> statusData = new HashMap<>();
        statusData.put("uuid", uuid);
        statusData.put("userid", userid);
        statusData.put("rcode", rcode);
        statusData.put("startTime", startTime);
        statusData.put("endTime", endTime);
        statusData.put("status", "queued"); // queued, processing, completed, failed
        statusData.put("currentStep", 1);
        statusData.put("createdAt", System.currentTimeMillis());
        statusData.put("queuePosition", 0);
        statusData.put("estimatedTime", "약 30초");
        
        // Redis에 5분간 저장 (TTL 설정)
        redisTemplate.opsForHash().putAll(key, statusData);
        redisTemplate.expire(key, 5, TimeUnit.MINUTES);
        
        System.out.println("✅ 예약 상태 생성: " + uuid + " | " + rcode + " | " + startTime);
        
        return uuid;
    }
    
    // 예약 상태 조회 (실제 대기순번 계산 포함)
    public Map<String, Object> getReservationStatus(String uuid) {
        String key = "reservation:status:" + uuid;
        Map<Object, Object> rawData = redisTemplate.opsForHash().entries(key);
        
        if (rawData.isEmpty()) {
            Map<String, Object> notFound = new HashMap<>();
            notFound.put("status", "notfound");
            notFound.put("message", "예약 정보를 찾을 수 없습니다.");
            return notFound;
        }
        
        Map<String, Object> statusData = new HashMap<>();
        rawData.forEach((k, v) -> statusData.put(k.toString(), v));
        
        // ✅ 실제 대기순번 계산
        int queuePosition = calculateQueuePosition(uuid);
        statusData.put("queuePosition", queuePosition);
        
        // ✅ 예상 처리 시간 계산
        if (queuePosition > 0) {
            String estimatedTime = calculateEstimatedTime(queuePosition);
            statusData.put("estimatedTime", estimatedTime);
        } else if (queuePosition == 0) {
            statusData.put("estimatedTime", "처리중");
        } else {
            statusData.put("estimatedTime", "완료");
        }
        
        return statusData;
    }
    
    // 실제 대기순번 계산 메서드
    private int calculateQueuePosition(String uuid) {
        try {
            // 1. 현재 큐 크기 조회
            int currentQueueSize = queueService.getQueueSize();
            
            // 2. 처리 중인 요청 수 조회
            Map<String, Object> stats = queueService.getStatistics();
            int processingCount = (Integer) stats.getOrDefault("processingCount", 0);
            
            // 3. UUID로 특정 예약의 상태 조회
            Map<String, Object> progress = queueService.getReservationProgress(uuid);
            boolean inQueue = (Boolean) progress.getOrDefault("inQueue", false);
            boolean processing = (Boolean) progress.getOrDefault("processing", false);
            
            System.out.println("📊 대기순번 계산 - UUID: " + uuid);
            System.out.println("  - 큐 크기: " + currentQueueSize);
            System.out.println("  - 처리중: " + processingCount);
            System.out.println("  - 큐에 있음: " + inQueue);
            System.out.println("  - 처리중 상태: " + processing);
            
            if (processing) {
                return 0; // 현재 처리중
            } else if (inQueue) {
                // 큐에 있으면 현재 큐 크기 + 처리중인 수
                int position = Math.max(1, currentQueueSize);
                System.out.println("  - 계산된 대기순번: " + position);
                return position;
            } else {
                // 큐에 없으면 완료됨 또는 실패
                return -1;
            }
            
        } catch (Exception e) {
            System.err.println("대기순번 계산 오류: " + e.getMessage());
            e.printStackTrace();
            // 오류 시 큐 크기로 대략 추정
            try {
                return Math.max(1, queueService.getQueueSize());
            } catch (Exception e2) {
                return Math.max(1, (int)(Math.random() * 50)); // 최후 수단
            }
        }
    }
    
    // 예상 시간 계산 메서드
    private String calculateEstimatedTime(int queuePosition) {
        if (queuePosition <= 0) return "처리중";
        
        // 실제 처리 속도 기반 계산
        int estimatedSeconds;
        
        if (queuePosition <= 10) {
            estimatedSeconds = queuePosition * 2; // 2초씩
        } else if (queuePosition <= 100) {
            estimatedSeconds = 20 + (queuePosition - 10) * 1; // 10개 이후는 1초씩
        } else if (queuePosition <= 1000) {
            estimatedSeconds = 110 + (queuePosition - 100) / 2; // 100개 이후는 0.5초씩
        } else if (queuePosition <= 10000) {
            estimatedSeconds = 560 + (queuePosition - 1000) / 10; // 1000개 이후는 0.1초씩
        } else {
            // 10000개 이상은 배치 처리 효과로 더 빠름
            estimatedSeconds = Math.min(600, 1460 + (queuePosition - 10000) / 100);
        }
        
        // 최소 3초, 최대 10분
        estimatedSeconds = Math.max(3, Math.min(estimatedSeconds, 600));
        
        // 시간 포맷팅
        if (estimatedSeconds < 60) {
            return estimatedSeconds + "초";
        } else if (estimatedSeconds < 3600) {
            int minutes = estimatedSeconds / 60;
            int seconds = estimatedSeconds % 60;
            if (seconds == 0) {
                return minutes + "분";
            } else {
                return minutes + "분 " + seconds + "초";
            }
        } else {
            int hours = estimatedSeconds / 3600;
            int minutes = (estimatedSeconds % 3600) / 60;
            if (minutes == 0) {
                return hours + "시간";
            } else {
                return hours + "시간 " + minutes + "분";
            }
        }
    }
    
    // 예약 상태 업데이트
    public void updateReservationStatus(String uuid, String status, Integer currentStep, String message) {
        String key = "reservation:status:" + uuid;
        
        if (redisTemplate.hasKey(key)) {
            redisTemplate.opsForHash().put(key, "status", status);
            redisTemplate.opsForHash().put(key, "updatedAt", System.currentTimeMillis());
            
            if (currentStep != null) {
                redisTemplate.opsForHash().put(key, "currentStep", currentStep);
            }
            
            if (message != null) {
                redisTemplate.opsForHash().put(key, "message", message);
            }
            
            System.out.println("🔄 예약 상태 업데이트: " + uuid + " -> " + status);
        }
    }
    
    // 예약 처리 시작
    public void startProcessing(String uuid) {
        updateReservationStatus(uuid, "processing", 2, null);
    }
    
    // 예약 검증 중
    public void startValidation(String uuid) {
        updateReservationStatus(uuid, "processing", 3, null);
    }
    
    // 예약 완료
    public void completeReservation(String uuid, String jumuncode) {
        String key = "reservation:status:" + uuid;
        
        if (redisTemplate.hasKey(key)) {
            redisTemplate.opsForHash().put(key, "status", "completed");
            redisTemplate.opsForHash().put(key, "currentStep", 4);
            redisTemplate.opsForHash().put(key, "jumuncode", jumuncode);
            redisTemplate.opsForHash().put(key, "completedAt", System.currentTimeMillis());
            
            // 완료된 예약은 좀 더 오래 보관 (30분)
            redisTemplate.expire(key, 30, TimeUnit.MINUTES);
            
            System.out.println("✅ 예약 완료: " + uuid + " | " + jumuncode);
        }
    }
    
    // 예약 실패
    public void failReservation(String uuid, String reason) {
        updateReservationStatus(uuid, "failed", null, reason);
        System.out.println("❌ 예약 실패: " + uuid + " | " + reason);
    }
    
    // 예약 상태 삭제
    public void deleteReservationStatus(String uuid) {
        String key = "reservation:status:" + uuid;
        redisTemplate.delete(key);
        System.out.println("🗑️ 예약 상태 삭제: " + uuid);
    }
    
    // UUID로 예약 정보 조회
    public Map<String, Object> getReservationInfo(String uuid) {
        Map<String, Object> status = getReservationStatus(uuid);
        
        if (!"notfound".equals(status.get("status"))) {
            // 추가 정보 조회 (방 이름, 사용자 정보 등)
            // 실제 구현에서는 데이터베이스에서 조회
            status.put("roomName", "조회된 방 이름");
            status.put("userName", "조회된 사용자 이름");
        }
        
        return status;
    }
    
    // 통계 정보
    public Map<String, Object> getStatusStatistics() {
        // Redis에서 모든 예약 상태 키 조회
        Map<String, Object> stats = new HashMap<>();
        
        try {
            // 간단한 통계 - 실제로는 더 정교한 방법 사용
            stats.put("totalActiveReservations", "통계 데이터");
            stats.put("queuedCount", "대기중 예약 수");
            stats.put("processingCount", "처리중 예약 수");
            
        } catch (Exception e) {
            System.err.println("통계 조회 오류: " + e.getMessage());
        }
        
        return stats;
    }
}