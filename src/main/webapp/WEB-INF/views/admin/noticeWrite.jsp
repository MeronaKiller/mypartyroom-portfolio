<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
    }
    .write-container {
        width: 90%;
        max-width: 800px;
        margin: 20px auto;
        background-color: white;
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 20px;
    }
    
    .write-title {
        font-size: 24px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 30px;
        color: #5A7D9A;
    }
    
    .input-group {
        margin-bottom: 20px;
    }
    
    .input-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }
    
    .input-title {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    
    .input-admin-name {
        width: 50%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ddd;
        border-radius: 4px;
        background-color: #f8f8f8;
    }
    
    .input-content {
        width: 100%;
        height: 300px;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ddd;
        border-radius: 4px;
        resize: vertical;
    }
    
    .button-group {
        margin-top: 30px;
        text-align: center;
    }
    
    .submit-btn {
        padding: 10px 20px;
        background-color: #3A3A3A;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        margin-right: 10px;
    }
    
    .cancel-btn {
        padding: 10px 20px;
        background-color: #888;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
    }
    
    .submit-btn:hover {
        background-color: #555;
    }
    
    .cancel-btn:hover {
        background-color: #999;
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
    <div class="write-container">
        <h1 class="write-title">공지사항 작성</h1>
        
        <form method="post" action="/admin/noticeWriteOk">
            <div class="input-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" class="input-title" required placeholder="제목을 입력하세요">
            </div>
            
            <div class="input-group">
                <label for="admin_name">작성자</label>
                <input type="text" id="admin_name" name="admin_name" value="관리자" class="input-admin-name" readonly>
            </div>
            <div class="input-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" class="input-content" required placeholder="내용을 입력하세요"></textarea>
            </div>
            <div class="input-group">
                <input type="hidden" id="adminid" name="adminid" class="adminid" value="1">
            </div>
            <div class="button-group">
                <button type="submit" class="submit-btn">등록하기</button>
                <a href="/admin/noticeManage" class="cancel-btn">취소하기</a>
            </div>
        </form>
    </div>
</c:if>
</body>
</html>