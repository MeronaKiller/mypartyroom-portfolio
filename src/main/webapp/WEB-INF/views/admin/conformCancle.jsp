<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>취소 및 환불 승인 관리</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 900px;
        margin: 30px auto;
        background-color: white;
        padding: 25px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }
    h3 {
        margin: 0;
        color: #333;
        font-size: 22px;
    }
    .back-link {
        display: inline-block;
        padding: 8px 15px;
        background-color: #f2f2f2;
        color: #333;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
    }
    .back-link:hover {
        background-color: #e0e0e0;
    }
    .reservation-card {
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
        margin-bottom: 20px;
        overflow: hidden;
    }
    .reservation-date {
        background-color: #f8f8f8;
        padding: 10px 15px;
        border-bottom: 1px solid #eee;
        font-weight: bold;
    }
    .reservation-content {
        display: flex;
        padding: 15px;
    }
    .user-info {
        flex: 1;
        padding-right: 15px;
    }
    .user-info div {
        margin-bottom: 8px;
        color: #555;
    }
    .room-info {
        flex: 1;
        border-left: 1px solid #eee;
        border-right: 1px solid #eee;
        padding: 0 15px;
    }
    .time-info {
        margin-bottom: 10px;
        font-weight: bold;
    }
    .room-image {
        text-align: center;
        margin-bottom: 10px;
    }
    .room-image img {
        width: 100%;
        max-width: 200px;
        height: 150px;
        object-fit: cover;
        border-radius: 4px;
        border: 1px solid #eee;
    }
    .room-name {
        text-align: center;
    }
    .room-name a {
        color: #0066cc;
        text-decoration: none;
        font-weight: bold;
    }
    .room-name a:hover {
        text-decoration: underline;
    }
    .action-buttons {
        flex: 0.6;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding-left: 15px;
    }
    .action-title {
        margin-bottom: 15px;
        font-weight: bold;
        color: #333;
    }
    .btn-container {
        display: flex;
        gap: 10px;
    }
    .btn {
        display: inline-block;
        padding: 8px 15px;
        text-decoration: none;
        border-radius: 4px;
        font-weight: bold;
        text-align: center;
    }
    .btn-approve {
        background-color: #4CAF50;
        color: white;
    }
    .btn-deny {
        background-color: #f44336;
        color: white;
    }
    .btn:hover {
        opacity: 0.9;
    }
    .error-message {
        color: red;
        font-weight: bold;
        text-align: center;
        padding: 20px;
        background-color: #ffe6e6;
        border: 1px solid #ff9999;
        border-radius: 5px;
        margin: 50px auto;
        max-width: 500px;
    }
</style>
<script>
    function handleCancelRequest(reservationId, currentStatus) {
      var isCancel = currentStatus == 0;
      var confirmMessage = isCancel ? 
        "정말로 취소 및 환불을 신청하시겠습니까?" : 
        "취소 및 환불 신청을 철회하시겠습니까?";
      
      if (confirm(confirmMessage)) {
        document.getElementById("reservationIdInput").value = reservationId;
        document.getElementById("statusInput").value = isCancel ? "1" : "0";
        document.getElementById("cancelForm").submit();
      }
    }
</script>
</head>
<body>
<!-- 관리자 확인 -->
<c:if test="${admin_userid ne 'pkc'}">
    <div class="error-message">
        잘못된 접근입니다. 관리자 로그인이 필요합니다.
        <script>
            setTimeout(function() {
                window.location.href = "/admin/adminLogin";
            }, 3000); // 3초 후 로그인 페이지로 이동
        </script>
    </div>
</c:if>
<c:if test="${admin_userid eq 'pkc'}">
<div class="container">
    <div class="header">
        <h3>취소 및 환불 승인 관리</h3>
        <a href="../admin/adminTools" class="back-link">돌아가기</a>
    </div>

    <c:forEach items="${rslist}" var="rslist" varStatus="sts">
      <div class="reservation-card">
        <div class="reservation-date">
          <fmt:parseDate value="${rslist.writeday}" var="writeday" pattern="yyyy-MM-dd HH:mm:ss" />
          <fmt:formatDate value="${writeday}" pattern="yyyy.MM.dd HH시 mm분" /> 예약
        </div>
        
        <div class="reservation-content">
          <div class="user-info">
            <div><strong>예약자 이름:</strong> ${rslist.mname}</div>
            <div><strong>예약자 아이디:</strong> ${rslist.userid}</div>
            <div><strong>예약자 이메일:</strong> ${rslist.email}</div>
            <div><strong>예약자 전화번호:</strong> ${rslist.phone}</div>
            <div><strong>취소 및 환불 신청 날짜:</strong> ${rslist.modified_at}</div>
          </div>
          
          <div class="room-info">
            <fmt:parseDate value="${rslist.startTime}" var="startTime" pattern="yyyy-MM-dd HH:mm:ss" />
            <fmt:parseDate value="${rslist.endTime}" var="endTime" pattern="yyyy-MM-dd HH:mm:ss" />
            <div class="time-info">
              예약시간: <fmt:formatDate value="${startTime}" pattern="yyyy.MM.dd HH시 mm분" /> ~
              <fmt:formatDate value="${endTime}" pattern="yyyy.MM.dd HH시 mm분" />
            </div>
            <div class="room-image">
              <a href="../room/roomContent?rcode=${rslist.rcode}">
                <img src="../static/room/${rslist.pic}" alt="${rslist.name}">
              </a>
            </div>
            <div class="room-name">
              <a href="../room/roomContent?rcode=${rslist.rcode}">${rslist.name}</a>
            </div>
          </div>
          
          <div class="action-buttons">
            <div class="action-title">취소 및 환불</div>
            <div class="btn-container">
              <a href="/admin/conformCancleOk?reservationId=${rslist.reservationid}" class="btn btn-approve">허용</a>
              <a href="/admin/conformCancleNo?reservationId=${rslist.reservationid}" class="btn btn-deny">거절</a>
            </div>
          </div>
        </div>
      </div>
    </c:forEach>
</div>
</c:if>
</body>
</html>