package com.example.demo.room;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

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
    private RoomMapper mapper;
    
    private static final String QUEUE_KEY = "reservation_queue";
    
    // 큐에 예약 추가
    public void addToQueue(ReservationDto rdto) {
        redisTemplate.opsForList().rightPush(QUEUE_KEY, rdto);
        System.out.println("큐에 추가됨: " + rdto.getJumuncode());
    }

    // 1초마다 큐 처리
    @Scheduled(fixedDelay = 1000)
    public void processQueue() {
        ReservationDto rdto = (ReservationDto) redisTemplate
            .opsForList().leftPop(QUEUE_KEY);

        if (rdto != null) {
            System.out.println("큐에서 처리 시작: " + rdto.getJumuncode());
            processReservation(rdto);
        }
    }
    
    private void processReservation(ReservationDto rdto) {
        try {
            // 시간대 중복 확인
            boolean isAvailable = mapper.isTimeSlotAvailable(
                rdto.getRcode(), 
                rdto.getStartTime(), 
                rdto.getEndTime()
            );
            
            if (isAvailable) {
                // 예약 삽입
                mapper.reservOk(rdto); // insertReservationWithCheck 대신 기존 메서드 사용
                System.out.println("예약 성공: " + rdto.getJumuncode());
            } else {
                System.out.println("예약 실패 (시간 충돌): " + rdto.getJumuncode());
            }
        } catch (Exception e) {
            System.err.println("예약 처리 중 오류: " + e.getMessage());
            e.printStackTrace();
        }
    }
}