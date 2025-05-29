package com.example.demo.admin;

import java.util.ArrayList;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
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


 public interface AdminService {

	String roomWrite(Model model);
	ArrayList<SoDto> getSo(int daeid);
	String getRcode(String rcode);
	String roomWriteOk(RoomDto rdto, MultipartHttpServletRequest multi) throws Exception;
	String adminLogin(HttpServletRequest request, Model model, HttpSession session, AdminDto adto);
	String adminLoginOk(HttpServletRequest request, HttpSession session, AdminDto adto);
	String adminLogout(HttpSession session);
	String memberManage(MemberDto mdto, Model model);
	String conformCancle(MemberDto mdto, ReservationDto rsdto, Model model);
	String conformCancleOk(int reservationId);
	String conformCancleNo(int reservationId1);
	String deleteUser(int memberid);
	String reviveUser(int memberid1);
	String roomDelete(RoomDto rdto, Model model);
	String roomDeleteOk(int roomid);
	String roomReviveOk(int roomid);
	String noticeManage(NoticeDto ndto, Model model, HttpServletRequest request);
	String noticeContentManage(NoticeDto ndto, Model model, HttpServletRequest request);
	String noticeWrite(Model model);
	String noticeWriteOk(NoticeDto ndto);
	String noticeContentDeleteOk(int noticeid);
	String noticeContentReviveOk(int noticeid);
	String qnaAnswer(Model model, HttpServletRequest request);
	String qnaContent(int personalInquiryid, Model model);
	String qnaAnswerOk(int personalInquiryid);
}
