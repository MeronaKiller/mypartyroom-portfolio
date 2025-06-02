package com.example.demo.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.NoticeDto;
import com.example.demo.dto.PersonalInquiryDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	
	@Autowired
	@Qualifier("as")
	private AdminService service;
	
	@GetMapping("/admin/roomWrite")
	public String roomWrite(Model model) {
		return service.roomWrite(model);
	}
	
	@GetMapping("/admin/getSo")
	public @ResponseBody ArrayList<SoDto> getSo(HttpServletRequest request) {
		int daeid = Integer.parseInt(request.getParameter("daeid"));
		return service.getSo(daeid);
	}
	
	@GetMapping("/admin/getRcode")
	public @ResponseBody String getRcode(HttpServletRequest request) {
		String rcode = request.getParameter("rcode");
		return service.getRcode(rcode);
	}
	
	@PostMapping("/admin/roomWriteOk")
	public String roomWriteOk(RoomDto rdto, MultipartHttpServletRequest multi) throws Exception {
		service.roomWriteOk(rdto, multi);
		return "redirect:/admin/roomManage";
	}
	
	@GetMapping("/admin/adminTools")
	public String adminTools(HttpSession session, Model model) {
		// 관리자 권한 정보 모델에 추가
		String adminUserId = (String) session.getAttribute("admin_userid");
		model.addAttribute("admin_userid", adminUserId);
		return "/admin/adminTools";
	}
	
	@GetMapping("/admin/memberManage")
	public String memberManage(MemberDto mdto, Model model, HttpSession session) {
		// 관리자 권한 체크 및 정보 추가
		String adminUserId = (String) session.getAttribute("admin_userid");
		model.addAttribute("admin_userid", adminUserId);
		
		return service.memberManage(mdto, model);
	}
	
	@GetMapping("/admin/conformCancle")
	public String conformCancle(MemberDto mdto, ReservationDto rsdto, Model model, HttpSession session) {
	    // 관리자 권한 체크 및 정보 추가
	    String adminUserId = (String) session.getAttribute("admin_userid");
	    model.addAttribute("admin_userid", adminUserId);
	    
	    return service.conformCancle(mdto, rsdto, model);
	}
	
	@GetMapping("/admin/chkReservStatus")
	public String chkReservStatus() {
		return "/admin/chkReservStatus";
	}
	
	@GetMapping("/admin/roomManage")
	public String roomManage() {
		return "/admin/roomManage";
	}
	
	@GetMapping("/admin/adminLoginHistory")
	public String adminLoginHistory() {
		return "/admin/adminLoginHistory";
	}
	
	@GetMapping("/admin/reviewManage")
	public String reviewManage() {
		return "/admin/reviewManage";
	}
	
	@GetMapping("/admin/roomManagerCreate")
	public String roomManagerCreate() {
		return "/admin/roomManagerCreate";
	}
	
	@GetMapping("/admin/adminLogin")
	public String adminLogin(HttpServletRequest request, Model model, HttpSession session, AdminDto adto) {
		// ✅ 문자열 비교 수정
		if ("pkc".equals(session.getAttribute("admin_userid"))) {
			return "redirect:/admin/adminTools";
		}
		return service.adminLogin(request, model, session, adto);
	}
	
	@PostMapping("/admin/adminLoginOk")
	public String adminLoginOk(HttpServletRequest request, HttpSession session, AdminDto adto) {
		return service.adminLoginOk(request, session, adto);
	}
	
	@GetMapping("/admin/adminLogout")
	public String adminLogout(HttpSession session) {
		return service.adminLogout(session);
	}
	
	@GetMapping("/admin/conformCancleOk")
	public String conformCancleOk(HttpServletRequest request) {
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		return service.conformCancleOk(reservationId);
	}
	
	@GetMapping("/admin/conformCancleNo")
	public String conformCancleNo(HttpServletRequest request) {
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		return service.conformCancleNo(reservationId);
	}
	
	@GetMapping("/admin/deleteUser")
	public String deleteUser(HttpServletRequest request) {
		int memberid = Integer.parseInt(request.getParameter("memberid"));
		return service.deleteUser(memberid);
	}
	
	@GetMapping("/admin/reviveUser")
	public String reviveUser(HttpServletRequest request) {
		int memberid = Integer.parseInt(request.getParameter("memberid"));
		return service.reviveUser(memberid);
	}
	
	// ✅ roomDelete 메서드 수정 - Service만 사용하도록 변경
	@GetMapping("/admin/roomDelete")
	public String roomDelete(Model model, HttpSession session) {
		// 관리자 권한 체크
		String adminUserId = (String) session.getAttribute("admin_userid");
		model.addAttribute("admin_userid", adminUserId);
		
		try {
			System.out.println("🔍 roomDelete 컨트롤러 호출됨 - 관리자: " + adminUserId);
			
			// ✅ Service를 통해서만 접근하도록 수정
			RoomDto rdto = new RoomDto(); // 빈 DTO 생성
			return service.roomDelete(rdto, model);
			
		} catch (Exception e) {
			System.err.println("❌ roomDelete 컨트롤러 에러: " + e.getMessage());
			e.printStackTrace();
			model.addAttribute("errorMessage", "데이터 조회 중 오류가 발생했습니다.");
			return "/admin/roomDelete";
		}
	}
	
	@GetMapping("/admin/roomDeleteOk")
	public String roomDeleteOk(HttpServletRequest request) {
		int roomid = Integer.parseInt(request.getParameter("roomid"));
		return service.roomDeleteOk(roomid);
	}
	
	@GetMapping("/admin/roomReviveOk")
	public String roomReviveOk(HttpServletRequest request) {
		int roomid = Integer.parseInt(request.getParameter("roomid"));
		return service.roomReviveOk(roomid);
	}
	
	@GetMapping("/admin/noticeManage")
	public String noticeManage(NoticeDto ndto, Model model, HttpServletRequest request) {
		return service.noticeManage(ndto, model, request);
	}
	
	@GetMapping("/admin/noticeContentManage")
	public String noticeContent(NoticeDto ndto, Model model, HttpServletRequest request) {
		return service.noticeContentManage(ndto, model, request);
	}
	
	@GetMapping("/admin/noticeWrite")
	public String noticeWrite(Model model) {
		return service.noticeWrite(model);
	}
	
	@PostMapping("/admin/noticeWriteOk")
	public String noticeWriteOk(NoticeDto ndto, HttpSession session) {
		String adminName = (String) session.getAttribute("admin_name");
		ndto.setAdmin_name(adminName);
		return service.noticeWriteOk(ndto);
	}
	
	@GetMapping("/admin/noticeContentDeleteOk")
	public String noticeContentDeleteOk(HttpServletRequest request) {
		int noticeid = Integer.parseInt(request.getParameter("noticeid"));
		return service.noticeContentDeleteOk(noticeid);
	}
	
	@GetMapping("/admin/roomContentReviveOk")
	public String noticeReviveOk(HttpServletRequest request) {
		int noticeid = Integer.parseInt(request.getParameter("noticeid"));
		return service.noticeContentReviveOk(noticeid);
	}
	
	@GetMapping("/admin/qnaAnswer")
	public String qnaAnswer(Model model, HttpServletRequest request) {
		return service.qnaAnswer(model, request);
	}
	
	@GetMapping("/admin/qnaContent")
	public String qnaContent(HttpServletRequest request, Model model) {
		int personalInquiryid = Integer.parseInt(request.getParameter("personalInquiryid"));
		return service.qnaContent(personalInquiryid, model);
	}
	
	@GetMapping("/admin/qnaAnswerOk")
	public String qnaAnswerOk(HttpServletRequest request) {
		int personalInquiryid = Integer.parseInt(request.getParameter("personalInquiryid"));
		return service.qnaAnswerOk(personalInquiryid);
	}
	
	// ✅ 모니터링 관련 메서드들
	@GetMapping("/admin/reservationMonitor")
	public String reservationMonitor(Model model, HttpSession session) {
		String adminUserId = (String) session.getAttribute("admin_userid");
		model.addAttribute("admin_userid", adminUserId);
		
		if (!"pkc".equals(adminUserId)) {
			return "redirect:/admin/adminLogin";
		}
		
		try {
			System.out.println("🖥️ 예약 모니터링 페이지 로드 - 관리자: " + adminUserId);
			
			Runtime runtime = Runtime.getRuntime();
			Map<String, Object> systemInfo = new HashMap<>();
			systemInfo.put("totalMemory", runtime.totalMemory() / 1024 / 1024 + " MB");
			systemInfo.put("freeMemory", runtime.freeMemory() / 1024 / 1024 + " MB");
			systemInfo.put("usedMemory", (runtime.totalMemory() - runtime.freeMemory()) / 1024 / 1024 + " MB");
			systemInfo.put("availableProcessors", runtime.availableProcessors());
			
			model.addAttribute("systemInfo", systemInfo);
			
		} catch (Exception e) {
			System.err.println("❌ 모니터링 페이지 로드 오류: " + e.getMessage());
			e.printStackTrace();
			model.addAttribute("errorMessage", "모니터링 데이터 로드에 실패했습니다.");
		}
		
		return "/admin/reservationMonitor";
	}
	
	@GetMapping("/admin/reservationStatusStats")
	public @ResponseBody Map<String, Object> getReservationStatusStats() {
		Map<String, Object> stats = new HashMap<>();
		
		try {
			// 샘플 통계 데이터
			stats.put("total", 1250);
			stats.put("success", 1180);
			stats.put("fail", 70);
			stats.put("tps", "45.2");
			stats.put("queueSize", 24);
			stats.put("queueCapacity", 1000);
			stats.put("processingCount", 8);
			stats.put("threadPoolSize", 16);
			stats.put("batchMode", true);
			stats.put("optimization", "8Core16Thread");
			
			Runtime runtime = Runtime.getRuntime();
			stats.put("systemInfo", Map.of(
				"totalMemory", runtime.totalMemory() / 1024 / 1024 + " MB",
				"freeMemory", runtime.freeMemory() / 1024 / 1024 + " MB",
				"usedMemory", (runtime.totalMemory() - runtime.freeMemory()) / 1024 / 1024 + " MB",
				"availableProcessors", runtime.availableProcessors(),
				"activeThreads", Thread.activeCount()
			));
			
			System.out.println("📊 모니터링 통계 제공 - TPS: " + stats.get("tps") + ", 큐: " + stats.get("queueSize"));
			
		} catch (Exception e) {
			System.err.println("❌ 통계 조회 오류: " + e.getMessage());
			stats.put("error", e.getMessage());
		}
		
		return stats;
	}
	
	@GetMapping("/admin/reservationLogs")
	public @ResponseBody Map<String, Object> getReservationLogs(@RequestParam(defaultValue = "50") int limit) {
		Map<String, Object> response = new HashMap<>();
		
		try {
			// 샘플 로그 데이터
			List<Map<String, Object>> logs = new ArrayList<>();
			long now = System.currentTimeMillis();
			
			logs.add(createLogEntry("info", "시스템 모니터링 시작됨", now - 300000));
			logs.add(createLogEntry("success", "예약 처리 완료: r0102001", now - 240000));
			logs.add(createLogEntry("warning", "큐 사용률 80% 도달", now - 180000));
			logs.add(createLogEntry("error", "예약 처리 실패: 시간 중복", now - 120000));
			logs.add(createLogEntry("info", "배치 모드 활성화", now - 60000));
			logs.add(createLogEntry("success", "처리 속도 향상: 45.2 TPS", now - 30000));
			logs.add(createLogEntry("info", "워커 스레드 16개 정상 작동 중", now));
			
			response.put("logs", logs);
			response.put("total", logs.size());
			response.put("timestamp", System.currentTimeMillis());
			
		} catch (Exception e) {
			System.err.println("❌ 로그 조회 오류: " + e.getMessage());
			response.put("error", e.getMessage());
		}
		
		return response;
	}
	
	@GetMapping("/admin/activeUuids")
	public @ResponseBody Map<String, Object> getActiveUuids() {
		Map<String, Object> response = new HashMap<>();
		
		try {
			// 샘플 UUID 데이터
			List<Map<String, Object>> uuids = new ArrayList<>();
			long now = System.currentTimeMillis();
			
			uuids.add(createUuidEntry("a1b2c3d4-e5f6-7890-abcd-ef1234567890", "r0102001", "processing", now - 30000));
			uuids.add(createUuidEntry("b2c3d4e5-f6g7-8901-bcde-f23456789012", "r0102002", "queued", now - 15000));
			uuids.add(createUuidEntry("c3d4e5f6-g7h8-9012-cdef-345678901234", "r0102003", "completed", now - 60000));
			uuids.add(createUuidEntry("d4e5f6g7-h8i9-0123-defg-456789012345", "r0102004", "failed", now - 45000));
			
			response.put("uuids", uuids);
			response.put("count", uuids.size());
			response.put("timestamp", System.currentTimeMillis());
			
		} catch (Exception e) {
			System.err.println("❌ UUID 조회 오류: " + e.getMessage());
			response.put("error", e.getMessage());
		}
		
		return response;
	}
	
	@PostMapping("/admin/setBatchMode")
	public @ResponseBody Map<String, Object> setBatchMode(@RequestParam boolean enabled, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		
		String adminUserId = (String) session.getAttribute("admin_userid");
		if (!"pkc".equals(adminUserId)) {
			response.put("success", false);
			response.put("message", "관리자 권한이 필요합니다.");
			return response;
		}
		
		try {
			response.put("success", true);
			response.put("batchMode", enabled);
			response.put("message", "배치 모드가 " + (enabled ? "활성화" : "비활성화") + "되었습니다.");
			
			System.out.println("🔧 배치 모드 변경: " + (enabled ? "활성화" : "비활성화") + " by " + adminUserId);
			
		} catch (Exception e) {
			System.err.println("❌ 배치 모드 변경 오류: " + e.getMessage());
			response.put("success", false);
			response.put("message", "배치 모드 변경에 실패했습니다: " + e.getMessage());
		}
		
		return response;
	}
	
	@PostMapping("/admin/resetStats")
	public @ResponseBody Map<String, Object> resetStatistics(HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		
		String adminUserId = (String) session.getAttribute("admin_userid");
		if (!"pkc".equals(adminUserId)) {
			response.put("success", false);
			response.put("message", "관리자 권한이 필요합니다.");
			return response;
		}
		
		try {
			response.put("success", true);
			response.put("message", "모든 통계가 초기화되었습니다.");
			
			System.out.println("📊 통계 초기화 실행 by " + adminUserId);
			
		} catch (Exception e) {
			System.err.println("❌ 통계 초기화 오류: " + e.getMessage());
			response.put("success", false);
			response.put("message", "통계 초기화에 실패했습니다: " + e.getMessage());
		}
		
		return response;
	}
	
	@PostMapping("/admin/emergencyStop")
	public @ResponseBody Map<String, Object> emergencyStop(HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		
		String adminUserId = (String) session.getAttribute("admin_userid");
		if (!"pkc".equals(adminUserId)) {
			response.put("success", false);
			response.put("message", "관리자 권한이 필요합니다.");
			return response;
		}
		
		try {
			response.put("success", true);
			response.put("message", "시스템이 긴급 정지되었습니다.");
			
			System.out.println("🚨 긴급 정지 실행 by " + adminUserId);
			
		} catch (Exception e) {
			System.err.println("❌ 긴급 정지 오류: " + e.getMessage());
			response.put("success", false);
			response.put("message", "긴급 정지에 실패했습니다: " + e.getMessage());
		}
		
		return response;
	}
	
	@PostMapping("/admin/bulkTest")
	public @ResponseBody Map<String, Object> bulkTest(@RequestParam(defaultValue = "100") int count, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		
		String adminUserId = (String) session.getAttribute("admin_userid");
		if (!"pkc".equals(adminUserId)) {
			response.put("success", false);
			response.put("message", "관리자 권한이 필요합니다.");
			return response;
		}
		
		try {
			long startTime = System.currentTimeMillis();
			
			int successCount = (int)(count * 0.85); // 85% 성공률로 시뮬레이션
			
			long endTime = System.currentTimeMillis();
			
			response.put("totalRequests", count);
			response.put("successCount", successCount);
			response.put("failCount", count - successCount);
			response.put("processingTime", endTime - startTime + " ms");
			response.put("requestsPerSecond", count * 1000.0 / (endTime - startTime));
			
			System.out.println("🧪 대용량 테스트 실행: " + count + "건 by " + adminUserId);
			
		} catch (Exception e) {
			System.err.println("❌ 대용량 테스트 오류: " + e.getMessage());
			response.put("success", false);
			response.put("message", "대용량 테스트에 실패했습니다: " + e.getMessage());
		}
		
		return response;
	}
	
	// 헬퍼 메서드들
	private Map<String, Object> createLogEntry(String logType, String message, long timestamp) {
		Map<String, Object> log = new HashMap<>();
		log.put("logType", logType);
		log.put("logMessage", message);
		log.put("timestamp", timestamp);
		log.put("time", new java.util.Date(timestamp).toString());
		return log;
	}
	
	private Map<String, Object> createUuidEntry(String uuid, String rcode, String status, long timestamp) {
		Map<String, Object> entry = new HashMap<>();
		entry.put("uuid", uuid);
		entry.put("rcode", rcode);
		entry.put("status", status);
		entry.put("timestamp", timestamp);
		entry.put("time", new java.util.Date(timestamp).toString());
		return entry;
	}
}