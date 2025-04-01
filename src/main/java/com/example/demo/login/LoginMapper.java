package com.example.demo.login;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Mapper
public interface LoginMapper {

	String loginOk(MemberDto mdto);

}
