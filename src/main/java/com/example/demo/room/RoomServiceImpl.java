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
		model.addAttribute("rlistSize", rlist.size());
		
		return "/room/roomList";
	}
	
	@Override
	public String roomContent(HttpServletRequest request, Model model,
	                         HttpSession session, RoomDto rdto, ReservationDto rsdto)
		{
	    String rcode = request.getParameter("rcode");
	    
	    // request 파라미터에서 rcode를 가져오되, 없으면 rdto에서 가져옴
	    if (rcode == null || rcode.isEmpty()) {
	        rcode = rdto.getRcode();
	    }
	    
	    // rcode로 방 정보 조회
	    RoomDto roomInfo = mapper.roomContent(rcode);
	    
	    // 방이 존재하지 않거나 duration_type이 2가 아닌 경우
	    if (roomInfo == null || roomInfo.getDuration_type() != 2) {
	        // 경고창을 표시하는 JavaScript 코드를 모델에 추가
	        model.addAttribute("alertScript", 
	            "alert('존재하지 않거나 접근할 수 없는 페이지입니다.');");
	        
	        // 원래 페이지로 이동 없이 경고창만 표시
	        model.addAttribute("errorMessage", "존재하지 않거나 접근할 수 없는 페이지입니다.");
	        
	        // 오류 메시지가 포함된 원래 페이지 반환
	        return "/room/roomContent";
	    }
	    
	    // 할인가 계산
	    int halin = roomInfo.getHalin();
	    int price = roomInfo.getPrice();
	    double discountRate = halin / 100.0;
	    int halinprice = (int) Math.round(price - (price * discountRate)); // 할인 적용된 상품금액
	    
	    roomInfo.setHalinprice(halinprice);
	    
	    // 모델에 정보 추가 (중복 제거)
	    model.addAttribute("rdto", roomInfo);
	    model.addAttribute("roomInfo", roomInfo);
	    
	    return "/room/roomContent";
	}
	
	@Override
	public String roomReserv(HttpServletRequest request, HttpSession session, Model model) {
	    String rcode = request.getParameter("rcode");
	    
	    if(session.getAttribute("userid") == null) {
	        return "redirect:/login/login?rcode=" + rcode;
	    } else {
	        String userid = session.getAttribute("userid").toString();
	        
	        // 회원 정보 가져오기
	        MemberDto mdto = mapper.getMember(userid);
	        model.addAttribute("mdto", mdto);
	        
	        // 룸 정보 가져오기
	        RoomDto rdto = mapper.roomContent(rcode);
	        
	        int halin = rdto.getHalin();
	        int price = rdto.getPrice();
	        double discountRate = halin / 100.0;
	        int halinprice = (int) Math.round(price - (price * discountRate));
	        
	        // 패키지 정보가 있는 경우 가격 재계산
	        String selectedPackage = request.getParameter("selectedPackage");
	        if(selectedPackage != null && !selectedPackage.isEmpty()) {
	            String[] packageParts = selectedPackage.split(",");
	            if(packageParts.length >= 2) {
	                try {
	                    halinprice = Integer.parseInt(packageParts[1]);
	                } catch (NumberFormatException e) {
	                    // 가격 파싱 실패 시 기본 가격 유지
	                }
	            }
	        }
	        
	        rdto.setHalinprice(halinprice);
	        model.addAttribute("rdto", rdto);
	        model.addAttribute("rcode", rcode);
	        
	        String selectedDate = request.getParameter("selectedDate");
	        String startTime = request.getParameter("startTime");
	        String endTime = request.getParameter("endTime");
	        
	        // 날짜 포맷 변경 (2025-03-18 -> 2025.03.18)
	        String formattedDate = selectedDate.replace("-", ".");
	        
	        // 요일 추출
	        LocalDate date = LocalDate.parse(selectedDate);
	        String dayOfWeek = date.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);
	        
	        // 시간에서 분 제거 (11:00 → 11)
	        String formattedStartTime = startTime.substring(0, 2);
	        String formattedEndTime = endTime.substring(0, 2);
	        
	        model.addAttribute("formattedDate", formattedDate);
	        model.addAttribute("dayOfWeek", dayOfWeek);
	        model.addAttribute("selectedDate", selectedDate);
	        model.addAttribute("startTime", formattedStartTime);
	        model.addAttribute("endTime", formattedEndTime);
	        
	        // 패키지 정보 전달
	        if(selectedPackage != null) {
	            model.addAttribute("selectedPackage", selectedPackage);
	        }
	    }
	    return "/room/roomReserv";
	}
	
	@Override
	public String reservOk(ReservationDto rsdto, HttpSession session) {
	    if(session.getAttribute("userid") == null) {
	        return "redirect:/login/login";
	    } else {
	        String userid = session.getAttribute("userid").toString();
	        rsdto.setUserid(userid);
	        
	        // 주문코드 만들기
	        String today = LocalDate.now().toString().replace("-", "");
	        String jumuncode = "j" + today;
	        int num = mapper.getNumber(jumuncode);
	        jumuncode = jumuncode + String.format("%03d", num);
	        rsdto.setJumuncode(jumuncode);
	        
	        String[] rcodes = rsdto.getRcode().split("/");
	        
	        for(int i = 0; i < rcodes.length; i++) {
	            rsdto.setRcode(rcodes[i]);
	            
	            // 패키지 정보가 있는 경우 처리
	            if(rsdto.getSelectedPackage() != null && !rsdto.getSelectedPackage().isEmpty()) {
	                // 패키지 정보를 데이터베이스에 저장하거나 다른 처리를 수행
	                // 예: rsdto.setPackageInfo(rsdto.getSelectedPackage());
	            }
	            
	            String fullStartTime = rsdto.getSelectedDate() + " " + rsdto.getStartTime();
	            String fullEndTime = rsdto.getSelectedDate() + " " + rsdto.getEndTime();
	            
	            rsdto.setStartTime(fullStartTime);
	            rsdto.setEndTime(fullEndTime);
	            
	            mapper.reservOk(rsdto);
	        }
	        return "redirect:/room/reservList?jumuncode=" + jumuncode;
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
	public String reservChk(HttpSession session, HttpServletRequest request, Model model, MemberDto mdto, ReservationDto rsdto, RoomDto rdto) {
	    if(session.getAttribute("userid")==null) {
	        return "redirect:/login/login";
	    } else {    
	        String userid = session.getAttribute("userid").toString();
	        
	        // reservationid 파라미터 처리 추가
	        String reservationId = request.getParameter("reservationid");
	        String jumuncode = request.getParameter("jumuncode");
	        
	        // reservationid가 있으면 이를 이용해 jumuncode 찾기
	        if(reservationId != null && !reservationId.isEmpty()) {
	            // 이 부분을 구현하려면 reservationid로 jumuncode를 조회하는 매퍼 메소드가 필요합니다.
	            // 임시로 직접 jumuncode를 사용하는 방식으로 진행
	        }
	        
	        // 주문 코드로 예약 정보 조회
	        if(jumuncode != null && !jumuncode.isEmpty()) {
	            rsdto.setJumuncode(jumuncode);
	        } else {
	            // 파라미터가 없는 경우 사용자의 최근 예약 사용
	            ArrayList<ReservationDto> userReservations = mapper.getReservationsByUserId(userid);
	            
	            if(userReservations == null || userReservations.isEmpty()) {
	                return "redirect:/";
	            }
	            
	            jumuncode = userReservations.get(0).getJumuncode();
	            rsdto.setJumuncode(jumuncode);
	        }
	        
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
	@Override
	public void addLike(String userId, int roomid) {
	    // 이미 좋아요 했는지 확인
	    boolean alreadyLiked = mapper.isLikedByUser(userId, roomid);
	    
	    if (!alreadyLiked) {
	        mapper.insertLike(userId, roomid);
	    }
	}

	@Override
	public void removeLike(String userId, int roomid) {
	    // 좋아요 여부 확인
	    boolean liked = mapper.isLikedByUser(userId, roomid);
	    
	    if (liked) {
	        // 좋아요 취소
	        mapper.deleteLike(userId, roomid);
	        mapper.decreaseRoomLike(roomid);
	    }
	}

	@Override
	public boolean isLikedByUser(String userId, int roomid) {
	    if (userId == null) {
	        return false;
	    }
	    return mapper.isLikedByUser(userId, roomid);
	}

	@Override
	public String getRcodeByroomid(int roomid) {
	    return mapper.getRcodeByroomid(roomid);
	}
	@Override
	public void increaseRoomLike(int roomid) {
	    mapper.increaseRoomLike(roomid);
	}
}
