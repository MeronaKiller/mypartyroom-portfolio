package com.example.demo.room;


import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

@Controller
public class RoomController {
	@Autowired
	@Qualifier("rs")
	private RoomService service;
	
	@Autowired
    private ReservationQueueService queueService;
	
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
	public String roomContent(HttpServletRequest request, Model model,
	        HttpSession session, RoomDto rdto, ReservationDto rsdto) {
	    String userId = (String) session.getAttribute("userid");
	    
	    // roomid가 null인 경우를 방지
	    if (rdto.getRoomid() > 0) {
	        // userId가 null이어도 isLikedByUser 메서드가 null을 반환하지 않도록 수정됨
	        boolean likedByUser = service.isLikedByUser(userId, rdto.getRoomid());
	        model.addAttribute("likedByUser", likedByUser);
	    } else {
	        model.addAttribute("likedByUser", false);
	    }
	    
	    return service.roomContent(request, model, session, rdto, rsdto);
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
	@GetMapping("/room/like")
	public String likeRoom(HttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes) {
	    // 로그인 확인
	    String userId = (String) session.getAttribute("userid");
	    if (userId == null) {
	        // 로그인 안 된 경우 로그인 페이지로 리다이렉트
	        redirectAttributes.addFlashAttribute("message", "로그인 후 이용 가능합니다.");
	        return "redirect:/login/login";
	    }
	    
	    // 좋아요 처리
	    int roomid = Integer.parseInt(request.getParameter("roomid"));
	    service.increaseRoomLike(roomid); // 직접 increaseRoomLike만 호출
	    
	    // 리다이렉트 주소 가져오기
	    String redirect = request.getParameter("redirect");
	    if (redirect == null || redirect.isEmpty()) {
	        redirect = "/room/roomContent?rcode=" + service.getRcodeByroomid(roomid);
	    }
	    
	    return "redirect:" + redirect;
	}

    @GetMapping("/room/unlike")
    public String unlikeRoom(HttpServletRequest request, HttpSession session) {
        // 로그인 확인
        String userId = (String) session.getAttribute("userid");
        if (userId == null) {
            return "redirect:/login/login";
        }
        
        // 좋아요 취소 처리
        int roomid = Integer.parseInt(request.getParameter("roomid"));
        service.removeLike(userId, roomid); // service 객체 사용, 변수명 수정
        
        // 리다이렉트 주소 가져오기
        String redirect = request.getParameter("redirect");
        if (redirect == null || redirect.isEmpty()) {
            redirect = "/room/roomContent?rcode=" + service.getRcodeByroomid(roomid); // service 객체 사용
        }
        
        return "redirect:" + redirect;
    }
    @GetMapping("/room/like/{roomid}")
    public String likeRoomWithCookie(@PathVariable int roomid, HttpServletRequest request, HttpServletResponse response) {
        // 해당 방에 대한 좋아요 쿠키 이름
        String cookieName = "room_liked_" + roomid;
        
        // 쿠키 확인
        Cookie[] cookies = request.getCookies();
        boolean alreadyLiked = false;
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookieName.equals(cookie.getName())) {
                    alreadyLiked = true;
                    break;
                }
            }
        }
        // 아직 좋아요를 누르지 않은 경우에만 좋아요 증가
        if (!alreadyLiked) {
            service.increaseRoomLike(roomid);
            
            // 좋아요 쿠키 설정 (24시간 유효)
            Cookie likeCookie = new Cookie(cookieName, "true");
            likeCookie.setMaxAge(60 * 60 * 24); // 24시간 (초 단위)
            likeCookie.setPath("/");
            response.addCookie(likeCookie);
        }
        
        return "redirect:/room/roomContent?rcode=" + service.getRcodeByroomid(roomid);
    }
    
    @GetMapping("/room/reservFailure")
	    public String reservFailure() {
	        return "/room/reservFailure";
	    }

    @GetMapping("/room/queueStats")
    @ResponseBody
    public Map<String, Object> getQueueStatistics() {
        return queueService.getStatistics();
    }
    
}