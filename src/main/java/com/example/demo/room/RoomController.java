package com.example.demo.room;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

@Controller
public class RoomController {
	@Autowired
	@Qualifier("rs")
	private RoomService service;
	
	@Autowired
    private ReservationQueueService queueService;
	
	@GetMapping("/room/roomInfo")
	public String roomInfo(HttpServletRequest request, Model model,RoomDto rdto)
	{
		return service.roomInfo(request,model,rdto);
	}
	@GetMapping("/room/roomList")
	public String roomList(HttpServletRequest request,Model model, RoomDto rdto)
	{
	    return service.roomList(request,model,rdto);
	}
	@GetMapping("/room/roomContent")
	public String roomContent(HttpServletRequest request, Model model,
	        HttpSession session, RoomDto rdto, ReservationDto rsdto) {
	    String userId = (String) session.getAttribute("userid");
	    
	    // roomid가 null인 경우를 방지
	    if (rdto.getRoomid() > 0) {
	        // userId가 null이어도 isLikedByUser 메서드가 null을 반환하지 않도록 수정됨
	        boolean likedByUser = service.isLikedByUser(userId, rdto.getRoomid());
	        model.addAttribute("likedByUser", likedByUser);
	    } else {
	        model.addAttribute("likedByUser", false);
	    }
	    
	    return service.roomContent(request, model, session, rdto, rsdto);
	}

	@GetMapping("/room/roomReserv")
	public String reservationOk(HttpServletRequest request,HttpSession session,Model model)
	{
		return service.roomReserv(request,session,model);
	}
	@PostMapping("/room/reservOk")
	public String reservOk(ReservationDto rsdto,HttpSession session)
	{
		return service.reservOk(rsdto,session);
	}
	@GetMapping("/room/reservList")
	public String reservList(HttpSession session, HttpServletRequest request,Model model,MemberDto mdto, ReservationDto rsdto,RoomDto rdto)
	{
		return service.reservList(session,request,model,mdto,rsdto,rdto);
	}
	@GetMapping("/room/getReservTime")
	public @ResponseBody ArrayList<ReservationDto> getReservTime(HttpServletRequest request)
	{
		return service.getReservTime(request);
	}
	@GetMapping("/room/reservChk")
	public String reservChk(HttpSession session, HttpServletRequest request,Model model,MemberDto mdto, ReservationDto rsdto,RoomDto rdto)
	{
		return service.reservChk(session,request,model,mdto,rsdto,rdto);
	}
	@GetMapping("/room/like")
	public String likeRoom(HttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes) {
	    // 로그인 확인
	    String userId = (String) session.getAttribute("userid");
	    if (userId == null) {
	        // 로그인 안 된 경우 로그인 페이지로 리다이렉트
	        redirectAttributes.addFlashAttribute("message", "로그인 후 이용 가능합니다.");
	        return "redirect:/login/login";
	    }
	    
	    // 좋아요 처리
	    int roomid = Integer.parseInt(request.getParameter("roomid"));
	    service.increaseRoomLike(roomid); // 직접 increaseRoomLike만 호출
	    
	    // 리다이렉트 주소 가져오기
	    String redirect = request.getParameter("redirect");
	    if (redirect == null || redirect.isEmpty()) {
	        redirect = "/room/roomContent?rcode=" + service.getRcodeByroomid(roomid);
	    }
	    
	    return "redirect:" + redirect;
	}

