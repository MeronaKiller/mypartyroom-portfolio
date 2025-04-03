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
<style>
 .fnaContent
 {
 	display: none;
 	border: 1px solid black;
 }
 .fnaOpen
 {
 	cursor: pointer;
 	border: 1px solid black;
 }
</style>
<script>
	function fnaOpen(fnaid)
	{
		var content=document.getElementById("content-"+fnaid);
		var arrow=document.getElementById("arrow-"+fnaid);
		
		if(content.style.display==="block")
		{
			content.style.display="none";
			arrow.innerHTML="﹀";
		}
		else
		{
			content.style.display="block";
			arrow.innerHTML="︿";
		}
	}
</script>
<c:forEach var="fdto" items="${flist}">
<li style="list-style-type: none;">
	<div class="fnaOpen" onclick="fnaOpen(${fdto.fnaid})">
	<span>Q</span>
	<span>${fdto.title}</span>
	<span id="arrow-${fdto.fnaid}">﹀</span>
	</div>
	<div id="content-${fdto.fnaid}" class="fnaContent">
	 <tr>
	 <td>A</td>
	 <td>${fdto.content}</td>
	 </tr>
	</div>
</li>
</c:forEach>
</body>
</html>