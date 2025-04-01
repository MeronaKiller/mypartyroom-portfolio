package com.example.demo.member;

import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface MemberService {

	public String member();
	public String memberOk(MemberDto mdto);
	public String useridCheck(HttpServletRequest request);
	public String order(HttpSession session, Model model, HttpServletRequest request, ReservationDto rsdto, RoomDto rdto);
	public String cancelReserv(ReservationDto rsdto, HttpSession session);
	
	}

