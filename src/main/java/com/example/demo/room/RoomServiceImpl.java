package com.example.demo.room;

import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("rs")
public class RoomServiceImpl implements RoomService {
	@Autowired
	private RoomMapper mapper;
	
	@Override
	public String roomInfo(HttpServletRequest request,Model model,RoomDto rdto)
	{
		ArrayList<RoomDto> rlist=mapper.roomInfo(rdto.getRoomid());
		model.addAttribute("rlist",rlist);
		return "/room/roomInfo";
	}
	@Override
	public String roomList(HttpServletRequest request,Model model,RoomDto rdto)
	{
		
		String searchKeyword = request.getParameter("searchKeyword");
		    
		ArrayList<RoomDto> rlist = mapper.RoomList(rdto.getRcode(), searchKeyword);
		
		model.addAttribute("rlist", rlist);
		model.addAttribute("rcode",rdto.getRcode());
		model.addAttribute("searchKeyword", searchKeyword);
		
		return "/room/roomList";
	}
	
	@Override
	public String roomContent(HttpServletRequest request,Model model,
			HttpSession session,RoomDto rdto,ReservationDto rsdto)
	{	
		RoomDto roomInfo = mapper.roomContent(rdto.getRcode());
		int halin=roomInfo.getHalin();
		int price=roomInfo.getPrice();
		double discountRate = halin / 100.0;
		int halinprice = (int) Math.round(price - (price * discountRate)); //할인 적용된 상품금액
		
		roomInfo.setHalinprice(halinprice);
		model.addAttribute("roomInfo",roomInfo);
		
		model.addAttribute("rdto",mapper.roomContent(rdto.getRcode()));
		return "/room/roomContent";
	}
	
	@Override
	public String roomReserv(HttpServletRequest request,HttpSession session,Model model)
	{
		String rcode=request.getParameter("rcode");
		
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login?rcode="+rcode;
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			
			//회원 정보 가져오기
			MemberDto mdto=mapper.getMember(userid);
			model.addAttribute("mdto",mdto);
			
			
			//룸 정보 가져오기
			RoomDto rdto=mapper.roomContent(rcode);
			
			int halin=rdto.getHalin();
			int price=rdto.getPrice();
			double discountRate = halin / 100.0;
			int halinprice = (int) Math.round(price - (price * discountRate)); //할인 적용된 상품금액
			
			rdto.setHalinprice(halinprice);
			model.addAttribute("rdto",rdto);
			model.addAttribute("rcode", rcode);
			
			String selectedDate = request.getParameter("selectedDate");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			
		 // 1. 날짜 포맷 변경 (2025-03-18 -> 2025.03.18)
		    String formattedDate = selectedDate.replace("-", ".");

		    // 2. 요일 추출
		    LocalDate date = LocalDate.parse(selectedDate);
		    String dayOfWeek = date.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN); // 화

		    // 3. 시간에서 분 제거 (11:00 → 11)
		    String formattedStartTime = startTime.substring(0, 2); // "11"
		    String formattedEndTime = endTime.substring(0, 2);     // "12"
		    
		    model.addAttribute("formattedDate", formattedDate);
		    model.addAttribute("dayOfWeek", dayOfWeek);
		    model.addAttribute("selectedDate", selectedDate);
		    model.addAttribute("startTime", formattedStartTime);
		    model.addAttribute("endTime", formattedEndTime);
		}
		return "/room/roomReserv";
	}
	
	@Override
	public String reservOk(ReservationDto rsdto, HttpSession session)
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			System.out.println(rsdto.getSelectedDate()+" "+rsdto.getStartTime()+" "+rsdto.getEndTime());
			
 			String userid=session.getAttribute("userid").toString();
			rsdto.setUserid(userid);		
			//주문코드 만들기 => j20250211 + 001
			String today=LocalDate.now().toString();
			today=today.replace("-", "");
			String jumuncode="j"+today;
		
			int num=mapper.getNumber(jumuncode);
			jumuncode=jumuncode+String.format("%03d", num);
			rsdto.setJumuncode(jumuncode);
			
			String[] rcodes=rsdto.getRcode().split("/");
			
			for(int i=0;i<rcodes.length;i++)
			{
				//배열에 각 요소에 있는 rcode로 setter
				rsdto.setRcode(rcodes[i]);
				
				String fullStartTime=rsdto.getSelectedDate()+" "+rsdto.getStartTime();
				String fullEndTime=rsdto.getSelectedDate()+" "+rsdto.getEndTime();
				
				rsdto.setStartTime(fullStartTime);
	            rsdto.setEndTime(fullEndTime);
				
				mapper.reservOk(rsdto);
				
			
			}
			return "redirect:/room/reservList?jumuncode="+jumuncode;
			
		}
	
	}
	@Override
	public String reservList(HttpSession session, HttpServletRequest request,Model model,MemberDto mdto, ReservationDto rsdto, RoomDto rdto)
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{	
			String userid=session.getAttribute("userid").toString();
			
			
	        ReservationDto reservationData = mapper.reservList(rsdto);
	        model.addAttribute("rsdto", reservationData);

	        String rcode = reservationData.getRcode(); 

	        RoomDto roomData = mapper.roomContent(rcode);
	        model.addAttribute("rdto", roomData);
	        model.addAttribute("rcode", rcode);
	        model.addAttribute("mdto", mapper.getMember(userid));
			return "/room/reservList";
		}
	}
	@Override
	public String reservChk(HttpSession session, HttpServletRequest request, Model model, MemberDto mdto, ReservationDto rsdto, RoomDto rdto)
	{
	    if(session.getAttribute("userid")==null)
	    {
	        return "redirect:/login/login";
	    }
	    else
	    {    
	        String userid = session.getAttribute("userid").toString();
	        String jumuncode = request.getParameter("jumuncode");
	        
	        // 주문 코드가 전달되지 않은 경우
	        if(jumuncode == null || jumuncode.isEmpty()) {
	            // 사용자의 가장 최근 예약 정보 가져오기
	            ArrayList<ReservationDto> userReservations = mapper.getReservationsByUserId(userid);
	            
	            if(userReservations == null || userReservations.isEmpty()) {
	                // 예약 정보가 없는 경우
	                return "redirect:/";
	            }
	            
	            // 가장 최근 예약의 주문 코드 사용
	            jumuncode = userReservations.get(0).getJumuncode();
	        }
	        
	        // 주문 코드로 예약 정보 조회
	        rsdto.setJumuncode(jumuncode);
	        ReservationDto reservationData = mapper.reservChk(rsdto);
	        
	        if(reservationData == null) {
	            return "redirect:/";
	        }
	        
	        model.addAttribute("rsdto", reservationData);
	        
	        String rcode = reservationData.getRcode(); 
	        
	        RoomDto roomData = mapper.roomContent(rcode);
	        model.addAttribute("rdto", roomData);
	        model.addAttribute("rcode", rcode);
	        model.addAttribute("mdto", mapper.getMember(userid));
	        
	        return "/room/reservChk";
	    }
	}
	@Override
	public ArrayList<ReservationDto> getReservTime(HttpServletRequest request) 
	{
		String rcode=request.getParameter("rcode");
		String ymd=request.getParameter("ymd");
		
		return mapper.getReservTime(rcode,ymd);
	}
}
