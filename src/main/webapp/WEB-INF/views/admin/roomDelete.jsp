<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파티룸 삭제</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
        color: #333;
        line-height: 1.5;
    }
    .container {
        max-width: 1100px;
        margin: 20px auto;
        background-color: white;
        padding: 20px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #ddd;
    }
    .page-title {
        font-size: 20px;
        font-weight: bold;
        margin: 0;
    }
    .back-link {
        display: inline-block;
        padding: 6px 12px;
        background-color: #f0f0f0;
        color: #333;
        text-decoration: none;
        border-radius: 4px;
    }
    .back-link:hover {
        background-color: #e0e0e0;
    }
    
    /* 테이블 스타일 - 단순화 */
    .room-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        font-size: 14px;
    }
    .room-table th {
        background-color: #f0f0f0;
        color: #333;
        padding: 8px 6px;
        text-align: center;
        font-weight: bold;
        border-bottom: 2px solid #ddd;
    }
    .room-table td {
        padding: 8px 6px;
        text-align: center;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }
    .room-table tr:hover {
        background-color: #f9f9f9;
    }
    
    /* 삭제/복구 버튼 - 단순화 */
    .action-btn {
        display: inline-block;
        padding: 4px 8px;
        color: #fff;
        text-decoration: none;
        border-radius: 3px;
        font-size: 13px;
    }
    .delete-btn {
        background-color: #dc3545;
    }
    .delete-btn:hover {
        background-color: #c82333;
    }
    .restore-btn {
        background-color: #007bff;
    }
    .restore-btn:hover {
        background-color: #0069d9;
    }
    
    /* 상태 라벨 - 단순화 */
    .status-label {
        display: inline-block;
        color: #dc3545;
        font-weight: bold;
        font-size: 13px;
    }
    
    /* 반응형 테이블 */
    @media (max-width: 1000px) {
        .room-table {
            display: block;
            overflow-x: auto;
        }
    }
    
    /* 에러 메시지 */
    .error-message {
        color: #721c24;
        font-weight: bold;
        text-align: center;
        padding: 15px;
        background-color: #f8d7da;
        border: 1px solid #f5c6cb;
        border-radius: 4px;
        margin: 20px auto;
        max-width: 500px;
    }
    
    /* 데이터 없음 메시지 */
    .no-data {
        text-align: center;
        padding: 20px 0;
        color: #666;
    }
</style>
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
    <div class="page-header">
        <h1 class="page-title">파티룸 삭제</h1>
        <a href="../admin/adminTools" class="back-link">돌아가기</a>
    </div>
    
    <table class="room-table">
        <thead>
            <tr>
                <th>룸 ID</th>
                <th>코드</th>
                <th>이름</th>
                <th>시간당 가격</th>
                <th>등록일</th>
                <th>좋아요</th>
                <th>키워드</th>
                <th>관리</th>
                <th>상태</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty rlist}">
                <tr>
                    <td colspan="9" class="no-data">등록된 파티룸이 없습니다.</td>
                </tr>
            </c:if>
            <c:forEach items="${rlist}" var="rdto">
            <tr>
                <td>${rdto.roomid}</td>
                <td>${rdto.rcode}</td>
                <td>${rdto.name}</td>
                <td>${rdto.price}원</td>
                <td>${rdto.writeday}</td>
                <td>${rdto.heart}</td>
                <td>
                    <c:if test="${not empty rdto.keyword}">
                        ${rdto.keyword}
                    </c:if>
                </td>
                <c:if test="${rdto.duration_type==2}">
                <td><a href="/admin/roomDeleteOk?roomid=${rdto.roomid}" class="action-btn delete-btn">삭제</a></td>
                <td></td>
                </c:if>
                <c:if test="${rdto.duration_type==1}">
                <td><a href="/admin/roomReviveOk?roomid=${rdto.roomid}" class="action-btn restore-btn">복구</a></td>
                <td><span class="status-label">삭제됨</span></td>
                </c:if>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</c:if>
</body>
</html>