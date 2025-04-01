package com.example.demo.board;

import org.springframework.ui.Model;

import com.example.demo.dto.NoticeDto;

import jakarta.servlet.http.HttpServletRequest;

public interface BoardService {

	String noticeList(NoticeDto ndto, Model model, HttpServletRequest request);

}
