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
	public String memberManage(MemberDto mdto,Model model)
	{	
		ArrayList<MemberDto> mlist=mapper.getAllMember(mdto.getMemberid());
		
		model.addAttribute("mlist",mlist);
		
		return "/admin/memberManage";
	}
	@Override
	public String conformCancle(MemberDto mdto, ReservationDto rsdto, Model model)
	{
		ArrayList<MemberDto> mlist=mapper.getAllMember(mdto.getMemberid());
	    ArrayList<ReservationDto> rslist=mapper.getCancleRequest(mdto.getUserid());
	    
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
}
