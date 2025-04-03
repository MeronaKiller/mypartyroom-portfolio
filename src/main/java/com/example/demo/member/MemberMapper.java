package com.example.demo.member;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;

@Mapper
public interface MemberMapper {

	public Integer useridCheck(String userid);
	public void memberOk(MemberDto mdto);
	public ArrayList<HashMap> order(String userid, String start, String end, int month);
	public void updateReservationStatus(ReservationDto rsdto);
	public void updateReservationStatus1(ReservationDto rsdto);
	public ArrayList<HashMap> cancelReturnList();
}
