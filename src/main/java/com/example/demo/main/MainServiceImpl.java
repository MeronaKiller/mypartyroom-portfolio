package com.example.demo.main;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainMapper mapper;
	
	@Override
	public String main(HttpServletRequest request,Model model)
	{
		ArrayList<RoomDto> rlist=mapper.HeartRanking();
		model.addAttribute("rdto",rlist);
		return "/main/main";
	}
	@Override
	public String room()
	{
		return "/room/room";
	}
	@Override
	public String terms()
	{
		return "/about/terms";
	}
	@Override
	public String privacy()
	{
		return "/about/privacy";
	}
}
