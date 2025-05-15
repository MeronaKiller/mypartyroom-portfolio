<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
	h1 /* 제목 */
	{
	   text-align: center;
	   font-size: 32px;
	   padding-top: 75px;
	   padding-bottom: 30px;
	}
	section #signupNotice /* 아직 마이파티룸 회원이 아니신가요? */
	{
		padding-top: 15px;
	}
	body
	{
		margin: 0;
		padding-top: 130px;
		background-color: #F6F6F6;
	}
	section
	{
		width: 650px;
		height: 1000px;
		flex-grow: 1;
		margin: auto;
		text-align: center;
		background-color: white;
		padding-top: 30px;
		padding-bottom: 30px;
	}
	section div
	{
		margin-top: 15px;
	}
	section #txt
	{
		width:580px;
		height:50px;
	}
	section #submit
	{
		width:580px;
		height:50px;
	}
	
</style>
</head>
<body> <!-- login.jsp -->
<h1> 로그인 </h1>
<section>
	<form method="post" action="loginOk"> <!-- 로그인 폼 --><!-- value값은 임시임 -->
		
		<div><input type= "text" name= "userid" id= "txt" placeholder= "아이디" value="hong123"></div>
		<div>
		<input type= "password" name= "pwd" id= "txt" placeholder= "비밀번호" value="123456">
		<c:if test="${err==1}">
			<br><span style="font-size:12px; color:red;"> 아이디 혹은 비밀번호가 틀립니다. </span>
		</c:if>
		</div>
		<div><input type= "submit" value= "로그인" id="submit"></div>
		<div id="signupNotice">아직 마이파티룸 회원이 아니신가요? <a href="/member/member">회원가입</a></div>

	</form>	
</section>
</body>
</html>