package com.example.demo.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.dto.NoticeDto;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BoardController {
	
	@Autowired
	@Qualifier("bs")
	
	private BoardService service;
	
	@GetMapping("/board/noticeList")
	public String noticeList(NoticeDto ndto,Model model,HttpServletRequest request)
	{
		return service.noticeList(ndto,model,request);
	}
}
