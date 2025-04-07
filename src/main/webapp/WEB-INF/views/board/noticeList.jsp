<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table
	{
		border-collapse:collapse;
		text-align: center;
	}
	table tr td, table tr th
	{
		border-left: none;
		border-right: none;
		border-top: 1px solid black;
		border-bottom: 1px solid black;
		border-radius: 5px;
	}
	table #noticeContent
	{
		padding-left: 30px;
	}
	h1
	{
		text-align: center;
		font-size: 30px;
		padding-bottom: 30px;
		color: #5A7D9A;
	}
	#nltop
	{
		font-size: 20px;
		background-color: #F8F9FA;
		font-weight: bold;
	}
	#nlbody
	{
		background-color: #F8F9FA;
	}
</style>
</head>
<body id=nlbody>

<h1>공지사항</h1>
<table border="1" align="center">


	<tr id="nltop" height="60px">
	<td width="80px">번호</td>
	<td width="500px">제목</td>
	<td width="80px">작성자</td>
	<td width="180px">작성일</td>
	</tr>
	
	
	<c:forEach var="notice" items="${nlist}">
		<tr height="40px">
		<td>${notice.noticeid}</td>
		<td align="left" id="noticeContent">
		<a href="/board/noticeContent?noticeList=${notice.noticeid}">
		${notice.title}
		</a>
		</td>
		<td>${notice.admin_name}</td>
		<td>${notice.writeday}</td>
		</tr>
	</c:forEach>
		
		<!-- 페이지 출력 -->
		<tr height="60">
			<td colspan="4" align="center">
			
			<!-- 이전 그룹 -->
			
			<c:if test="${pstart != 1}">
				<a href="noticeList?page=${pstart-1}"> ◁◁ </a>
			</c:if>
			<c:if test="${pstart == 1}">
			◁◁
			</c:if>
			
			<!-- 이전 페이지 -->
			<c:if test="${page != 1}">
				<a href="noticeList?page=${page-1}"> ◁ </a>
			</c:if>
			<c:if test="${page == 1}">
				◁
			</c:if>
			
			<c:forEach var="i" begin="${pstart}" end="${pend}">
				<c:if test="${page == i}"> <!-- 현재 페이지와 출력된 i의 값이 같을때 -->
					<a href="noticeList?page=${i}" style="color:red";> ${i} </a>
				</c:if>
			<c:if test="${page != i}">
			   		<a href="noticeList?page=${i}"> ${i} </a>
			</c:if>
			</c:forEach> 
			
	        <!-- 다음 페이지 -->
	         <c:if test="${page != noticeGetChong}">
	          <a href="noticeList?page=${page+1}"> ▷ </a>
	         </c:if>
	         <c:if test="${page == noticeGetChong}"> 
	          ▷
	         </c:if>
	         
	         <!-- 다음 그룹 -->
	         <c:if test="${pend != noticeGetChong}"> 
	          <a href="noticeList?page=${pend+1}"> ▷▷ </a>
	         </c:if>
	         <c:if test="${pend == noticeGetChong}">
	          ▷▷
	         </c:if>
			</td>
		</tr>
		
		
	
</table>
</body>
</html>































