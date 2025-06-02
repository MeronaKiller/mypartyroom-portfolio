package com.example.demo.admin;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.DaeDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.NoticeDto;
import com.example.demo.dto.PersonalInquiryDto;
import com.example.demo.dto.ReservationDto;
import com.example.demo.dto.RoomDto;
import com.example.demo.dto.SoDto;

@Mapper
public interface AdminMapper {
    
    // 기존 메서드들
    ArrayList<DaeDto> getDae();
    ArrayList<SoDto> getSo(int daeid);
    int getNumber(String jumuncode);
    void roomWriteOk(RoomDto rdto);
    String adminLoginOk(AdminDto adto);
    
    // 회원 관리
    ArrayList<MemberDto> getAllMember(@Param("memberid") int memberid);
    void deleteUser(@Param("memberid") int memberid, @Param("status") int status);
    void reviveUser(@Param("memberid") int memberid, @Param("status") int status);
    
    // 예약 취소 관리
    ArrayList<ReservationDto> getCancleRequest(@Param("userid") String userid);
    void updateReservationStatus(@Param("reservationId") int reservationId, @Param("status") int status);
    void updateReservationStatus1(ReservationDto rdto);
    
    // 룸 삭제 관리
    ArrayList<RoomDto> roomDelete(); // 매개변수 없는 버전 추가
    void roomDeleteOk(@Param("roomid") int roomid, @Param("duration_type") int duration_type);
    void roomReviveOk(@Param("roomid") int roomid, @Param("duration_type") int duration_type);
    
    // 공지사항 관리
    ArrayList<NoticeDto> noticeManage(@Param("index") int index);
    int noticeGetChong();
    NoticeDto getNoticeContentManage(@Param("noticeid") int noticeid);
    void noticeWriteOk(NoticeDto ndto);
    void noticeContentDeleteOk(@Param("noticeid") int noticeid, @Param("state") int state);
    void noticeContentReviveOk(@Param("noticeid") int noticeid, @Param("state") int state);
    
    // QnA 관리
    ArrayList<PersonalInquiryDto> getPersonalInquiryList(@Param("index") int index);
    PersonalInquiryDto getPersonalInquiry(@Param("personalInquiryid") int personalInquiryid);
    void qnaAnswerOk(@Param("personalInquiryid") int personalInquiryid, @Param("state") int state);
    int qnaGetChong();
}