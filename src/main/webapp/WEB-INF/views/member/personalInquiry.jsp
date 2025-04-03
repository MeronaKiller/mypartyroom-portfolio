<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3> 1:1 문의하기 </h3>
	<section>
	<form method="post" action="personalInquiryOk">
		<select name="category">
			<option value="0">예약 문의</option>
			<option value="1">환불 문의</option>
			<option value="2">시설 문의</option>
			<option value="3">기타</option>
		</select>
		<div><input type= "text" name= "title" id= "title" placeholder= "제목을 입력하세요"></div>
		<textarea name="content" id="content" placeholder= "문의사항을 입력하세요"></textarea>
		<div><input type= "submit" value= "문의하기"></div>
	</form>	
	</section>
</body>
</html>