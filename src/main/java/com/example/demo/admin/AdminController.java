package com.example.demo.admin;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.NoticeDto;
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
	public String roomWrite(Model model)
	{
		return service.roomWrite(model);
	}
	@GetMapping("/admin/getSo")
	public @ResponseBody ArrayList<SoDto> getSo(HttpServletRequest request)
	{
		int daeid=Integer.parseInt(request.getParameter("daeid"));
		return service.getSo(daeid);
	}
	@GetMapping("/admin/getRcode")
	public @ResponseBody String getRcode(HttpServletRequest request)
	{
		String rcode=request.getParameter("rcode");
		return service.getRcode(rcode);
	}
	@PostMapping("/admin/roomWriteOk")
	public String roomWriteOk(RoomDto rdto,
            MultipartHttpServletRequest multi) throws Exception
	{
        service.roomWriteOk(rdto, multi);
		return "redirect:/admin/roomManage";
	}
	@GetMapping("/admin/adminTools")
	public String adminTools()
	{
		return "/admin/adminTools";
	}
	@GetMapping("/admin/memberManage")
	public String memberManage(MemberDto mdto,Model model)
	{
		return service.memberManage(mdto,model);
	}
	@GetMapping("/admin/conformCancle")
	public String conformCancle(MemberDto mdto,ReservationDto rsdto,Model model)
	{
		return service.conformCancle(mdto,rsdto,model);
	}
	@GetMapping("/admin/chkReservStatus")
	public String chkReservStatus()
	{
		return "/admin/chkReservStatus";
	}
	@GetMapping("/admin/roomManage")
	public String roomManage()
	{
		return "/admin/roomManage";
	}
	@GetMapping("/admin/qnaAnswer")
	public String qnaAnswer()
	{
		return "/admin/qnaAnswer";
	}
	@GetMapping("/admin/adminLoginHistory")
	public String adminLoginHistory()
	{
		return "/admin/adminLoginHistory";
	}
	@GetMapping("/admin/reviewManage")
	public String reviewManage()
	{
		return "/admin/reviewManage";
	}
	@GetMapping("/admin/roomManagerCreate")
	public String roomManagerCreate()
	{
		return "/admin/roomManagerCreate";
	}
	@GetMapping("/admin/adminLogin")
	public String adminLogin(HttpServletRequest request,Model model,HttpSession session,AdminDto adto)
	{
		if(session.getAttribute("userid") == "pkc") //로그인상태로 로그인창 들어가면 리다이렉트
		{
			return "redirect:/admin/adminTools";
		}
			return service.adminLogin(request,model,session,adto);
	}
	@PostMapping("/admin/adminLoginOk")
	public String adminLoginOk(HttpServletRequest request,HttpSession session,AdminDto adto)
	{
		return service.adminLoginOk(request,session,adto);
	}
	@GetMapping("/admin/adminLogout")
	public String adminLogout(HttpSession session)
	{
		return service.adminLogout(session);
	}
	@GetMapping("/admin/conformCancleOk")
	public String conformCancleOk(HttpServletRequest request)
	{
	    int reservationId = Integer.parseInt(request.getParameter("reservationId"));
	    return service.conformCancleOk(reservationId);
	}
	@GetMapping("/admin/conformCancleNo")
	public String conformCancleNo(HttpServletRequest request)
	{
		int reservationId = Integer.parseInt(request.getParameter("reservationId"));
		return service.conformCancleNo(reservationId);
	}
	@GetMapping("/admin/deleteUser")
	public String deleteUser(HttpServletRequest request)
	{
		int memberid = Integer.parseInt(request.getParameter("memberid"));
		return service.deleteUser(memberid);
	}
	@GetMapping("/admin/reviveUser")
	public String reviveUser(HttpServletRequest request)
	{
		int memberid = Integer.parseInt(request.getParameter("memberid"));
		return service.reviveUser(memberid);
	}
	@GetMapping("/admin/roomDelete")
	public String roomDelete(RoomDto rdto,Model model)
	{
		return service.roomDelete(rdto,model);
	}
	@GetMapping("/admin/roomDeleteOk")
	public String roomDeleteOk(HttpServletRequest request)
	{
		int roomid = Integer.parseInt(request.getParameter("roomid"));
		return service.roomDeleteOk(roomid);
	}
	@GetMapping("/admin/roomReviveOk")
	public String roomReviveOk(HttpServletRequest request)
	{
		int roomid = Integer.parseInt(request.getParameter("roomid"));
		return service.roomReviveOk(roomid);
	}
	@GetMapping("/admin/noticeManage")
	public String noticeManage(NoticeDto ndto,Model model,HttpServletRequest request)
	{
		return service.noticeManage(ndto,model,request);
	}
	@GetMapping("/admin/noticeContentManage")
	public String noticeContent(NoticeDto ndto,Model model,HttpServletRequest request)
	{
		return service.noticeContentManage(ndto,model,request);
	}
	@GetMapping("/admin/noticeWrite")
	public String noticeWrite(Model model)
	{
		return service.noticeWrite(model);
	}
	@PostMapping("/admin/noticeWriteOk")
	public String noticeWriteOk(NoticeDto ndto, HttpSession session)
	{
	    String adminName = (String) session.getAttribute("admin_name");
	    ndto.setAdmin_name(adminName);
	    
	    return service.noticeWriteOk(ndto);
	}
}
