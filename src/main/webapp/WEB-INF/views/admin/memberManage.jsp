<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 회원 상세조회(예약 내역, 작성한 후기, 활동기록 등), 회원 삭제 -->
<section>
<table>
	<tr>
		<td>번호</td>
		<td>회원 이름</td>
		<td>회원 아이디</td>
		<td>회원 이메일</td>
		<td>회원 전화번호</td>
		<td>아이디 만든날짜</td>
		<td>예약내역 보기</td>
		<td>삭제</td>
	</tr>
	<c:forEach items="${mlist}" var="mdto" varStatus="sts">
	<tr>
		<td>${mdto.memberid}</td>
		<td>${mdto.name}</td>
		<td>${mdto.userid}</td>
		<td>${mdto.email}</td>
		<td>${mdto.phone}</td>
		<td>${mdto.created_day}</td>
		<td><a>예약내역 보기</a></td>
		<td><a>삭제하기</a></td>
	</tr>
	</c:forEach>
</table>
</section>
</body>
</html>