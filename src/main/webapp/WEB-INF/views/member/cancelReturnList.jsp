<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취소/환불 내역</title>
<style>
	#crlTitle
	{
	   text-align: center;
	   font-size: 35px;
	   padding-top: 75px;
	   padding-bottom: 30px;
	}
	.crlContent
	{
	   text-align: center;
	   border: 1px solid #ddd;
	   border-radius: 5px;
	   margin-bottom: 50px;
	}
	.crlContent #crlwhattime
	{
		text-align: left;
		display: block;
		font-size: 20px;
		border-bottom: 1px solid #ddd;
		background-color: #5A7D9A;  /* 원본과 동일한 색상 사용 */
		text-decoration: none;
		color: white;
		width: 100%;
		height: 70px;
		margin: 0 auto;
		line-height: 70px;
		margin-bottom: 10px;
		box-sizing: border-box;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
	}
	.crlContent #crlwhattime span
	{
		margin-left: 20px;
	}
	.crlContent table
	{
		width: 100%;
		border-collapse: collapse;
	}
	.crlContent #crltd1
	{
		width: 70%;
		border-radius: 5px;
		text-align: left;
		padding-left: 70px;
	}
	.crlContent #crlroomname a
	{
		display: block;
		height: 30px;
		line-height: 30px;
		margin: 0 auto;
		font-size: 20px;
		text-decoration: none;
		color: black;
		margin-top: 10px;
		margin-bottom: 10px;
	}
	#cancelComplete
	{
		display: inline-block;
		width: 130px;
		height: 30px;
		line-height: 30px;
		margin: 0 auto;
		font-size: 15px;
		border-radius: 5px;
		background-color: #5A7D9A;
		color: white;
		margin-bottom: 10px;
		margin-right: 10px;
		margin-left: 10px;
		text-align: center;
	}
	.crlContent #crltd1 img
	{
 		width: 90%;
 		height: 250px;
 		object-fit: cover;
 		border-radius: 5px;
	}
	.crlContent #crltd2
	{
		width: 30%;
		border-radius: 5px;
	}
	.crlContent #crltd2 .crlbtn a
	{
		display: block;
		font-size: 20px;
		border: 1px solid #ddd;
		background-color: #5A7D9A;
		color: white;
		text-decoration: none;
		width: 90%;
		height: 45px;
		margin: 0 auto;
		line-height: 45px;
		margin-bottom: 5px;
		border-radius: 5px;
	}
	#cancelback
	{
		display: block;
		background-color: #FAFAFA;
		width: 90%;
		height: 40px;
		line-height: 40px;
		border-radius: 5px;
		margin-bottom: 10px;
	}
	#refundStatus
	{
		display: block;
		width: 90%;
		height: 40px;
		line-height: 40px;
		border-radius: 5px;
		margin: 10px auto;
		background-color: #f8f9fa;
		border: 1px solid #ddd;
		font-size: 16px;
	}
	#refundStatus.completed
	{
		border-color: #28A745;
		color: #28A745;
	}
	#refundStatus.pending
	{
		border-color: #FFC107;
		color: #FFC107;
	}
</style>
</head>
<body>
<h1 id="crlTitle">취소/환불 내역</h1>


<c:forEach items="${mapAll}" var="map" varStatus="sts">
<section class="crlContent">
  <div id="crlwhattime">
    <span>📆<fmt:parseDate value="${map.writeday}" var="writeday" pattern="yyyy-MM-dd HH:mm:ss.S" />
    <fmt:formatDate value="${writeday}" pattern="yyyy.MM.dd HH시 mm분" /> 예약</span>
  </div>
  
  <table>
    <tr>
      <td id="crltd1">
        <fmt:parseDate value="${map.startTime}" var="startTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
        <fmt:parseDate value="${map.endTime}" var="endTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
        <span id="cancelback"><span id="cancelComplete">예약취소완료</span><span style="font-size: 15px;"><fmt:formatDate value="${startTime}" pattern="yyyy.MM.dd HH시 mm분" /> ~
        <fmt:formatDate value="${endTime}" pattern="yyyy.MM.dd HH시 mm분" /></span></span>
        <div><a href="../room/roomContent?rcode=${map.rcode}"><img src="../static/room/${map.pic}"></a></div>
        <div id="crlroomname"><a href="../room/roomContent?rcode=${map.rcode}">${map.name}</a></div>
        
      </td>
      <td id="crltd2">
        <div class="crlbtn"><a href="../room/reservChk?reservationid=${map.reservationid}">예약 상세보기</a></div>
      </td>
    </tr>
  </table>
</section>
</c:forEach>

</body>
</html>