    @GetMapping("/room/unlike")
    public String unlikeRoom(HttpServletRequest request, HttpSession session) {
        // 로그인 확인
        String userId = (String) session.getAttribute("userid");
        if (userId == null) {
            return "redirect:/login/login";
        }
        
        // 좋아요 취소 처리
        int roomid = Integer.parseInt(request.getParameter("roomid"));
        service.removeLike(userId, roomid); // service 객체 사용, 변수명 수정
        
        // 리다이렉트 주소 가져오기
        String redirect = request.getParameter("redirect");
        if (redirect == null || redirect.isEmpty()) {
            redirect = "/room/roomContent?rcode=" + service.getRcodeByroomid(roomid); // service 객체 사용
        }
        
        return "redirect:" + redirect;
    }
    @GetMapping("/room/like/{roomid}")
    public String likeRoomWithCookie(@PathVariable int roomid, HttpServletRequest request, HttpServletResponse response) {
        // 해당 방에 대한 좋아요 쿠키 이름
        String cookieName = "room_liked_" + roomid;
        
        // 쿠키 확인
        Cookie[] cookies = request.getCookies();
        boolean alreadyLiked = false;
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookieName.equals(cookie.getName())) {
                    alreadyLiked = true;
                    break;
                }
            }
        }
        // 아직 좋아요를 누르지 않은 경우에만 좋아요 증가
        if (!alreadyLiked) {
            service.increaseRoomLike(roomid);
            
            // 좋아요 쿠키 설정 (24시간 유효)
            Cookie likeCookie = new Cookie(cookieName, "true");
            likeCookie.setMaxAge(60 * 60 * 24); // 24시간 (초 단위)
            likeCookie.setPath("/");
            response.addCookie(likeCookie);
        }
        
        return "redirect:/room/roomContent?rcode=" + service.getRcodeByroomid(roomid);
    }
    
    @GetMapping("/room/reservFailure")
	    public String reservFailure() {
	        return "/room/reservFailure";
	    }

    @GetMapping("/room/queueStats")
    @ResponseBody
    public Map<String, Object> getQueueStatistics() {
        return queueService.getStatistics();
    }
    
 // ✅ 상세 통계 API
    @GetMapping("/room/detailedStats")
    @ResponseBody
    public Map<String, Object> getDetailedStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        // 큐 서비스 통계
        Map<String, Object> queueStats = queueService.getStatistics();
        stats.putAll(queueStats);
        
        // 배치 서비스 통계
        stats.putAll(batchReservationService.getBatchStatistics());
        
        // 시스템 정보
        Runtime runtime = Runtime.getRuntime();
        stats.put("totalMemory", runtime.totalMemory() / 1024 / 1024 + " MB");
        stats.put("freeMemory", runtime.freeMemory() / 1024 / 1024 + " MB");
        stats.put("usedMemory", (runtime.totalMemory() - runtime.freeMemory()) / 1024 / 1024 + " MB");
        stats.put("availableProcessors", runtime.availableProcessors());
        
        return stats;
    }

    // ✅ 배치 모드 수동 전환 API
    @PostMapping("/room/setBatchMode")
    @ResponseBody
    public Map<String, Object> setBatchMode(@RequestParam boolean enabled) {
        queueService.setBatchMode(enabled);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("batchMode", enabled);
        response.put("message", "배치 모드가 " + (enabled ? "활성화" : "비활성화") + "되었습니다.");
        
        return response;
    }

    // ✅ 통계 초기화 API
    @PostMapping("/room/resetStats")
    @ResponseBody
    public Map<String, Object> resetStatistics() {
        queueService.resetStats();
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "모든 통계가 초기화되었습니다.");
        
        return response;
    }

    // ✅ 대용량 테스트용 API
    @PostMapping("/room/bulkTest")
    @ResponseBody
    public Map<String, Object> bulkTest(@RequestParam(defaultValue = "100") int count) {
        long startTime = System.currentTimeMillis();
        int successCount = 0;
        
        for (int i = 0; i < count; i++) {
            ReservationDto dto = createTestReservation(i);
            boolean added = queueService.enqueue(dto);
            if (added) {
                successCount++;
            }
        }
        
        long endTime = System.currentTimeMillis();
        
        Map<String, Object> response = new HashMap<>();
        response.put("totalRequests", count);
        response.put("successCount", successCount);
        response.put("failCount", count - successCount);
        response.put("processingTime", endTime - startTime + " ms");
        response.put("requestsPerSecond", count * 1000.0 / (endTime - startTime));
        
        return response;
    }

 // 테스트용 예약 데이터 생성 (디버깅 강화)
    private ReservationDto createTestReservation(int index) {
        ReservationDto dto = new ReservationDto();
        
        // ✅ 시간 분산을 위한 개선된 로직
        LocalDateTime baseTime = LocalDateTime.now().plusDays(index / 10); // 날짜 분산
        
        // 시간대를 더 넓게 분산 (24시간 기준)
        int hourOffset = (index * 3) % 24; // 3시간씩 분산
        int minuteOffset = (index * 17) % 60; // 분 단위 분산
        
        LocalDateTime startTime = baseTime.withHour(9).withMinute(0).withSecond(0)
            .plusHours(hourOffset).plusMinutes(minuteOffset);
        
        // 예약 시간을 1-3시간으로 다양화
        int duration = (index % 3) + 1;
        LocalDateTime endTime = startTime.plusHours(duration);
        
        // 방 코드를 더 다양하게 분산
        String[] roomCodes = {"r0102001", "r0102002", "r0102003", "r0102004", "r0102005", 
                             "r0102006", "r0102007", "r0102008", "r0102009", "r0102010"};
        dto.setRcode(roomCodes[index % roomCodes.length]);
        
        dto.setSelectedDate(startTime.toLocalDate().toString());
        dto.setStartTime(startTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        dto.setEndTime(endTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        dto.setUserid("testuser" + (index % 100)); // 사용자도 분산
        dto.setTel(1012345000 + index);
        dto.setCard1(1);
        dto.setReservprice(50000 + (index % 5) * 10000); // 가격 다양화
        dto.setPurposeuse("테스트 예약 " + index);
        dto.setRequesttohost("테스트 요청 " + index);
        
        // 주문코드 생성 (중복 방지)
        String today = LocalDate.now().toString().replace("-", "");
        dto.setJumuncode("j" + today + String.format("%05d", index));
        
        System.out.println("🔧 테스트 데이터 생성 [" + index + "]: " + 
            dto.getRcode() + " | " + dto.getStartTime() + " ~ " + dto.getEndTime());
        
        return dto;
    }
    
    @Autowired
    private BatchReservationService batchReservationService;
    
    @PostMapping("/room/advancedBulkTest")
    @ResponseBody
    public Map<String, Object> advancedBulkTest(
        @RequestParam(defaultValue = "100") int count,
        @RequestParam(defaultValue = "5") int roomCount,
        @RequestParam(defaultValue = "true") boolean enableBatch) {
        
        long startTime = System.currentTimeMillis();
        
        // 배치 모드 설정
        queueService.setBatchMode(enableBatch);
        
        // 통계 초기화
        queueService.resetStats();
        
        int successCount = 0;
        List<String> errors = new ArrayList<>();
        
        for (int i = 0; i < count; i++) {
            try {
                ReservationDto dto = createAdvancedTestReservation(i, roomCount);
                boolean added = queueService.enqueue(dto);
                if (added) {
                    successCount++;
                } else {
                    errors.add("큐 추가 실패: " + i);
                }
            } catch (Exception e) {
                errors.add("생성 오류 [" + i + "]: " + e.getMessage());
            }
        }
        
        // 처리 완료까지 대기 (최대 30초)
        int waitCount = 0;
        while (queueService.getQueueSize() > 0 && waitCount < 30) {
            try {
                Thread.sleep(1000);
                waitCount++;
            } catch (InterruptedException e) {
                break;
            }
        }
        
        long endTime = System.currentTimeMillis();
        Map<String, Object> stats = queueService.getStatistics();
        
        Map<String, Object> response = new HashMap<>();
        response.put("totalRequests", count);
        response.put("enqueueSuccess", successCount);
        response.put("enqueueFailed", count - successCount);
        response.put("processingStats", stats);
        response.put("totalTime", endTime - startTime + " ms");
        response.put("errors", errors.size() > 10 ? errors.subList(0, 10) : errors);
        response.put("batchModeUsed", enableBatch);
        
        return response;
    }

    // ✅ 개선된 테스트 데이터 생성
    private ReservationDto createAdvancedTestReservation(int index, int roomCount) {
        ReservationDto dto = new ReservationDto();
        
        // 더 넓은 시간대 분산 (7일에 걸쳐)
        int dayOffset = index / 20; // 20개씩 하루에 분산
        int hourOffset = (index % 20) + 9; // 9시~28시 (다음날 4시까지)
        int minuteOffset = (index * 13) % 60; // 분 단위 분산
        
        LocalDateTime startTime = LocalDateTime.now()
            .plusDays(dayOffset)
            .withHour(hourOffset % 24)
            .withMinute(minuteOffset)
            .withSecond(0)
            .withNano(0);
        
        // 시간이 과거로 가지 않도록 조정
        if (startTime.isBefore(LocalDateTime.now())) {
            startTime = LocalDateTime.now().plusMinutes(index + 10);
        }
        
        // 예약 시간 다양화 (1-4시간)
        int duration = (index % 4) + 1;
        LocalDateTime endTime = startTime.plusHours(duration);
        
        // 방 코드 분산
        dto.setRcode("r010200" + (1 + (index % roomCount)));
        dto.setSelectedDate(startTime.toLocalDate().toString());
        dto.setStartTime(startTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        dto.setEndTime(endTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        
        // 사용자 정보
        dto.setUserid("testuser" + (index % 50)); // 50명의 사용자로 분산
        dto.setTel(1012345000 + index);
        dto.setCard1(1);
        dto.setReservprice(30000 + (index % 10) * 5000);
        dto.setPurposeuse("고급테스트 " + index);
        dto.setRequesttohost("대용량처리테스트 " + index);
        
        // 고유 주문코드
        String today = LocalDate.now().toString().replace("-", "");
        dto.setJumuncode("j" + today + String.format("%06d", index));
        
        return dto;
    }

    // 실시간 모니터링 API
    @GetMapping("/room/realTimeStats")
    @ResponseBody
    public Map<String, Object> getRealTimeStats() {
        Map<String, Object> stats = queueService.getStatistics();
        
        // 추가 시스템 정보
        Runtime runtime = Runtime.getRuntime();
        stats.put("systemInfo", Map.of(
            "totalMemory", runtime.totalMemory() / 1024 / 1024 + " MB",
            "freeMemory", runtime.freeMemory() / 1024 / 1024 + " MB",
            "usedMemory", (runtime.totalMemory() - runtime.freeMemory()) / 1024 / 1024 + " MB",
            "availableProcessors", runtime.availableProcessors(),
            "activeThreads", Thread.activeCount()
        ));
        
        return stats;
    }

    // ✅ 처리 속도 벤치마크
    @PostMapping("/room/speedTest")
    @ResponseBody
    public Map<String, Object> speedTest(@RequestParam(defaultValue = "10") int batchSize) {
        Map<String, Object> results = new HashMap<>();
        
        // 1. 단일 처리 모드 테스트
        queueService.setBatchMode(false);
        queueService.resetStats();
        
        long singleStart = System.currentTimeMillis();
        for (int i = 0; i < batchSize; i++) {
            queueService.enqueue(createAdvancedTestReservation(i, 3));
        }
        
        // 완료 대기
        while (queueService.getQueueSize() > 0) {
            try { Thread.sleep(100); } catch (InterruptedException e) { break; }
        }
        long singleEnd = System.currentTimeMillis();
        Map<String, Object> singleStats = queueService.getStatistics();
        
        // 2. 배치 처리 모드 테스트
        queueService.setBatchMode(true);
        queueService.resetStats();
        
        long batchStart = System.currentTimeMillis();
        for (int i = batchSize; i < batchSize * 2; i++) {
            queueService.enqueue(createAdvancedTestReservation(i, 3));
        }
        
        // 완료 대기
        try { Thread.sleep(3000); } catch (InterruptedException e) {}
        long batchEnd = System.currentTimeMillis();
        Map<String, Object> batchStats = queueService.getStatistics();
        
        results.put("singleMode", Map.of(
            "time", singleEnd - singleStart + " ms",
            "stats", singleStats
        ));
        
        results.put("batchMode", Map.of(
            "time", batchEnd - batchStart + " ms", 
            "stats", batchStats
        ));
        
        return results;
    }
    
}