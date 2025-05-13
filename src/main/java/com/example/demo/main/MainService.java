package com.example.demo.main;

import org.springframework.ui.Model;

import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;

public interface MainService {

	public String main(HttpServletRequest request, Model model);
	public String room();
	public String terms();
	public String privacy();

}
