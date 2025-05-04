<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h1
	{
	   text-align: center;
	   font-size: 32px;
	   padding-top: 75px;
	   padding-bottom: 30px;
	}
	#picategory
	{
		width: 406px;
		height: 30px;
		margin: 5px;
	}
	#pititle
	{
		width: 398px;
		height: 30px;
		margin: 5px;
	}
	#picontent
	{
		width: 400px;
		height:300px;
		margin: 5px;
		resize: none;
	}
	input[type="submit"]
	{
		width: 406px;
		height: 30px;
		cursor: pointer;
		margin: 5px;
		margin-bottom: 30px;
	}
</style>
</head>
<body>
	<section>
	<h1> 1:1 문의하기 </h1>
	<form method="post" action="personalInquiryOk">
		<select name="category" id="picategory">
			<option value="0">예약 문의</option>
			<option value="1">환불 문의</option>
			<option value="2">시설 문의</option>
			<option value="3">기타</option>
		</select>
		<div><input id="pititle" type= "text" name= "title" id= "title" placeholder= "제목을 입력하세요"></div>
		<div><input id="pititle" type= "text" name= "title" id= "email" placeholder= "회신받으실 이메일을 입력하세요"></div>
		<textarea id="picontent" name="content" id="content" placeholder= "문의사항을 입력하세요"></textarea>
		<div><input type= "submit" value= "문의하기"></div>
	</form>	
	</section>
</body>
</html>