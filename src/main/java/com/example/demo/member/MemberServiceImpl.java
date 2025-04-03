package com.example.demo.member;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.MyUtil;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.PersonalInquiryDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ms")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public String member()
	{
		return "/member/member";
	}
	@Override
	public String useridCheck(HttpServletRequest request)
	{
		String userid=request.getParameter("userid");
		return mapper.useridCheck(userid).toString();
	}
	@Override
	public String memberOk(MemberDto mdto)
	{
		//System.out.println("입력된 이메일: " + mdto.getEmail()); // 디버깅 출력
		Integer n=mapper.useridCheck(mdto.getUserid());
		if(n==0) //0이면 통과
		{
			mapper.memberOk(mdto);
			return "redirect:/login/login";
		}
		else
		{
			return "redirect:/member/member?err=1";
		}
	}
	@Override
	public String order(HttpSession session, Model model,HttpServletRequest request,ReservationDto rsdto,RoomDto rdto)
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			String start,end;
			int month;
	        if(request.getParameter("start")==null)
	        {
	        	month=0;
				if(request.getParameter("month")!=null)
				   month=Integer.parseInt(request.getParameter("month")); // 3 6 12
				
				// 오늘날짜
				LocalDate today=LocalDate.now(); 
				
				// month값에 해당되는 날짜 구하기
				LocalDate xday=today.minusMonths(month);
				
				start=xday.toString();
				end=today.toString();
	        }
	        else
	        {
	        	start=request.getParameter("start");
	        	end=request.getParameter("end");
	        	month=1;
	        	
	        	model.addAttribute("start",start);
	        	model.addAttribute("end",end);
	        }
			
		 
			ArrayList<HashMap> mapAll=mapper.order(userid,start,end, month);
			
			for(int i=0;i<mapAll.size();i++)
			{
			    HashMap map=mapAll.get(i);
			    // 키가 "status"인지 "state"인지 확인하고 그에 맞게 접근
			    // null 체크를 추가하여 NullPointerException 방지
			    int state = 0;
			    if(map.get("status") != null) {
			        state = Integer.parseInt(map.get("status").toString());
			    }
			    String stateStr = MyUtil.getState(state);
			    map.put("stateStr", stateStr);
			}
			
			model.addAttribute("mapAll",mapAll);
			
			
			return "/member/order";
		}
	}
	@Override
	public String cancelReserv(ReservationDto rsdto, HttpSession session)
	{
	    if(session.getAttribute("userid") == null)
	    {
	        return "redirect:/login/login";
	    }
	    
	    // 예약 상태 업데이트
	    mapper.updateReservationStatus(rsdto);
	    
	    return "redirect:/member/order";
	}
	@Override
	public String cancelReturnList(HttpSession session, Model model,HttpServletRequest request,ReservationDto rsdto,RoomDto rdto)
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			ArrayList<HashMap> mapAll=mapper.cancelReturnList();
			
			for(int i=0;i<mapAll.size();i++)
			{
			    HashMap map=mapAll.get(i);
			    // 키가 "status"인지 "state"인지 확인하고 그에 맞게 접근
			    // null 체크를 추가하여 NullPointerException 방지
			    int state = 2;
			    String stateStr=MyUtil.getState(state);
			    map.put("stateStr", stateStr);
			}
			model.addAttribute("mapAll",mapAll);
			return "/member/cancelReturnList";
		}
	}
	@Override
	public String personalInquiry(HttpSession session, Model model, HttpServletRequest request, PersonalInquiryDto pdto)
	{
		return "/member/personalInquiry";
	}
	
	@Override
	public String personalInquiryOk(MemberDto mdto, HttpSession session, Model model, HttpServletRequest request,
			PersonalInquiryDto pdto)
	{
			String userid = (String)session.getAttribute("userid");
			if(userid==null)
			{
				return"redirect:/login/login";
			}
			else
			{
			pdto.setUserid(userid);
		    mapper.personalInquiryOk(pdto);
			return "redirect:/member/personalInquiryList";
			}
	}
	@Override
	public String personalInquiryList(HttpSession session,Model model,HttpServletRequest request,PersonalInquiryDto pdto)
	{
		return "/member/personalInquiryList";
	}
}
