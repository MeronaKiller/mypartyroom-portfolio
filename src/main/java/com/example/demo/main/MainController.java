package com.example.demo.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MainController {
	
	@Autowired
	@Qualifier("ms")
	private MainService service;
	
	@GetMapping("/")
	public String home()
	{
		return "redirect:/main/main";
	}
	@GetMapping("/main/main")
	public String main(HttpServletRequest request,Model model)
	{
		return service.main(request,model);
	}
	@GetMapping("/room/room")
	public String room()
	{
		return service.room();
	}
	
	
}
