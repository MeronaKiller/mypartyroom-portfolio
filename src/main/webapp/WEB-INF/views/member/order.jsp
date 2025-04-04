<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function handleCancelRequest(reservationId, currentStatus) {
  // 현재 상태를 기반으로 링크 텍스트와 확인 메시지 설정
  var isCancel = currentStatus == 0;
  var confirmMessage = isCancel ? 
    "정말로 취소 및 환불을 신청하시겠습니까?" : 
    "취소 및 환불 신청을 철회하시겠습니까?";
  
  if (confirm(confirmMessage)) {
    // 폼 필드 설정
    document.getElementById("reservationIdInput").value = reservationId;
    document.getElementById("statusInput").value = isCancel ? "1" : "0";
    
    // 폼 제출
    document.getElementById("cancelForm").submit();
  }
}
</script>
<style>
	#odTitle
	{
	   text-align: center;
	   font-size: 32px;
	   padding-top: 75px;
	   padding-bottom: 30px;
	}
	.odContent
	{
	   text-align: center;
	   border: 1px solid #ddd;
	   border-radius: 5px;
	   margin-bottom: 50px;
	}
	.odContent #odwhattime
	{
		text-align: left;
		display: block;
		font-size: 20px;
		border-bottom: 1px solid #ddd;
		background-color: #5A7D9A;
		text-decoration: none;
		color: white;
		width: 100%;
		height:70px;
		margin: 0 auto;
		line-height: 70px;
		margin-bottom: 10px;
		box-sizing: border-box;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
	}
	.odContent #odwhattime span
	{
		margin-left: 20px;
	}
	.odContent table
	{
		width: 100%;
		border-collapse: collapse;
	}
	.odContent #odtd1
	{
		width: 70%;
		border-radius: 5px;
		text-align: left;
		padding-left: 70px;
	}
	.odContent #odroomname a
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
	#reservComplete
	{
		display: inline-block;
		width: 100px;
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
	.odContent #odtd1 img
	{
 		width: 90%;
 		height: 250px;
 		object-fit: cover;
 		border-radius: 5px;
	}
	.odContent #odtd2
	{
		width: 30%
		border-radius: 5px;
	}
	.odContent #odtd2 .odbtn a
	{
		display: block;
		font-size: 20px;
		border: 1px solid #ddd;
		background-color: #5A7D9A;
		color: white;
		text-decoration: none;
		width: 90%;
		height:45px;
		margin: 0, auto;
		line-height:45px;
		margin-bottom: 5px;
		border-radius: 5px;
	}
	.odContent #odtd2 #odbtnReview a
	{
		display: block;
		font-size: 20px;
		border: 1px solid #ddd;
		background-color: #28A745;
		text-decoration: none;
		color: white;
		width: 90%;
		height:45px;
		margin: 0, auto;
		line-height: 45px;
		margin-bottom: 5px;
		border-radius: 5px;
	}
	#reservback
	{
		display: block;
		background-color: #FAFAFA;
		width: 90%;
		height: 40px;
		line-height: 40px;
		border-radius: 5px;
		margin-bottom: 10px;
	}
</style>
</head>
<body>
<h1 id="odTitle">예약내역</h1>

<hr style="background-color: #5A7D9A; height: 2px; width: 1100px; border: none; margin-bottom: 50px;">

<form id="cancelForm" action="../member/cancelReserv" method="post" style="display: none;">
  <input type="hidden" name="reservationid" id="reservationIdInput" value="">
  <input type="hidden" name="status" id="statusInput" value="">
  <input type="hidden" name="modified_at" id="modified_at" value="">
</form>

<c:forEach items="${mapAll}" var="map" varStatus="sts">
<section class="odContent">
  <div id="odwhattime">
    <span>📆<fmt:parseDate value="${map.writeday}" var="writeday" pattern="yyyy-MM-dd HH:mm:ss.S" />
    <fmt:formatDate value="${writeday}" pattern="yyyy.MM.dd HH시 mm분" /> 예약</span>
  </div>
  
  <table>
    <tr>
      <td id="odtd1">
        <fmt:parseDate value="${map.startTime}" var="startTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
        <fmt:parseDate value="${map.endTime}" var="endTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
        <span id="reservback"><span id="reservComplete">예약완료</span><span style="font-size: 15px;"><fmt:formatDate value="${startTime}" pattern="yyyy.MM.dd HH시 mm분" /> ~
        <fmt:formatDate value="${endTime}" pattern="yyyy.MM.dd HH시 mm분" /></span></span>
        <div><a href="../room/roomContent?rcode=${map.rcode}"><img src="../static/room/${map.pic}"></a></div>
        <div id="odroomname"><a href="../room/roomContent?rcode=${map.rcode}">${map.name}</a></div>
      </td>
      <td id="odtd2">
        <div class="odbtn"><a href="../room/reservChk?reservationid=${map.reservationid}">예약 상세보기</a></div>
        <div class="odbtn">
          <!-- 함수명을 handleCancelRequest로 변경 (confirmCancel → handleCancelRequest) -->
          <a href="#" onclick="handleCancelRequest(${map.reservationid}, ${map.status}); return false;">
            <c:choose>
              <c:when test="${map.status == 0}">취소 및 환불 신청</c:when>
              <c:when test="${map.status == 1}">취소 및 환불 신청 취소</c:when>
              <c:otherwise>취소 및 환불 신청</c:otherwise>
            </c:choose>
          </a>
        </div>
        <div id="odbtnReview"><a href="">리뷰 작성하기</a></div>
      </td>
    </tr>
  </table>
</section>
</c:forEach>

</body>
</html>