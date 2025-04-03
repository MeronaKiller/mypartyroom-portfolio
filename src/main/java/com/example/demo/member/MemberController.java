package com.example.demo.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.PersonalInquiryDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	@Autowired
	@Qualifier("ms")
	private MemberService service;
	
	@GetMapping("/member/member")
	public String member()
	{
		return service.member();
	}
	@GetMapping("/member/useridCheck")
	public @ResponseBody String userid(HttpServletRequest request)
	{
		return service.useridCheck(request);
	}
	@PostMapping("/member/memberOk")
	public String memberOk(MemberDto mdto)
	{
		return service.memberOk(mdto);
	}
	@GetMapping("/member/order")
	public String order(HttpSession session, Model model,HttpServletRequest request,ReservationDto rsdto,RoomDto rdto)
	{
		return service.order(session,model,request,rsdto,rdto);
	}
	@PostMapping("/member/cancelReserv")
	public String cancelReserv(ReservationDto rsdto, HttpSession session)
	{
	    return service.cancelReserv(rsdto, session);
	}
	@GetMapping("/member/cancelReturnList")
	public String cancelReturnList(HttpSession session, Model model,HttpServletRequest request,ReservationDto rsdto,RoomDto rdto)
	{
		return service.cancelReturnList(session,model,request,rsdto,rdto);
	}
	@GetMapping("/member/personalInquiry")
	public String personalInquiry(HttpSession session, Model model, HttpServletRequest request, PersonalInquiryDto pdto)
	{
		return service.personalInquiry(session,model,request,pdto);
	}
	@PostMapping("/member/personalInquiryOk")
	public String personalInquiryOk(MemberDto mdto, HttpSession session, Model model, HttpServletRequest request, PersonalInquiryDto pdto)
	{
		return service.personalInquiryOk(mdto,session,model,request,pdto);
	}
	@GetMapping("/member/personalInquiryList")
	public String personalInquiryList(HttpSession session,Model model,HttpServletRequest request,PersonalInquiryDto pdto)
	{
		return service.personalInquiryList(session,model,request,pdto);
	}
}
	
