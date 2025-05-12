<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	#deleteUser
	{
		color: red;
	}
	#reviveUser
	{
		color: green;
	}
</style>
<body>
<section>
<a href="../admin/adminTools">돌아가기</a>
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
	<c:choose>
	    <c:when test="${mdto.status == 0}">  <!-- 활성 계정 -->
	        <td><a id="deleteUser" href="/admin/deleteUser?memberid=${mdto.memberid}">계정 삭제하기</a></td>
	    </c:when>
	    <c:when test="${mdto.status == 1}">  <!-- 삭제된 계정 -->
	        <td><a id="reviveUser" href="/admin/reviveUser?memberid=${mdto.memberid}">계정 복구하기</a></td>
	    </c:when>
	    <c:otherwise>
	        <td>상태 알 수 없음(mdto.status의 값을 확인하세요)</td>
	    </c:otherwise>
	</c:choose>
	</tr>
	</c:forEach>
</table>
</section>
</body>
</html>