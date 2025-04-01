package com.example.demo.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.demo.dto.MemberDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
	@Autowired
	@Qualifier("ls")
	private LoginService service;
	
	@GetMapping("/login/login")
	public String login(HttpServletRequest request,Model model,HttpSession session,MemberDto mdto)
	{
		if(session.getAttribute("userid") != null) //로그인상태로 로그인창 들어가면 리다이렉트
		{
			return "redirect:/main/main";
		}
			return service.login(request,model,session,mdto);
	}
	@PostMapping("/login/loginOk")
	public String loginOk(HttpServletRequest request,HttpSession session,MemberDto mdto)
	{
		return service.loginOk(request,session, mdto);
	}
	@GetMapping("/login/logout")
	public String logout(HttpSession session)
	{
		return service.logout(session);
	}
}
