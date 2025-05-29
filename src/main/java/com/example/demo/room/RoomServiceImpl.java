package com.example.demo.room;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
	
	@Autowired
	private ReservationQueueService reservationQueueService;
	
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
	        
	    }
	    return "/room/roomReserv";
	}
	
	@Override
	@Transactional
	public String reservOk(ReservationDto rsdto, HttpSession session) {
	    System.out.println("🔍 reservOk 메서드 시작");
	    System.out.println("받은 데이터: " + rsdto.getRcode() + ", " + rsdto.getSelectedDate());
	    
	    // ✅ 날짜 검증 추가
	    if (rsdto.getSelectedDate() == null || rsdto.getSelectedDate().contains("{{")) {
	        System.err.println("❌ 잘못된 날짜 형식: " + rsdto.getSelectedDate());
	        return "redirect:/room/reservFailure";
	    }
	    
	    // ✅ 시간 검증 추가
	    if (rsdto.getStartTime() == null || rsdto.getEndTime() == null) {
	        System.err.println("❌ 시작/종료 시간이 null입니다");
	        return "redirect:/room/reservFailure";
	    }
	    
	    // 테스트용 고정 사용자
	    String userid = "testuser";
	    System.out.println("✅ userid: " + userid);
	    rsdto.setUserid(userid);
	    
	    // 주문코드 생성
	    String today = LocalDate.now().toString().replace("-", "");
	    String jumuncode = "j" + today;
	    int num = mapper.getNumber(jumuncode);
	    jumuncode = jumuncode + String.format("%03d", num);
	    rsdto.setJumuncode(jumuncode);
	    
	    String[] rcodes = rsdto.getRcode().split("/");
	    int successCount = 0;
	    
	    for(int i = 0; i < rcodes.length; i++) {
	        try {
	            ReservationDto newReservation = new ReservationDto();
	            
	            // 기존 데이터 복사
	            newReservation.setUserid(userid);
	            newReservation.setJumuncode(jumuncode);
	            newReservation.setRcode(rcodes[i]);
	            newReservation.setCard1(rsdto.getCard1());
	            newReservation.setTel(rsdto.getTel());
	            newReservation.setHalbu1(rsdto.getHalbu1());
	            newReservation.setBank1(rsdto.getBank1());
	            newReservation.setCard2(rsdto.getCard2());
	            newReservation.setBank2(rsdto.getBank2());
	            newReservation.setPurposeuse(rsdto.getPurposeuse());
	            newReservation.setRequesttohost(rsdto.getRequesttohost());
	            newReservation.setReservprice(rsdto.getReservprice());
	            
	            // ✅ 날짜 형식 검증 및 시간 설정
	            String fullStartTime = rsdto.getSelectedDate() + " " + rsdto.getStartTime();
	            String fullEndTime = rsdto.getSelectedDate() + " " + rsdto.getEndTime();
	            
	            // 날짜 형식 재검증
	            try {
	                LocalDateTime.parse(fullStartTime.replace(" ", "T"));
	                LocalDateTime.parse(fullEndTime.replace(" ", "T"));
	            } catch (Exception e) {
	                System.err.println("❌ 날짜 파싱 오류: " + e.getMessage());
	                continue;
	            }
	            
	            System.out.println("🕐 받은 시간: startTime=" + rsdto.getStartTime() + ", endTime=" + rsdto.getEndTime());
	            System.out.println("🕐 최종 시간: " + fullStartTime + " ~ " + fullEndTime);
	            
	            newReservation.setStartTime(fullStartTime);
	            newReservation.setEndTime(fullEndTime);
	            
	            // 큐에 추가
	            boolean added = reservationQueueService.enqueue(newReservation);
	            if (added) {
	                successCount++;
	                System.out.println("✅ 큐 추가 성공: " + rcodes[i] + " | " + fullStartTime + "~" + fullEndTime);
	            } else {
	                System.out.println("⚠️ 큐 추가 실패: " + rcodes[i] + " (중복 또는 큐 포화)");
	            }
	            
	        } catch (Exception e) {
	            System.err.println("❌ 큐 추가 실패: " + e.getMessage());
	            e.printStackTrace();
	        }
	    }
	    
	    System.out.println("📊 총 " + rcodes.length + "건 중 " + successCount + "건 큐 추가 성공");
	    
	    if (successCount == 0) {
	        return "redirect:/room/reservFailure";
	    }
	    
	    return "redirect:/room/reservList?jumuncode=" + jumuncode;
	}
	
	@Override
	public String reservList(HttpSession session, HttpServletRequest request, Model model, MemberDto mdto, ReservationDto rsdto, RoomDto rdto) {
	    if(session.getAttribute("userid") == null) {
	        return "redirect:/login/login";
	    } else {    
	        System.out.println("🔍 reservList 실행됨");
	        System.out.println("jumuncode: " + request.getParameter("jumuncode"));
	        
	        try {
	            ReservationDto reservationData = mapper.reservList(rsdto);
	            
	            // null 체크 추가
	            if (reservationData == null) {
	                System.out.println("❌ reservationData가 null입니다.");
	                System.out.println("전달받은 jumuncode: " + rsdto.getJumuncode());
	                
	                // 에러 페이지로 이동하거나 기본값 설정
	                model.addAttribute("errorMessage", "예약 정보를 찾을 수 없습니다.");
	                return "/room/reservFailure"; // 또는 다른 에러 페이지
	            }
	            
	            System.out.println("✅ reservationData 조회 성공: " + reservationData.getRcode());
	            
	            model.addAttribute("rsdto", reservationData);

	            String rcode = reservationData.getRcode(); 

	            RoomDto roomData = mapper.roomContent(rcode);
	            model.addAttribute("rdto", roomData);
	            model.addAttribute("rcode", rcode);
	            
	            return "/room/reservList";
	            
	        } catch (Exception e) {
	            System.err.println("reservList 에러: " + e.getMessage());
	            e.printStackTrace();
	            model.addAttribute("errorMessage", "예약 정보 조회 중 오류가 발생했습니다.");
	            return "/room/reservFailure";
	        }
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
