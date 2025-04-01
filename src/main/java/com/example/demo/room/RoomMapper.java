package com.example.demo.room;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;


@Mapper
public interface RoomMapper {
	public ArrayList<RoomDto> roomInfo(int roomid);
	public ArrayList<RoomDto> RoomList(String rcode, String searchKeyword);
	public RoomDto roomContent(String rcode);
	public MemberDto getMember(String userid);
	public int getNumber(String jumuncode);
	public void reservOk(ReservationDto rsdto);
	public ReservationDto reservList(ReservationDto rsdto);
	public ReservationDto reservChk(ReservationDto rsdto);
	public ArrayList<Map<String, String>> getReservedTimes(String rcode);
	public ArrayList<ReservationDto> getReservTime(String rcode,String ymd);
	public ArrayList<ReservationDto> getReservationsByUserId(String userid);
}
