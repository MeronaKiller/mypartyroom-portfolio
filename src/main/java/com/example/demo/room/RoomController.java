package com.example.demo.room;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class RoomController {
	@Autowired
	@Qualifier("rs")
	private RoomService service;
	
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
	public String roomContent(HttpServletRequest request,Model model,
			HttpSession session,RoomDto rdto,ReservationDto rsdto)
	{
		return service.roomContent(request,model,session,rdto,rsdto);
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
}
