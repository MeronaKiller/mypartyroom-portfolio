package com.example.demo.login;

import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface LoginService {

	String login(HttpServletRequest request, Model model, HttpSession session, MemberDto mdto);
	String loginOk(HttpServletRequest request, HttpSession session,MemberDto mdto);
	String logout(HttpSession session);

}
