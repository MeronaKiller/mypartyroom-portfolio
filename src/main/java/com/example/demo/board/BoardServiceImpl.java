package com.example.demo.board;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.dto.NoticeDto;

import jakarta.servlet.http.HttpServletRequest;

@Service
@Qualifier("bs")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public String noticeList(NoticeDto ndto,Model model,HttpServletRequest request)
	{
		
		// 시작페이지 인덱스값 구하기
		
		int page;
		if(request.getParameter("page")==null)
		{
			page=1;
		}
		else
		{
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		
		int pstart,pend,noticeGetChong;
		
		pstart=page/10;
		if(page%10==0)

		pstart=pstart-1;

		
		pstart=(pstart*10)+1;
		pend=pstart+9;
		
		noticeGetChong=mapper.noticeGetChong();
		if(pend>noticeGetChong)
			pend=noticeGetChong;
		
		int index=(page-1)*20;
		ArrayList<NoticeDto> nlist=mapper.noticeList(index);
		
		
		model.addAttribute("nlist",nlist);
		model.addAttribute("page",page);
		model.addAttribute("pstart",pstart);
		model.addAttribute("pend",pend);
		model.addAttribute("noticeGetChong",noticeGetChong);
		
		//ArrayList 처리
		return "/board/noticeList";
	}
}
