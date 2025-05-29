package com.example.demo.room;

import com.example.demo.dto.ReservationDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Service
public class BatchReservationService {
    
    @Autowired
    private RoomMapper roomMapper;
    
    @Autowired
    private RedisLockService redisLockService;
    
    // 배치 처리용 큐
    private final Queue<ReservationDto> batchQueue = new ConcurrentLinkedQueue<>();
    private final int BATCH_SIZE = 2000; // 2000개씩 배치 처리
    
    // 통계
    private final AtomicInteger batchSuccessCount = new AtomicInteger(0);
    private final AtomicInteger batchFailCount = new AtomicInteger(0);
    
    // 배치 큐에 예약 추가
    public boolean addToBatch(ReservationDto dto) {
        return batchQueue.offer(dto);
    }
    
    // 1초마다 배치 처리 실행
    @Scheduled(fixedDelay = 300)
    @Transactional
    public void processBatch() {
        if (batchQueue.isEmpty()) {
            return;
        }
        
        // 배치 크기만큼 또는 큐의 모든 항목 가져오기
        List<ReservationDto> batch = new ArrayList<>();
        for (int i = 0; i < BATCH_SIZE && !batchQueue.isEmpty(); i++) {
            ReservationDto item = batchQueue.poll();
            if (item != null) {
                batch.add(item);
            }
        }
        
        if (batch.isEmpty()) {
            return;
        }
        
        System.out.println("🚀 배치 처리 시작: " + batch.size() + "건");
        
        // 방별로 그룹화하여 병렬 처리
        Map<String, List<ReservationDto>> groupedByRoom = batch.stream()
            .collect(Collectors.groupingBy(ReservationDto::getRcode));
        
        // 각 방별로 병렬 처리
        List<ReservationDto> validReservations = groupedByRoom.entrySet()
            .parallelStream()
            .flatMap(entry -> processRoomReservations(entry.getKey(), entry.getValue()).stream())
            .collect(Collectors.toList());
        
        // 유효한 예약들을 배치로 INSERT
        if (!validReservations.isEmpty()) {
            try {
                int insertedCount = roomMapper.insertReservationBatch(validReservations);
                batchSuccessCount.addAndGet(insertedCount);
                System.out.println("✅ 배치 INSERT 완료: " + insertedCount + "건 성공");
            } catch (Exception e) {
                batchFailCount.addAndGet(validReservations.size());
                System.err.println("❌ 배치 INSERT 실패: " + e.getMessage());
            }
        }
        
        int totalFailed = batch.size() - validReservations.size();
        if (totalFailed > 0) {
            batchFailCount.addAndGet(totalFailed);
            System.out.println("⚠️ 배치 처리 실패: " + totalFailed + "건 (시간 중복)");
        }
    }
    
    // 특정 방의 예약들 처리 (시간 충돌 검사)
    private List<ReservationDto> processRoomReservations(String rcode, List<ReservationDto> reservations) {
        String lockKey = "batch_lock_" + rcode;
        String lockValue = "batch_" + System.currentTimeMillis();
        
        // 방별 락 획득
        if (!redisLockService.tryLock(lockKey, lockValue, 5)) {
            System.out.println("🔒 배치 락 획득 실패: " + rcode);
            return Collections.emptyList();
        }
        
        try {
            List<ReservationDto> validReservations = new ArrayList<>();
            
            // 예약들을 시간순으로 정렬
            reservations.sort(Comparator.comparing(ReservationDto::getStartTime));
            
            for (ReservationDto reservation : reservations) {
                // 기존 예약과 충돌 검사
                int conflictCount = roomMapper.countConflictingReservations(reservation);
                
                if (conflictCount == 0) {
                    // 이미 처리된 예약들과도 충돌 검사
                    if (!hasConflictWithProcessed(reservation, validReservations)) {
                        validReservations.add(reservation);
                    }
                }
            }
            
            return validReservations;
            
        } finally {
            redisLockService.unlock(lockKey, lockValue);
        }
    }
    
    // 이미 처리된 예약들과 시간 충돌 검사
    private boolean hasConflictWithProcessed(ReservationDto newReservation, List<ReservationDto> processedReservations) {
        return processedReservations.stream().anyMatch(existing -> 
            existing.getRcode().equals(newReservation.getRcode()) &&
            isTimeOverlap(existing.getStartTime(), existing.getEndTime(), 
                         newReservation.getStartTime(), newReservation.getEndTime())
        );
    }
    
    // 시간 겹침 검사
    private boolean isTimeOverlap(String start1, String end1, String start2, String end2) {
        return start1.compareTo(end2) < 0 && end1.compareTo(start2) > 0;
    }
    
    // 배치 통계 조회
    public Map<String, Object> getBatchStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("batchQueueSize", batchQueue.size());
        stats.put("batchSuccess", batchSuccessCount.get());
        stats.put("batchFail", batchFailCount.get());
        stats.put("batchTotal", batchSuccessCount.get() + batchFailCount.get());
        return stats;
    }
    
    // 통계 초기화
    public void resetBatchStats() {
        batchSuccessCount.set(0);
        batchFailCount.set(0);
        batchQueue.clear();
    }
}