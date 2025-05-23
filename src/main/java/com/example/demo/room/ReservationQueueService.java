package com.example.demo.room;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.example.demo.dto.ReservationDto;

@Service
public class ReservationQueueService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    
    @Autowired
    private RoomMapper mapper; // 데이터베이스 작업을 위해 추가
    
    public void addToQueue(ReservationDto rdto) {
        redisTemplate.opsForList().rightPush("reservation_queue", rdto);
    }

    @Scheduled(fixedDelay = 1000) // 1초마다 실행
    public void processQueue() {
        ReservationDto rdto = (ReservationDto) redisTemplate
            .opsForList().leftPop("reservation_queue");

        if (rdto != null) {
            // 예약 처리 로직
            processReservation(rdto);
        }
    }
    
    // processReservation 메서드 추가
    private void processReservation(ReservationDto rdto) {
        try {
            // 시간대 가능 여부 확인
            boolean isAvailable = mapper.isTimeSlotAvailable(
                rdto.getRcode(), 
                rdto.getStartTime(), 
                rdto.getEndTime()
            );
            
            if (isAvailable) {
                // 예약 삽입 시도
                int result = mapper.insertReservationWithCheck(rdto);
                
                if (result > 0) {
                    System.out.println("예약 성공: " + rdto.getJumuncode());
                } else {
                    System.out.println("예약 실패 (동시성): " + rdto.getJumuncode());
                }
            } else {
                System.out.println("예약 실패 (시간 충돌): " + rdto.getJumuncode());
            }
        } catch (Exception e) {
            System.err.println("예약 처리 중 오류: " + e.getMessage());
            // 실패한 예약을 다시 큐에 넣거나 별도 처리
        }
    }
}