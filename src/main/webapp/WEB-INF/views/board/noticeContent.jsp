<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
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
    }
    
    .ntc-btn:hover {
        background-color: #555;
    }
</style>
</head>
<body>
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
            <a href="/board/noticeList" class="ntc-btn">목록</a>
        </div>
    </div>
</body>
</html>