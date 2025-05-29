<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
    }
    .ntc-container {
        width: 90%;
        max-width: 800px;
        margin: 20px auto;
        background-color: white;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    
    .ntc-header {
        padding: 15px 20px;
        border-bottom: 1px solid #ddd;
    }
    
    .ntc-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    
    .ntc-info {
        font-size: 14px;
        color: #666;
        display: flex;
        justify-content: space-between;
    }
    
    .ntc-content-area {
        padding: 30px 20px;
        min-height: 200px;
        line-height: 1.6;
        border-bottom: 1px solid #ddd;
    }
    
    .ntc-footer {
        padding: 15px;
        text-align: center;
    }
    
    .ntc-btn {
        display: inline-block;
        padding: 8px 16px;
        background-color: #3A3A3A;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 14px;
        margin: 0 5px;
    }
    
    .ntc-btn:hover {
        background-color: #555;
    }
    
    .delete-btn {
        background-color: #FF5252;
        display: inline-block;
        padding: 8px 16px;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 14px;
        margin: 0 5px;
    }
    .revive-btn {
        background-color: green;
        display: inline-block;
        padding: 8px 16px;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 14px;
        margin: 0 5px;
    }
    
    .delete-btn:hover {
        background-color: #FF7676;
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
    <div class="ntc-container">
        <div class="ntc-header">
            <div class="ntc-title">${notice.title}</div>
            <div class="ntc-info">
                <span>작성자: ${notice.admin_name}</span>
                <span>작성일: ${notice.writeday}</span>
            </div>
        </div>
        
        <div class="ntc-content-area">
            ${notice.content}
        </div>
        
        <div class="ntc-footer">
            <span><a href="/admin/noticeManage" class="ntc-btn">목록</a></span>
            <c:if test="${notice.state==1}">
                <span><a href="/admin/noticeContentDeleteOk?noticeid=${notice.noticeid}" class="delete-btn">삭제</a></span>
            </c:if>
            <c:if test="${notice.state==0}">
                <span><a href="/admin/roomContentReviveOk?noticeid=${notice.noticeid}" class="revive-btn">복구</a></span>
            </c:if>
        </div>
    </div>
</c:if>
</body>
</html>