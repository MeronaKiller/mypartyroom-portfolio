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
<h1> 어드민 로그인 </h1>
<section>
	<form method="post" action="adminLoginOk"> <!-- 로그인 폼 --><!-- value값은 임시임 -->
		
		<div><input type="text" name="admin_userid" id="txt" placeholder="어드민 아이디" value="pkc"></div>
		<div>
		<input type="password" name="pwd" id="txt" placeholder="비밀번호" value="1234">
		<c:if test="${err==1}">
			<br><span style="font-size:12px; color:red;"> 아이디 혹은 비밀번호가 틀립니다. </span>
		</c:if>
		</div>
		<div><input type="submit" value="로그인" id="submit"></div>
	</form>	
</section>
</body>
</html>