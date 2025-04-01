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
<body>
<h3>취소 및 환불 승인 관리</h3><a href="../admin/adminTools">돌아가기</a>
<c:forEach items="${rslist}" var="rslist" varStatus="sts">
  <div>
    <fmt:parseDate value="${rslist.writeday}" var="writeday" pattern="yyyy-MM-dd HH:mm:ss" />
    <fmt:formatDate value="${writeday}" pattern="yyyy.MM.dd HH시 mm분" /> 예약
  </div>
  
  <table>
    <tr>
      
      <td>
       <div>예약자 이름:${rslist.mname}</div>
       <div>예약자 아이디:${rslist.userid}</div>
       <div>예약자 이메일:${rslist.email}</div>
       <div>예약자 전화번호:${rslist.phone}</div>
       <div>취소 및 환불 신청 날짜:${rslist.modified_at}</div>
      </td>
      
      <td>
        <fmt:parseDate value="${rslist.startTime}" var="startTime" pattern="yyyy-MM-dd HH:mm:ss" />
        <fmt:parseDate value="${rslist.endTime}" var="endTime" pattern="yyyy-MM-dd HH:mm:ss" />
        예약완료<fmt:formatDate value="${startTime}" pattern="yyyy.MM.dd HH시 mm분" /> ~
        <fmt:formatDate value="${endTime}" pattern="yyyy.MM.dd HH시 mm분" />
        <div><a href="../room/roomContent?rcode=${rslist.rcode}"><img style="width: 200px; height: 150px;" src="../static/room/${rslist.pic}"></a></div>
        <div><a href="../room/roomContent?rcode=${rslist.rcode}">${rslist.name}</a></div>
      </td>
      
      <td>
        <div>
          <!-- 함수명을 handleCancelRequest로 변경 (confirmCancel → handleCancelRequest) -->
          	<div>취소 및 환불</div>
            <span><a href="/admin/conformCancleOk?reservationId=${rslist.reservationid}">허용</a></span>
            
            <span><a href="/admin/conformCancleNo?reservationId=${rslist.reservationid}">거절</a></span>
          
        </div>
      </td>
    </tr>
  </table>
 <hr>
</c:forEach>
</body>
</html>