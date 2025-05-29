<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 도구</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }
    .admin-panel {
        width: 100%;
        max-width: 600px;
        margin: 40px auto;
        background-color: white;
        padding: 30px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .admin-title {
        font-size: 28px;
        margin-bottom: 15px;
        text-align: center;
        color: #333;
    }
    .admin-user {
        font-size: 14px;
        color: #666;
        margin-bottom: 30px;
        text-align: center;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }
    .admin-menu {
        list-style: none;
        padding: 0;
    }
    .admin-menu a {
        display: block;
        padding: 15px;
        margin-bottom: 12px;
        background-color: #f2f2f2;
        color: #333;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
        text-align: center;
        font-weight: bold;
    }
    .admin-menu a:hover {
        background-color: #e0e0e0;
    }
    .admin-menu a:last-child {
        margin-top: 25px;
        background-color: #ff9999;
        color: white;
    }
    .admin-menu a:last-child:hover {
        background-color: #ff7777;
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
<div class="admin-panel">
    <div class="admin-title">관리자 도구</div>
    <div class="admin-user">사용중인 관리자: ${admin_userid}</div>
    
    <div class="admin-menu">
        <a href="/admin/memberManage">회원 관리</a>
        <a href="/admin/conformCancle">취소 및 환불 승인 관리</a>
        <a href="/admin/roomManage">파티룸 관리</a>
        <a href="/admin/noticeManage">공지사항 관리</a>
        <a href="/admin/qnaAnswer">1:1 답변</a>
        <a href="/admin/adminLogout">로그아웃</a>
    </div>
</div>
</c:if>
</body>
</html>