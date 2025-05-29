package com.example.demo.room;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface RoomService {

	String roomInfo(HttpServletRequest request, Model model, RoomDto rdto);
	String roomList(HttpServletRequest request, Model model, RoomDto rdto);
	String roomContent(HttpServletRequest request, Model model, HttpSession session, RoomDto rdto,ReservationDto rsdto);
	String roomReserv(HttpServletRequest request,HttpSession session,Model model);
	String reservOk(ReservationDto rsdto, HttpSession session);
	String reservList(HttpSession session, HttpServletRequest request, Model model,MemberDto mdto, ReservationDto rsdto, RoomDto rdto);
    public ArrayList<ReservationDto> getReservTime(HttpServletRequest request);
	String reservChk(HttpSession session, HttpServletRequest request, Model model, MemberDto mdto, ReservationDto rsdto,
			RoomDto rdto);
	public void addLike(String userid, int roomid);
	public void removeLike(String userid, int roomid);
	public boolean isLikedByUser(String userid, int roomid);
	public String getRcodeByroomid(int roomid);
	void increaseRoomLike(int roomid);

}
