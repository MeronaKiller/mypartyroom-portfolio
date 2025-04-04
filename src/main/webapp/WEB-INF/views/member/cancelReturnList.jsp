<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</style>
</head>
<body>
<h1 id="crlTitle">취소/환불 내역</h1>

<c:forEach items="${mapAll}" var="map" varStatus="sts">
<section class="crlContent">
  <div>
    <fmt:parseDate value="${map.writeday}" var="writeday" pattern="yyyy-MM-dd HH:mm:ss.S" />
    <fmt:formatDate value="${writeday}" pattern="yyyy.MM.dd HH시 mm분" /> 예약
  </div>
  
  <table>
    <tr>
      <td>
        <fmt:parseDate value="${map.startTime}" var="startTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
        <fmt:parseDate value="${map.endTime}" var="endTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
        예약 취소 완료<fmt:formatDate value="${startTime}" pattern="yyyy.MM.dd HH시 mm분" /> ~
        <fmt:formatDate value="${endTime}" pattern="yyyy.MM.dd HH시 mm분" />
        <div><a href="../room/roomContent?rcode=${map.rcode}"><img style="width: 350px; height: 250px;" src="../static/room/${map.pic}"></a></div>
        <div><a href="../room/roomContent?rcode=${map.rcode}">${map.name}</a></div>
      </td>
      <td>
        <div><a href="../room/reservChk?reservationid=${map.reservationid}">예약 상세보기</a></div>
      </td>
    </tr>
  </table>
  <hr>
 </section>
</c:forEach>
</body>
</html>