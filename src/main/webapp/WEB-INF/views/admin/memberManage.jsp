<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
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
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #ddd;
    }
    h3 {
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
    
    /* 테이블 스타일 - 심플화 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        font-size: 14px;
    }
    thead {
        background-color: #f0f0f0;
    }
    th {
        padding: 8px 6px;
        font-weight: bold;
        text-align: left;
        color: #333;
        border-bottom: 2px solid #ddd;
    }
    td {
        padding: 8px 6px;
        border-bottom: 1px solid #eee;
    }
    tr:hover {
        background-color: #f9f9f9;
    }
    
    /* 액션 버튼 - 심플화 */
    .action-link {
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
    
    /* 상태 표시 - 심플화 */
    .status-badge {
        display: inline-block;
        font-size: 13px;
        font-weight: bold;
    }
    .active {
        color: #28a745;
    }
    .inactive {
        color: #dc3545;
    }
    
    /* 데이터 없음 메시지 */
    .no-data {
        text-align: center;
        padding: 20px 0;
        color: #666;
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
    
    /* 반응형 테이블 */
    @media (max-width: 1000px) {
        table {
            display: block;
            overflow-x: auto;
        }
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
    <div class="header">
        <h3>회원 관리</h3>
        <a href="../admin/adminTools" class="back-link">돌아가기</a>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>아이디</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>가입일</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty mlist}">
                <tr>
                    <td colspan="8" class="no-data">등록된 회원이 없습니다.</td>
                </tr>
            </c:if>
            <c:forEach items="${mlist}" var="mdto" varStatus="sts">
                <tr>
                    <td>${mdto.memberid}</td>
                    <td>${mdto.name}</td>
                    <td>${mdto.userid}</td>
                    <td>${mdto.email}</td>
                    <td>${mdto.phone}</td>
                    <td>${mdto.created_day}</td>
                    <td>
                        <c:choose>
                            <c:when test="${mdto.status == 0}">
                                <span class="status-badge active">활성</span>
                            </c:when>
                            <c:when test="${mdto.status == 1}">
                                <span class="status-badge inactive">삭제됨</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge">알 수 없음</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${mdto.status == 0}">  <!-- 활성 계정 -->
                                <a href="/admin/deleteUser?memberid=${mdto.memberid}" class="action-link delete-btn">삭제</a>
                            </c:when>
                            <c:when test="${mdto.status == 1}">  <!-- 삭제된 계정 -->
                                <a href="/admin/reviveUser?memberid=${mdto.memberid}" class="action-link restore-btn">복구</a>
                            </c:when>
                            <c:otherwise>
                                <span>상태 오류</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</c:if>
</body>
</html>