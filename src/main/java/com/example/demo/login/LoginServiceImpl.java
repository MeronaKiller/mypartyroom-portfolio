package com.example.demo.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService {
	@Autowired
	private LoginMapper mapper;
	
	@Override
	public String login(HttpServletRequest request,Model model,HttpSession session,MemberDto mdto)
	{
		
		String err=request.getParameter("err");
		model.addAttribute("err",err);
		
		
		
		return "/login/login";
	}
	@Override
	public String loginOk(HttpServletRequest request,HttpSession session,MemberDto mdto)
	{
		String name=mapper.loginOk(mdto); // 이름(아이디x) 변수
		
		String rcode=request.getParameter("rcode");
		if(name == null)
		{
			if(rcode != null && !rcode.isEmpty())
			{
				return "redirect:/login/login?err=1&rcode="+rcode;
			}
			return "redirect:/login/login?err=1";
		}
		else
		{
			//세션변수 할당 후, 메인페이지로 이동
			session.setAttribute("userid", mdto.getUserid());
			session.setAttribute("name", name);
			
			if(rcode != null && !rcode.isEmpty())
			{
				return "redirect:/room/roomReserv?rcode="+rcode;
			}
		  return "redirect:/main/main";
		}
	}
	@Override
	public String logout(HttpSession session)
	{
		session.invalidate();
		return "redirect:/main/main";
	}
}
