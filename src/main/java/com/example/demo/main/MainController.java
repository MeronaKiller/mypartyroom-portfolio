package com.example.demo.main;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.dto.RoomDto;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MainController {
	
	@Autowired
	@Qualifier("ms")
	private MainService service;
	
	@Autowired
	private MainMapper mapper;
	
	// 🎯 루트 경로 - 직접 메인 페이지 처리 (리디렉션 없음)
	@GetMapping("/")
	public String home(HttpServletRequest request, Model model) {
		System.out.println("🏠 홈 페이지 요청 - 직접 처리");
		return loadMainPage(request, model);
	}
	
	// 🎯 메인 페이지 - 직접 처리 (리디렉션 없음)
	@GetMapping("/main")
	public String main(HttpServletRequest request, Model model) {
		System.out.println("📄 메인 페이지 요청 - 직접 처리");
		return loadMainPage(request, model);
	}
	
	// 🎯 기존 경로들도 직접 처리 (리디렉션 제거)
	@GetMapping("/main/main")
	public String mainMain(HttpServletRequest request, Model model) {
		System.out.println("📄 /main/main 요청 - 직접 처리");
		return loadMainPage(request, model);
	}
	
	@GetMapping("/main/index")
	public String mainIndex(HttpServletRequest request, Model model) {
		System.out.println("📄 /main/index 요청 - 직접 처리");
		return loadMainPage(request, model);
	}
	
	// 🔧 공통 메인 페이지 로드 메서드
	private String loadMainPage(HttpServletRequest request, Model model) {
		try {
			System.out.println("⚡ 메인 페이지 데이터 로딩 시작...");
			
			// 하트 랭킹 데이터 조회
			ArrayList<RoomDto> rlist = mapper.HeartRanking();
			model.addAttribute("rdto", rlist);
			
			System.out.println("✅ 메인 페이지 로드 성공! 룸 데이터: " + (rlist != null ? rlist.size() : 0) + "개");
			
		} catch (Exception e) {
			System.err.println("❌ 메인 페이지 로딩 오류: " + e.getMessage());
			e.printStackTrace();
			
			// 오류 발생 시 빈 리스트로 초기화
			model.addAttribute("rdto", new ArrayList<RoomDto>());
		}
		
		// 🎯 JSP 파일 경로: /WEB-INF/views/main/main.jsp
		System.out.println("🎯 뷰 반환: main/main");
		return "main/main";
	}
	
	// 🔧 다른 페이지들은 Service 사용
	@GetMapping("/room/room")
	public String room() {
		System.out.println("🏢 룸 페이지 요청");
		return service.room();
	}
	
	@GetMapping("/about/terms")
	public String terms() {
		System.out.println("📋 약관 페이지 요청");
		return service.terms();
	}
	
	@GetMapping("/about/privacy")
	public String privacy() {
		System.out.println("🔒 개인정보 페이지 요청");
		return service.privacy();
	}
}