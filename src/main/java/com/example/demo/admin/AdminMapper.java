package com.example.demo.admin;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.DaeDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Mapper
public interface AdminMapper {
	public ArrayList<DaeDto> getDae();
	public int getNumber(String rcode);
	public void roomWriteOk(RoomDto rdto);
	public ArrayList<SoDto> getSo(int daeid);
	public String getRcode(String rcode);
	public String adminLoginOk(AdminDto adto);
	public ArrayList<MemberDto> getAllMember(int memberid);
	public ArrayList<ReservationDto> getCancleRequest(String userid);
	public ArrayList<MemberDto> getAllMember(String userid); // 특정 회원만 가져오기
	public void updateReservationStatus(int reservationId, int status);
	public ReservationDto getReservation(int reservationId);
}
