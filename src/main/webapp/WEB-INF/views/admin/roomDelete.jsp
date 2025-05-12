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
	<a href="../admin/adminTools">돌아가기</a>
	<table>
		<tr>
			<td>룸아이디</td>
			<td>rcode</td>
			<td>이름</td>
			<td>시간당 가격</td>
			<td>등록일</td>
			<td>좋아요 수</td>
			<td>키워드</td>
			<td>삭제하기</td>
			<td>상태</td>
		</tr>
			<c:forEach items="${rlist}" var="rdto">
		<tr>
				<td>${rdto.roomid}</td>
				<td>${rdto.rcode}</td>
				<td>${rdto.name}</td>
				<td>${rdto.price}</td>
				<td>${rdto.writeday}</td>
				<td>${rdto.heart}</td>
				<td>${rdto.keyword}</td>
				<c:if test="${rdto.duration_type==2}">
				<td><a href="/admin/roomDeleteOk?roomid=${rdto.roomid}">삭제</a></td>
				</c:if>
				<c:if test="${rdto.duration_type==1}">
				<td><a href="/admin/roomReviveOk?roomid=${rdto.roomid}">복구</a></td>
				<td>삭제됨</td>
				</c:if>
		</tr>
			</c:forEach>
	</table>
</body>
</html>