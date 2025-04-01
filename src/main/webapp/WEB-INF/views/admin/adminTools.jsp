<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section style="align-content: center">
			<div style="font-size: 25px">관리자 도구</div>
			<div>사용중인 관리자:${admin_userid}</div>
			<div><a href="/admin/memberManage">회원 관리</a></div><!-- 회원 상세조회(예약 내역, 작성한 후기, 활동기록 등), 회원 삭제 -->
			<div><a href="/admin/conformCancle">취소 및 환불 승인 관리</a></div>
			<div><a href="/admin/chkReservStatus">예약현황 관리</a></div><!-- 전체 예약 목록 조회, 특정 날짜별 예약 조회, 취소처리, 예약자 연락처 확인 및 메시지 발송 -->
			<div><a href="/admin/roomManage">파티룸 관리</a></div><!-- 등록,수정,삭제 -->
			<div><a href="/admin/noticeManage">공지사항 관리</a></div><!-- 글 등록,수정,삭제 -->
			<div><a href="/admin/qnaAnswer">Q&A 답변</a></div><!-- 문의 확인 및 답변 작성, 답변상태, 자주 묻는 질문(FAQ) 등록 및 관리 -->
			<div><a href="/admin/adminLoginHistory">관리자 로그인 기록</a></div>
			<div><a href="/admin/reviewManage">리뷰(후기) 관리</a></div><!-- 답변,삭제,통계확인? -->
			<div><a href="/admin/roomManagerCreate">룸매니저 권한 관리</a></div><!-- 룸매니저는 자신의 파티룸 관리만 가능 -->
			<div><a href="/admin/adminLogout">로그아웃(로그아웃 후 어드민 로그인 페이지로 이동)</a></div>
	</table>
</section>
</body>
</html>