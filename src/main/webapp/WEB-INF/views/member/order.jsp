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
</head>
<body>
<div>예약내역</div>

<form id="cancelForm" action="../member/cancelReserv" method="post" style="display: none;">
  <input type="hidden" name="reservationid" id="reservationIdInput" value="">
  <input type="hidden" name="status" id="statusInput" value="">
  <input type="hidden" name="modified_at" id="modified_at" value="">
</form>

<c:forEach items="${mapAll}" var="map" varStatus="sts">
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
        <div>
          <!-- 함수명을 handleCancelRequest로 변경 (confirmCancel → handleCancelRequest) -->
          <a href="#" onclick="handleCancelRequest(${map.reservationid}, ${map.status}); return false;">
            <c:choose>
              <c:when test="${map.status == 0}">취소 및 환불 신청</c:when>
              <c:when test="${map.status == 1}">취소 및 환불 신청 취소</c:when>
              <c:otherwise>취소 및 환불 신청</c:otherwise>
            </c:choose>
          </a>
        </div>
        <div>리뷰 작성하기</div>
      </td>
    </tr>
  </table>
  <hr>
</c:forEach>

</body>
</html>