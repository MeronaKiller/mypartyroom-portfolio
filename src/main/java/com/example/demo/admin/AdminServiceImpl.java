package com.example.demo.admin;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.DaeDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.NoticeDto;
import com.example.demo.dto.PersonalInquiryDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;




@Service
@Qualifier("as")
public class AdminServiceImpl implements AdminService {
	@Autowired
	private AdminMapper mapper;
	
	
	@Override
	public String roomWrite(Model model)
	{
	    ArrayList<DaeDto> dlist = mapper.getDae();
	    model.addAttribute("dlist", dlist);
		
	    return "/admin/roomWrite";
	}
	
	@Override
	public ArrayList<SoDto> getSo(int daeid)
	{
		return mapper.getSo(daeid);
	}
	@Override
	public String getRcode(String rcode)	
	{
        //String rcode = String.valueOf(daeid) + String.valueOf(soid);
        int num = mapper.getNumber(rcode); // 마지막 번호 가져오기
        
        
        String imsi=String.format("%03d", num); // dae+so+3자리번호
        rcode=rcode+imsi;
        return rcode;
        
        
	}
	@Override
	public String roomWriteOk(RoomDto rdto
			,MultipartHttpServletRequest multi) throws Exception
	{
		// product테이블에 저장 => 파일의 이름
		// pic(메인그림), subpic(상세그림) => 저장된 파일명을 생성
		
		Iterator<String> it=multi.getFileNames(); //type="file"의 name을 가져온다
		String pic="";
		String subpic="";
		

		
		while(it.hasNext())
		{
			//System.out.println(it.next());
			String imsi=it.next(); //expic0, expic1, expic2, expic3 ~~
			
			MultipartFile file=multi.getFile(imsi);
			//파일명을 저장
			
			
		if(!file.isEmpty())
		{
			String oname=file.getOriginalFilename();
			
			if(imsi.equals("pic1"))
			{
				pic=oname;
			}
			else
			{
				subpic=subpic+oname+"/";
			}
			// 실제로 업로된 파일을 저장폴더(static/room)에 저장
			String str=ResourceUtils.getFile("src/main/resources/static/room").toString();
			//"classpath:static/room"
			//파일의 유무는 파일의 객체를 생성해서 한다.
			File sfile=new File(str+"/"+oname);
			
			while(sfile.exists())
			{
				// 새 파일명을 생성 후
				String[] fnames=oname.split("[.]"); // "abc.jpg"
				
				oname=fnames[0]+System.currentTimeMillis()+"."+fnames[1];
					// abc+ 12345678 + . + jpg => abc12345678.jpg
				// 다시 파일객체를 생성한다.
				sfile=new File(str+"/"+oname);
			}
			Path path=Paths.get(str+"/"+oname);
			Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

	        // 1. type="file"에 사진을 선택하지 않았을 경우
	        // 2. 업로드된 파일이 존재한다면 파일명을 변경하기
	        // 3. pic,subpic값을 dto에 저장 후 mapper에 전송하여 테이블에 저장
			// if문( file이 비었는지 체크)의 끝
		}
	}
		

			
	 // while 문
		
		//dto에 subpic,pic의 값을 setter

		rdto.setSubpic(subpic);
		rdto.setPic(pic);
		

		
		mapper.roomWriteOk(rdto);
		
		return "/admin/roomManage";
	}
	@Override
	public String adminLogin(HttpServletRequest request,Model model,HttpSession session,AdminDto adto)
	{
		String err=request.getParameter("err");
		model.addAttribute("err",err);
		
		return "/admin/adminLogin";
	}
	@Override
	public String adminLoginOk(HttpServletRequest request,HttpSession session,AdminDto adto)
	{
		String admin_name=mapper.adminLoginOk(adto); // 이름(아이디x) 변수
		
		if(admin_name == null)
		{
			return "redirect:/admin/adminLogin?err=1";
		}
		else
		{
			//세션변수 할당 후, 메인페이지로 이동
			session.setAttribute("admin_userid", adto.getAdmin_userid());
			session.setAttribute("admin_name", admin_name);
			
		  return "redirect:/admin/adminTools";
		}
	}
	@Override
	public String adminLogout(HttpSession session)
	{
		session.invalidate();
		return "/admin/adminLogin";
	}
	@Override
	public String memberManage(MemberDto mdto, Model model) {	
	    try {
	        System.out.println("🔍 memberManage 서비스 호출됨");
	        
	        // ✅ 수정: getAllMember 호출 방식 변경
	        ArrayList<MemberDto> mlist = mapper.getAllMember(0); // 0은 전체 조회를 의미
	        
	        System.out.println("📊 조회된 회원 수: " + (mlist != null ? mlist.size() : "null"));
	        
	        if (mlist != null && !mlist.isEmpty()) {
	            MemberDto firstMember = mlist.get(0);
	            System.out.println("👤 첫 번째 회원:");
	            System.out.println("   - memberid: " + firstMember.getMemberid());
	            System.out.println("   - userid: " + firstMember.getUserid());
	            System.out.println("   - created_day: " + firstMember.getCreated_day());
	            System.out.println("   - status: " + firstMember.getStatus());
	        }
	        
	        model.addAttribute("mlist", mlist);
	        System.out.println("✅ mlist 모델에 추가 완료");
	        
	    } catch (Exception e) {
	        System.err.println("❌ memberManage 에러: " + e.getMessage());
	        e.printStackTrace();
	        model.addAttribute("mlist", new ArrayList<MemberDto>());
	    }
	    
	    return "/admin/memberManage";
	}
	@Override
	public String conformCancle(MemberDto mdto, ReservationDto rsdto, Model model) {
	    System.out.println("🔍 conformCancle 서비스 시작");
	    System.out.println("📋 mdto.getUserid(): '" + mdto.getUserid() + "'");
	    System.out.println("📋 mdto.getMemberid(): " + mdto.getMemberid());
	    
	    ArrayList<MemberDto> mlist = mapper.getAllMember(mdto.getMemberid());
	    
	    // ✅ userid를 null로 전달해서 모든 취소 요청 가져오기
	    ArrayList<ReservationDto> rslist = mapper.getCancleRequest(null);
	    
	    System.out.println("📊 조회된 취소 요청 수: " + (rslist != null ? rslist.size() : "null"));
	    
	    model.addAttribute("mlist", mlist);
	    model.addAttribute("rslist", rslist);
	    return "/admin/conformCancle";
	}
	@Override
	public String conformCancleOk(int reservationId)
	{
		mapper.updateReservationStatus(reservationId, 2);
	    return "redirect:/admin/conformCancle";
	}
	@Override
	public String conformCancleNo(int reservationId1) {
		mapper.updateReservationStatus(reservationId1, 0);
		return "redirect:/admin/conformCancle";
	}
	@Override
	public String deleteUser(int memberid) {
		mapper.deleteUser(memberid, 1);
		return "redirect:/admin/memberManage";
	}
	@Override
	public String reviveUser(int memberid) {
		mapper.reviveUser(memberid, 0);
		return "redirect:/admin/memberManage";
	}
	@Override 
	public String roomDelete(RoomDto rdto, Model model) {
	    try {
	        System.out.println("🔍 roomDelete 서비스 호출됨");
	        
	        // ✅ 매개변수 없는 roomDelete() 호출
	        ArrayList<RoomDto> rlist = mapper.roomDelete();
	        
	        System.out.println("📊 조회된 room 데이터 수: " + (rlist != null ? rlist.size() : "null"));
	        
	        if (rlist != null && !rlist.isEmpty()) {
	            RoomDto firstRoom = rlist.get(0);
	            System.out.println("🏠 첫 번째 room:");
	            System.out.println("   - roomid: " + firstRoom.getRoomid());
	            System.out.println("   - name: " + firstRoom.getName());
	            System.out.println("   - duration_type: " + firstRoom.getDuration_type());
	        }
	        
	        model.addAttribute("rlist", rlist);
	        System.out.println("✅ rlist 모델에 추가 완료");
	        
	    } catch (Exception e) {
	        System.err.println("❌ roomDelete 서비스 에러: " + e.getMessage());
	        e.printStackTrace();
	        model.addAttribute("rlist", new ArrayList<RoomDto>());
	    }
	    
	    return "/admin/roomDelete";
	}
	@Override
	public String roomDeleteOk(int roomid) {
	    try {
	        System.out.println("🗑️ roomDeleteOk 호출: roomid=" + roomid);
	        
	        // ✅ duration_type = 1 (삭제됨)
	        mapper.roomDeleteOk(roomid, 1);
	        
	        System.out.println("✅ 룸 삭제 완료: roomid=" + roomid);
	        
	    } catch (Exception e) {
	        System.err.println("❌ roomDeleteOk 에러: " + e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return "redirect:/admin/roomDelete";
	}

	@Override
	public String roomReviveOk(int roomid) {
	    try {
	        System.out.println("🔄 roomReviveOk 호출: roomid=" + roomid);
	        
	        // ✅ duration_type = 2 (활성)
	        mapper.roomReviveOk(roomid, 2);
	        
	        System.out.println("✅ 룸 복구 완료: roomid=" + roomid);
	        
	    } catch (Exception e) {
	        System.err.println("❌ roomReviveOk 에러: " + e.getMessage());
	        e.printStackTrace();
	    }
	    
	    return "redirect:/admin/roomDelete";
	}
	@Override
	public String noticeManage(NoticeDto ndto,Model model,HttpServletRequest request)
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
		ArrayList<NoticeDto> nlist=mapper.noticeManage(index);
		
		
		model.addAttribute("nlist",nlist);
		model.addAttribute("page",page);
		model.addAttribute("pstart",pstart);
		model.addAttribute("pend",pend);
		model.addAttribute("noticeGetChong",noticeGetChong);
		
		//ArrayList 처리
		return "/admin/noticeManage";
	}
	@Override
	public String noticeContentManage(NoticeDto ndto, Model model, HttpServletRequest request)
	{
	    int noticeid = Integer.parseInt(request.getParameter("noticeList"));
	    NoticeDto notice = mapper.getNoticeContentManage(noticeid);
	    model.addAttribute("notice", notice);
	    return "/admin/noticeContentManage";
	}
	@Override
	public String noticeWrite(Model model)
	{
	    return "/admin/noticeWrite";
	}
	@Override
	public String noticeWriteOk(NoticeDto ndto)
	{
		mapper.noticeWriteOk(ndto);
		
		return "redirect:/admin/noticeManage";
	}
	@Override
	public String noticeContentDeleteOk(int noticeid)
	{
		mapper.noticeContentDeleteOk(noticeid, 1);//1이 비활성화 
	    return "redirect:/admin/noticeManage";
	}
	@Override
	public String noticeContentReviveOk(int noticeid)
	{
		mapper.noticeContentReviveOk(noticeid, 0);//0이 복구
		return "redirect:/admin/noticeManage";
	}
	@Override
	public String qnaAnswer(Model model, HttpServletRequest request) {
	    // 시작페이지 인덱스값 구하기
	    int page;
	    if(request.getParameter("page")==null) {
	        page=1;
	    } else {
	        page=Integer.parseInt(request.getParameter("page"));
	    }
	    
	    int pstart, pend, qnaGetChong;
	    
	    pstart=page/10;
	    if(page%10==0)
	        pstart=pstart-1;
	    
	    pstart=(pstart*10)+1;
	    pend=pstart+9;
	    
	    qnaGetChong=mapper.qnaGetChong();
	    if(pend>qnaGetChong)
	        pend=qnaGetChong;
	    
	    int index=(page-1)*20;
	    ArrayList<PersonalInquiryDto> qlist=mapper.getPersonalInquiryList(index);
	    
	    model.addAttribute("qlist", qlist);
	    model.addAttribute("page", page);
	    model.addAttribute("pstart", pstart);
	    model.addAttribute("pend", pend);
	    model.addAttribute("qnaGetChong", qnaGetChong);
	    
	    return "/admin/qnaAnswer";
	}

	@Override
	public String qnaContent(int personalInquiryid, Model model) {
	    PersonalInquiryDto qdto = mapper.getPersonalInquiry(personalInquiryid);
	    model.addAttribute("qdto", qdto);
	    return "/admin/qnaContent";
	}

	@Override
	public String qnaAnswerOk(int personalInquiryid)
	{
		mapper.qnaAnswerOk(personalInquiryid, 1);//1이 답변완료
		return "redirect:/admin/qnaAnswer";
	}
}
