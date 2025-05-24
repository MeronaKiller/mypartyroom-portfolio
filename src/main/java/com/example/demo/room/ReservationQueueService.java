package com.example.demo.room;

import com.example.demo.dto.ReservationDto;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.Map;
import java.util.HashMap;

@Service
public class ReservationQueueService {
    
    @Autowired
    private RoomMapper roomMapper;
    
    private final BlockingQueue<ReservationDto> queue = new LinkedBlockingQueue<>();
    private final ExecutorService executor = Executors.newFixedThreadPool(50);
    
    // 통계용
    private final AtomicInteger successCount = new AtomicInteger(0);
    private final AtomicInteger failCount = new AtomicInteger(0);
    private final AtomicInteger totalProcessed = new AtomicInteger(0);
    private final long startTime = System.currentTimeMillis();
    
    @PostConstruct
    public void init() {
        System.out.println("====================================");
        System.out.println("간단한 예약 처리 서비스 시작 - 스레드 수: 50");
        System.out.println("====================================");
        
        // 50개 워커 스레드 시작
        for (int i = 0; i < 50; i++) {
            final int workerId = i + 1;
            executor.submit(() -> {
                System.out.println("워커 " + workerId + " 시작됨");
                while (!Thread.currentThread().isInterrupted()) {
                    try {
                        // 큐에서 예약 데이터 가져오기 (블로킹)
                        ReservationDto dto = queue.take();
                        processReservation(dto, workerId);
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                        break;
                    } catch (Exception e) {
                        failCount.incrementAndGet();
                        System.err.println("워커 " + workerId + " 에러: " + e.getMessage());
                        e.printStackTrace();
                    }
                }
                System.out.println("워커 " + workerId + " 종료됨");
            });
        }
    }
    
    @PreDestroy
    public void destroy() {
        System.out.println("예약 처리 서비스 종료 중...");
        executor.shutdown();
    }
    
    // 큐에 예약 추가
    public void enqueue(ReservationDto dto) {
        try {
            queue.put(dto);
            System.out.println("큐에 추가됨: " + dto.getRcode() + " | " + 
                             dto.getStartTime() + "~" + dto.getEndTime() + 
                             " | 큐 크기: " + queue.size());
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            System.err.println("큐 추가 실패: " + e.getMessage());
        }
    }
    
    // 예약 처리
    private void processReservation(ReservationDto dto, int workerId) {
        try {
            System.out.println("워커 " + workerId + " 처리 시작: " + dto.getRcode() + 
                             " | " + dto.getStartTime() + "~" + dto.getEndTime());
            
            // 시간 충돌 확인
            boolean isAvailable = roomMapper.isTimeSlotAvailable(
                dto.getRcode(), 
                dto.getStartTime(), 
                dto.getEndTime()
            );
            
            if (isAvailable) {
                // DB에 예약 삽입
                roomMapper.reservOk(dto);
                successCount.incrementAndGet();
                System.out.println("워커 " + workerId + " 성공: " + dto.getRcode());
            } else {
                failCount.incrementAndGet();
                System.out.println("워커 " + workerId + " 실패 (시간 충돌): " + dto.getRcode());
            }
            
            // 진행 상황 로그
            int total = totalProcessed.incrementAndGet();
            if (total % 100 == 0) {
                logProgress(total);
            }
            
        } catch (Exception e) {
            failCount.incrementAndGet();
            System.err.println("워커 " + workerId + " DB 에러: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // 진행 상황 로그
    private void logProgress(int total) {
        long elapsed = System.currentTimeMillis() - startTime;
        double tps = total / (elapsed / 1000.0);
        
        System.out.printf("\n===== 처리 현황 =====\n");
        System.out.printf("총 처리: %d건\n", total);
        System.out.printf("성공: %d건\n", successCount.get());
        System.out.printf("실패: %d건\n", failCount.get());
        System.out.printf("TPS: %.2f\n", tps);
        System.out.printf("대기 큐: %d건\n", queue.size());
        System.out.printf("경과 시간: %.2f초\n", elapsed / 1000.0);
        System.out.println("==================\n");
    }
    
    // 통계 조회
    public Map<String, Object> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("success", successCount.get());
        stats.put("fail", failCount.get());
        stats.put("total", totalProcessed.get());
        stats.put("queueSize", queue.size());
        stats.put("threadPoolSize", 50);
        
        long elapsed = System.currentTimeMillis() - startTime;
        double tps = totalProcessed.get() / (elapsed / 1000.0);
        stats.put("tps", String.format("%.2f", tps));
        
        return stats;
    }
    
    // 큐 크기 조회
    public int getQueueSize() {
        return queue.size();
    }
}