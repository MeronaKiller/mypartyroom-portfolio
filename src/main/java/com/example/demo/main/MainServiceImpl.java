package com.example.demo.main;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.dto.RoomDto;
import jakarta.servlet.http.HttpServletRequest;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainMapper mapper;
	
	@Override
	public String main(HttpServletRequest request, Model model) {
		try {
			System.out.println("🔧 MainService.main() 호출됨");
			
			ArrayList<RoomDto> rlist = mapper.HeartRanking();
			model.addAttribute("rdto", rlist);
			
			System.out.println("✅ MainService - 데이터 조회 성공: " + (rlist != null ? rlist.size() : 0) + "개");
			
		} catch (Exception e) {
			System.err.println("❌ MainService 오류: " + e.getMessage());
			e.printStackTrace();
			model.addAttribute("rdto", new ArrayList<RoomDto>());
		}
		
		// 🎯 직접 뷰 이름 반환 (리디렉션 없음)
		return "main/main";
	}
	
	@Override
	public String room() {
		System.out.println("🏢 RoomService.room() 호출됨");
		return "room/room";
	}
	
	@Override
	public String terms() {
		System.out.println("📋 MainService.terms() 호출됨");
		return "about/terms";
	}
	
	@Override
	public String privacy() {
		System.out.println("🔒 MainService.privacy() 호출됨");
		return "about/privacy";
	}
}