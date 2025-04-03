<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${mapAll}" var="map" varStatus="sts">
<hr>
  <div>
    <fmt:parseDate value="${map.writeday}" var="writeday" pattern="yyyy-MM-dd HH:mm:ss.S" />
    <fmt:formatDate value="${writeday}" pattern="yyyy.MM.dd HH시 mm분" /> 예약
  </div>
  
  <table>
    <tr>
      <td>
        <fmt:parseDate value="${map.startTime}" var="startTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
        <fmt:parseDate value="${map.endTime}" var="endTime" pattern="yyyy-MM-dd HH:mm:ss.S" />
        예약완료<fmt:formatDate value="${startTime}" pattern="yyyy.MM.dd HH시 mm분" /> ~
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
</c:forEach>
</body>
</html>