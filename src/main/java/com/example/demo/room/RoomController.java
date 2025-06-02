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
import org.springframework.context.ApplicationContext;

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
    private ApplicationContext applicationContext;
    
    @Qualifier("rs")
    private RoomService getService() {
        return applicationContext.getBean("rs", RoomService.class);
    }
    
    private ReservationQueueService getQueueService() {
        return applicationContext.getBean(ReservationQueueService.class);
    }
    
    private ReservationStatusService getReservationStatusService() {
        return applicationContext.getBean(ReservationStatusService.class);
    }
    
    private BatchReservationService getBatchReservationService() {
        return applicationContext.getBean(BatchReservationService.class);
    }
    
    private RoomMapper getMapper() {
        return applicationContext.getBean(RoomMapper.class);
    }
    
    @GetMapping("/room/roomInfo")
    public String roomInfo(HttpServletRequest request, Model model, RoomDto rdto) {
        return getService().roomInfo(request, model, rdto);
    }
    
    @GetMapping("/room/roomList")
    public String roomList(HttpServletRequest request, Model model, RoomDto rdto) {
        return getService().roomList(request, model, rdto);
    }
    
    @GetMapping("/room/roomContent")
    public String roomContent(HttpServletRequest request, Model model,
            HttpSession session, RoomDto rdto, ReservationDto rsdto) {
        String userId = (String) session.getAttribute("userid");
        
        // roomid가 null인 경우를 방지
        if (rdto.getRoomid() > 0) {
            // userId가 null이어도 isLikedByUser 메서드가 null을 반환하지 않도록 수정됨
            boolean likedByUser = getService().isLikedByUser(userId, rdto.getRoomid());
            model.addAttribute("likedByUser", likedByUser);
        } else {
            model.addAttribute("likedByUser", false);
        }
        
        return getService().roomContent(request, model, session, rdto, rsdto);
    }

    @GetMapping("/room/roomReserv")
    public String reservationOk(HttpServletRequest request, HttpSession session, Model model) {
        return getService().roomReserv(request, session, model);
    }
    
    // ✅ UUID 지원 예약 처리 메서드)
    @PostMapping("/room/reservOk")
    public String reservOk(ReservationDto rsdto, HttpSession session, Model model) {
        
        System.out.println("🔍 =================== reservOk 시작 ===================");
        System.out.println("📋 받은 데이터:");
        System.out.println("  - rcode: " + rsdto.getRcode());
        System.out.println("  - selectedDate: " + rsdto.getSelectedDate());
        System.out.println("  - startTime: " + rsdto.getStartTime());
        System.out.println("  - endTime: " + rsdto.getEndTime());
        System.out.println("  - reservprice: " + rsdto.getReservprice());
        System.out.println("  - purposeuse: " + rsdto.getPurposeuse());
        System.out.println("  - tel: " + rsdto.getTel());
        System.out.println("  - card1: " + rsdto.getCard1());
        
        try {
            // ✅ 1. 기본 검증 (로그 추가)
            System.out.println("🔍 Step 1: 기본 검증 시작");
            
            if (rsdto.getRcode() == null || rsdto.getRcode().trim().isEmpty()) {
                System.err.println("❌ FAIL: rcode가 null 또는 빈값 - " + rsdto.getRcode());
                return "redirect:/room/reservFailure";
            }
            System.out.println("✅ rcode 검증 통과: " + rsdto.getRcode());
            
            if (rsdto.getSelectedDate() == null || rsdto.getSelectedDate().trim().isEmpty()) {
                System.err.println("❌ FAIL: selectedDate가 null 또는 빈값 - " + rsdto.getSelectedDate());
                return "redirect:/room/reservFailure";
            }
            System.out.println("✅ selectedDate 검증 통과: " + rsdto.getSelectedDate());
            
            if (rsdto.getStartTime() == null || rsdto.getEndTime() == null) {
                System.err.println("❌ FAIL: startTime 또는 endTime이 null");
                System.err.println("  startTime: " + rsdto.getStartTime());
                System.err.println("  endTime: " + rsdto.getEndTime());
                return "redirect:/room/reservFailure";
            }
            System.out.println("✅ 시간 검증 통과: " + rsdto.getStartTime() + " ~ " + rsdto.getEndTime());
            
            // ✅ 2. 세션 검증 (로그 추가)
            System.out.println("🔍 Step 2: 세션 검증 시작");
            String userid = (String) session.getAttribute("userid");
            if (userid == null) {
                System.out.println("⚠️ WARNING: 세션에 userid 없음, testuser 사용");
                userid = "testuser";
            }
            System.out.println("✅ 사용자 ID 설정: " + userid);
            rsdto.setUserid(userid);
            
            // ✅ 3. Mapper 검증 (로그 추가)
            System.out.println("🔍 Step 3: Mapper 검증 시작");
            try {
                RoomMapper mapper = getMapper();
                if (mapper == null) {
                    System.err.println("❌ FAIL: RoomMapper가 null");
                    return "redirect:/room/reservFailure";
                }
                System.out.println("✅ RoomMapper 획득 성공");
                
                // 테스트 쿼리 실행
                String today = LocalDate.now().toString().replace("-", "");
                String testJumuncode = "j" + today;
                int testNum = mapper.getNumber(testJumuncode);
                System.out.println("✅ DB 연결 테스트 성공, 번호: " + testNum);
                
            } catch (Exception e) {
                System.err.println("❌ FAIL: Mapper 또는 DB 연결 실패");
                e.printStackTrace();
                return "redirect:/room/reservFailure";
            }
            
            // ✅ 4. 서비스 검증 (로그 추가)
            System.out.println("🔍 Step 4: 서비스 검증 시작");
            try {
                Object reservationStatusService = getReservationStatusService();
                System.out.println("✅ ReservationStatusService 획득: " + reservationStatusService);
                
                Object reservationQueueService = getQueueService();
                System.out.println("✅ ReservationQueueService 획득: " + reservationQueueService);
                
            } catch (Exception e) {
                System.err.println("❌ FAIL: 서비스 Bean 획득 실패");
                e.printStackTrace();
                return "redirect:/room/reservFailure";
            }
            
            // ✅ 5. 원래 예약 로직 실행 (상세 로그 추가)
            System.out.println("🔍 Step 5: 원래 예약 로직 실행");
            
            try {
                // ✅ 주문코드 생성
                System.out.println("🔍 Step 5.1: 주문코드 생성 시작");
                String today = LocalDate.now().toString().replace("-", "");
                String jumuncode = "j" + today;
                int num = getMapper().getNumber(jumuncode);
                jumuncode = jumuncode + String.format("%03d", num);
                rsdto.setJumuncode(jumuncode);
                System.out.println("✅ 주문코드 생성: " + jumuncode);
                
                // ✅ 시간 형식 변환
                System.out.println("🔍 Step 5.2: 시간 형식 변환 시작");
                String fullStartTime = rsdto.getSelectedDate() + " " + rsdto.getStartTime() + ":00:00";
                String fullEndTime = rsdto.getSelectedDate() + " " + rsdto.getEndTime() + ":00:00";
                System.out.println("🕐 변환된 시간: " + fullStartTime + " ~ " + fullEndTime);
                
                // ✅ 방 코드 분할
                System.out.println("🔍 Step 5.3: 방 코드 분할 시작");
                String[] rcodes = rsdto.getRcode().split("/");
                System.out.println("🏠 처리할 방들: " + java.util.Arrays.toString(rcodes));
                
                // ✅ UUID 기반 상태 관리 생성
                System.out.println("🔍 Step 5.4: UUID 상태 생성 시작");
                String reservationUuid = getReservationStatusService().createReservationStatus(
                    userid, rcodes[0], fullStartTime, fullEndTime);
                System.out.println("🆔 생성된 UUID: " + reservationUuid);
                
                int successCount = 0;
                
                // ✅ 각 방에 대해 예약 처리
                System.out.println("🔍 Step 5.5: 각 방별 예약 처리 시작");
                for(int i = 0; i < rcodes.length; i++) {
                    String currentRcode = rcodes[i];
                    System.out.println("🔄 처리 중: " + currentRcode + " (" + (i+1) + "/" + rcodes.length + ")");
                    
                    try {
                        System.out.println("🔍 Step 5.5." + (i+1) + ".1: 예약 DTO 생성 시작");
                        ReservationDto newReservation = new ReservationDto();
                        
                        // 기존 데이터 복사
                        newReservation.setUserid(userid);
                        newReservation.setJumuncode(jumuncode);
                        newReservation.setRcode(currentRcode);
                        newReservation.setCard1(rsdto.getCard1());
                        newReservation.setTel(rsdto.getTel());
                        newReservation.setHalbu1(rsdto.getHalbu1());
                        newReservation.setBank1(rsdto.getBank1());
                        newReservation.setCard2(rsdto.getCard2());
                        newReservation.setBank2(rsdto.getBank2());
                        newReservation.setPurposeuse(rsdto.getPurposeuse() != null ? rsdto.getPurposeuse() : "파티");
                        newReservation.setRequesttohost(rsdto.getRequesttohost() != null ? rsdto.getRequesttohost() : "");
                        newReservation.setReservprice(rsdto.getReservprice());
                        
                        newReservation.setStartTime(fullStartTime);
                        newReservation.setEndTime(fullEndTime);
                        
                        // ✅ UUID를 예약 객체에 연결 (추적용)
                        newReservation.setModified_at(reservationUuid);
                        
                        System.out.println("✅ 예약 데이터 준비 완료");
                        
                        // ✅ 상태 업데이트: 처리 시작
                        System.out.println("🔍 Step 5.5." + (i+1) + ".2: 상태 업데이트 시작");
                        getReservationStatusService().startProcessing(reservationUuid);
                        System.out.println("✅ 상태 업데이트 완료");
                        
                        // 큐에 추가 (UUID 지원 메서드 사용)
                        System.out.println("🔍 Step 5.5." + (i+1) + ".3: 큐 추가 시도 - " + currentRcode);
                        boolean added = getQueueService().enqueueWithUuid(newReservation, reservationUuid);
                        
                        if (added) {
                            successCount++;
                            System.out.println("✅ 큐 추가 성공: " + currentRcode + " | UUID: " + reservationUuid);
                        } else {
                            System.out.println("⚠️ 큐 추가 실패: " + currentRcode + " | UUID: " + reservationUuid);
                        }
                        
                    } catch (Exception e) {
                        System.err.println("❌ 개별 예약 처리 실패: " + e.getMessage());
                        getReservationStatusService().failReservation(reservationUuid, "예약 처리 오류: " + e.getMessage());
                        e.printStackTrace();
                    }
                }
                
                System.out.println("🔍 Step 5.6: 결과 검증 시작");
                System.out.println("📊 총 " + rcodes.length + "건 중 " + successCount + "건 큐 추가 성공");
                
                if (successCount == 0) {
                    System.err.println("❌ 모든 예약 요청이 실패");
                    getReservationStatusService().failReservation(reservationUuid, "모든 예약 요청이 실패했습니다.");
                    return "redirect:/room/reservFailure?uuid=" + reservationUuid;
                }
                
                System.out.println("🔍 Step 5.7: 리다이렉트 준비");
                String redirectUrl = "redirect:/room/reservationStatus?uuid=" + reservationUuid 
                       + "&selectedDate=" + rsdto.getSelectedDate()
                       + "&startTime=" + rsdto.getStartTime()
                       + "&endTime=" + rsdto.getEndTime()
                       + "&rcode=" + rcodes[0];
                
                System.out.println("🎯 리다이렉트 URL: " + redirectUrl);
                
                // ✅ UUID 기반 상태 페이지로 리다이렉트
                return redirectUrl;
                
            } catch (Exception e) {
                System.err.println("❌ FATAL ERROR: Step 5 처리 중 예외 발생");
                e.printStackTrace();
                return "redirect:/room/reservFailure";
            }
            
        } catch (Exception e) {
            System.err.println("❌ FATAL ERROR: 전체 처리 중 예외 발생");
            e.printStackTrace();
            return "redirect:/room/reservFailure";
        }
    }
    
 // ✅ 서비스 없이 직접 처리하는 메서드
    private String handleDirectReservation(ReservationDto rsdto, HttpSession session) {
        System.out.println("🔄 직접 예약 처리 시작");
        
        try {
            // 주문코드 생성
            String today = LocalDate.now().toString().replace("-", "");
            String jumuncode = "j" + today;
            int num = getMapper().getNumber(jumuncode);
            jumuncode = jumuncode + String.format("%03d", num);
            rsdto.setJumuncode(jumuncode);
            System.out.println("✅ 주문코드 생성: " + jumuncode);
            
            // 시간 설정
            String fullStartTime = rsdto.getSelectedDate() + " " + rsdto.getStartTime() + ":00:00";
            String fullEndTime = rsdto.getSelectedDate() + " " + rsdto.getEndTime() + ":00:00";
            rsdto.setStartTime(fullStartTime);
            rsdto.setEndTime(fullEndTime);
            
            // 기본값 설정
            if (rsdto.getPurposeuse() == null) rsdto.setPurposeuse("파티");
            if (rsdto.getRequesttohost() == null) rsdto.setRequesttohost("");
            
            System.out.println("💾 DB 직접 삽입 시도...");
            getMapper().reservOk(rsdto);
            System.out.println("✅ 직접 예약 성공!");
            
            return "redirect:/room/reservList?jumuncode=" + jumuncode;
            
        } catch (Exception e) {
            System.err.println("❌ 직접 예약도 실패: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/room/reservFailure";
        }
    }
    
    @GetMapping("/room/reservList")
    public String reservList(HttpSession session, HttpServletRequest request, Model model, 
                           MemberDto mdto, ReservationDto rsdto, RoomDto rdto) {
        return getService().reservList(session, request, model, mdto, rsdto, rdto);
    }
    
    @GetMapping("/room/getReservTime")
    public @ResponseBody ArrayList<ReservationDto> getReservTime(HttpServletRequest request) {
        return getService().getReservTime(request);
    }
    
    @GetMapping("/room/reservChk")
    public String reservChk(HttpSession session, HttpServletRequest request, Model model, 
                          MemberDto mdto, ReservationDto rsdto, RoomDto rdto) {
        return getService().reservChk(session, request, model, mdto, rsdto, rdto);
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
        getService().increaseRoomLike(roomid); // 직접 increaseRoomLike만 호출
        
        // 리다이렉트 주소 가져오기
        String redirect = request.getParameter("redirect");
        if (redirect == null || redirect.isEmpty()) {
            redirect = "/room/roomContent?rcode=" + getService().getRcodeByroomid(roomid);
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
        getService().removeLike(userId, roomid);
        
        // 리다이렉트 주소 가져오기
        String redirect = request.getParameter("redirect");
        if (redirect == null || redirect.isEmpty()) {
            redirect = "/room/roomContent?rcode=" + getService().getRcodeByroomid(roomid);
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
            getService().increaseRoomLike(roomid);
            
            // 좋아요 쿠키 설정 (24시간 유효)
            Cookie likeCookie = new Cookie(cookieName, "true");
            likeCookie.setMaxAge(60 * 60 * 24); // 24시간 (초 단위)
            likeCookie.setPath("/");
            response.addCookie(likeCookie);
        }
        
        return "redirect:/room/roomContent?rcode=" + getService().getRcodeByroomid(roomid);
    }
    
    @GetMapping("/room/reservFailure")
    public String reservFailure() {
        return "/room/reservFailure";
    }

    @GetMapping("/room/queueStats")
    @ResponseBody
    public Map<String, Object> getQueueStatistics() {
        return getQueueService().getStatistics();
    }
    
    // ✅ 상세 통계 API
    @GetMapping("/room/detailedStats")
    @ResponseBody
    public Map<String, Object> getDetailedStatistics() {
        Map<String, Object> stats = new HashMap<>();
        
        // 큐 서비스 통계
        Map<String, Object> queueStats = getQueueService().getStatistics();
        stats.putAll(queueStats);
        
        // 배치 서비스 통계
        stats.putAll(getBatchReservationService().getBatchStatistics());
        
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
        getQueueService().setBatchMode(enabled);
        
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
        getQueueService().resetStats();
        
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
            boolean added = getQueueService().enqueue(dto);
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
    
    @PostMapping("/room/advancedBulkTest")
    @ResponseBody
    public Map<String, Object> advancedBulkTest(
        @RequestParam(defaultValue = "100") int count,
        @RequestParam(defaultValue = "5") int roomCount,
        @RequestParam(defaultValue = "true") boolean enableBatch) {
        
        long startTime = System.currentTimeMillis();
        
        // 배치 모드 설정
        getQueueService().setBatchMode(enableBatch);
        
        // 통계 초기화
        getQueueService().resetStats();
        
        int successCount = 0;
        List<String> errors = new ArrayList<>();
        
        for (int i = 0; i < count; i++) {
            try {
                ReservationDto dto = createAdvancedTestReservation(i, roomCount);
                boolean added = getQueueService().enqueue(dto);
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
        while (getQueueService().getQueueSize() > 0 && waitCount < 30) {
            try {
                Thread.sleep(1000);
                waitCount++;
            } catch (InterruptedException e) {
                break;
            }
        }
        
        long endTime = System.currentTimeMillis();
        Map<String, Object> stats = getQueueService().getStatistics();
        
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
        Map<String, Object> stats = getQueueService().getStatistics();
        
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
        getQueueService().setBatchMode(false);
        getQueueService().resetStats();
        
        long singleStart = System.currentTimeMillis();
        for (int i = 0; i < batchSize; i++) {
            getQueueService().enqueue(createAdvancedTestReservation(i, 3));
        }
        
        // 완료 대기
        while (getQueueService().getQueueSize() > 0) {
            try { Thread.sleep(100); } catch (InterruptedException e) { break; }
        }
        long singleEnd = System.currentTimeMillis();
        Map<String, Object> singleStats = getQueueService().getStatistics();
        
        // 2. 배치 처리 모드 테스트
        getQueueService().setBatchMode(true);
        getQueueService().resetStats();
        
        long batchStart = System.currentTimeMillis();
        for (int i = batchSize; i < batchSize * 2; i++) {
            getQueueService().enqueue(createAdvancedTestReservation(i, 3));
        }
        
        // 완료 대기
        try { Thread.sleep(3000); } catch (InterruptedException e) {}
        long batchEnd = System.currentTimeMillis();
        Map<String, Object> batchStats = getQueueService().getStatistics();
        
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
    
    /**
     * 예약 처리 상태 페이지 표시
     */
    @GetMapping("/room/reservationStatus")
    public String showReservationStatus(@RequestParam String uuid, 
                                       @RequestParam(required = false) String selectedDate,
                                       @RequestParam(required = false) String startTime,
                                       @RequestParam(required = false) String endTime,
                                       @RequestParam(required = false) String rcode,
                                       Model model, HttpSession session) {
        
        System.out.println("🔍 reservationStatus 파라미터 확인:");
        System.out.println("uuid: " + uuid);
        System.out.println("selectedDate: " + selectedDate);
        System.out.println("startTime: " + startTime);
        System.out.println("endTime: " + endTime);
        System.out.println("rcode: " + rcode);
        
        // ✅ 기본 UUID 정보
        model.addAttribute("reservationUuid", uuid);
        
        // ✅ rcode로 방 정보 조회
        if (rcode != null && !rcode.isEmpty()) {
            try {
                RoomDto room = getMapper().roomContent(rcode);
                if (room != null) {
                    model.addAttribute("roomName", room.getName());
                    System.out.println("✅ 방 이름 설정: " + room.getName());
                } else {
                    model.addAttribute("roomName", "파티룸");
                    System.out.println("⚠️ 방 정보 없음, 기본값 설정");
                }
            } catch (Exception e) {
                System.err.println("❌ 방 정보 조회 오류: " + e.getMessage());
                model.addAttribute("roomName", "파티룸");
            }
        } else {
            model.addAttribute("roomName", "");
        }
        
        // ✅ 사용자 정보 조회
        try {
            String userid = (String) session.getAttribute("userid");
            if (userid != null) {
                MemberDto member = getMapper().getMember(userid);
                if (member != null) {
                    model.addAttribute("userName", member.getName());
                    System.out.println("✅ 사용자 이름 설정: " + member.getName());
                } else {
                    model.addAttribute("userName", "");
                    System.out.println("⚠️ 사용자 정보 없음");
                }
            } else {
                model.addAttribute("userName", "");
                System.out.println("⚠️ 로그인되지 않음");
            }
        } catch (Exception e) {
            System.err.println("❌ 사용자 정보 조회 오류: " + e.getMessage());
            model.addAttribute("userName", "");
        }
        
        // ✅ 시간 정보 설정
        if (selectedDate != null) {
            model.addAttribute("reservationDate", selectedDate);
            System.out.println("✅ 예약 날짜 설정: " + selectedDate);
        } else {
            model.addAttribute("reservationDate", "");
        }
        
        if (startTime != null) {
            // "01:00" -> "01" 또는 "1"
            String hour = startTime.contains(":") ? startTime.split(":")[0] : startTime;
            model.addAttribute("startTime", hour);
            System.out.println("✅ 시작 시간 설정: " + hour);
        } else {
            model.addAttribute("startTime", "");
        }
        
        if (endTime != null) {
            String hour = endTime.contains(":") ? endTime.split(":")[0] : endTime;
            model.addAttribute("endTime", hour);
            System.out.println("✅ 종료 시간 설정: " + hour);
        } else {
            model.addAttribute("endTime", "");
        }
        
        // ✅ 예약 상태 정보
        try {
            Map<String, Object> statusInfo = getReservationStatusService().getReservationInfo(uuid);
            if ("notfound".equals(statusInfo.get("status"))) {
                model.addAttribute("errorMessage", "유효하지 않은 예약 요청입니다.");
                return "/room/reservFailure";
            }
            
            if (statusInfo.get("jumuncode") != null) {
                model.addAttribute("jumuncode", statusInfo.get("jumuncode"));
            }
        } catch (Exception e) {
            System.err.println("❌ 예약 상태 조회 오류: " + e.getMessage());
        }
        
        System.out.println("🎯 최종 모델 속성들:");
        model.asMap().forEach((key, value) -> {
            System.out.println("- " + key + ": " + value);
        });
        
        return "/room/reservationStatus";
    }

    /**
     * 예약 상태 API (AJAX용) - 중복 제거를 위해 메서드명 변경
     */
    @GetMapping("/room/reservationStatusAPI")
    @ResponseBody
    public Map<String, Object> getReservationStatusAPI(@RequestParam String uuid) {
        return getReservationStatusService().getReservationStatus(uuid);
    }

    /**
     * 예약 상태 업데이트 API (내부 호출용)
     */
    @PostMapping("/room/updateReservationStatus")
    @ResponseBody
    public Map<String, Object> updateReservationStatus(
        @RequestParam String uuid,
        @RequestParam String status,
        @RequestParam(required = false) Integer step,
        @RequestParam(required = false) String message,
        @RequestParam(required = false) String jumuncode) {
        
        Map<String, Object> response = new HashMap<>();
        
        try {
            if ("completed".equals(status) && jumuncode != null) {
                getReservationStatusService().completeReservation(uuid, jumuncode);
            } else if ("failed".equals(status)) {
                getReservationStatusService().failReservation(uuid, message);
            } else {
                getReservationStatusService().updateReservationStatus(uuid, status, step, message);
            }
            
            response.put("success", true);
            response.put("message", "상태 업데이트 완료");
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "상태 업데이트 실패: " + e.getMessage());
        }
        
        return response;
    }

    /**
     * 예약 상태 통계 API
     */
    @GetMapping("/room/reservationStatusStats")
    @ResponseBody
    public Map<String, Object> getReservationStatusStats() {
        Map<String, Object> stats = new HashMap<>();
        
        // 큐 서비스 통계
        Map<String, Object> queueStats = getQueueService().getStatistics();
        stats.putAll(queueStats);
        
        // 예약 상태 통계
        Map<String, Object> statusStats = getReservationStatusService().getStatusStatistics();
        stats.putAll(statusStats);
        
        return stats;
    }

    /**
     * 예약 진행 상황 실시간 모니터링 (관리자용)
     */
    @GetMapping("/room/admin/reservationMonitor")
    public String reservationMonitor(Model model) {
        // 관리자 권한 체크 (실제 구현 시)
        
        Map<String, Object> stats = getReservationStatusStats();
        model.addAttribute("stats", stats);
        
        return "/room/admin/reservationMonitor";
    }

    /**
     * 특정 예약의 상세 로그 조회 (디버깅용)
     */
    @GetMapping("/room/reservationLog")
    @ResponseBody
    public Map<String, Object> getReservationLog(@RequestParam String uuid) {
        Map<String, Object> log = new HashMap<>();
        
        try {
            Map<String, Object> status = getReservationStatusService().getReservationStatus(uuid);
            
            // 큐 서비스에서 관련 로그 조회
            Map<String, Object> queueStats = getQueueService().getStatistics();
            
            log.put("reservationStatus", status);
            log.put("queueInfo", queueStats);
            log.put("timestamp", System.currentTimeMillis());
            
        } catch (Exception e) {
            log.put("error", e.getMessage());
        }
        
        return log;
    }
}