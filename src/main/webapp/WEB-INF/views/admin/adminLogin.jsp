<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    
    .login-container {
        width: 350px;
        background-color: white;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        padding: 30px;
        text-align: center;
    }
    
    h1 {
        margin-top: 0;
        margin-bottom: 25px;
        color: #333;
        font-size: 24px;
    }
    
    input[type="text"], 
    input[type="password"] {
        width: 100%;
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
    }
    
    input[type="submit"] {
        width: 100%;
        padding: 12px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 10px;
    }
    
    input[type="submit"]:hover {
        background-color: #45a049;
    }
    
    .error-message {
        color: red;
        font-size: 12px;
        text-align: left;
        margin-bottom: 15px;
    }
</style>
</head>
<body>
<div class="login-container">
    <h1>어드민 로그인</h1>
    <section>
        <form method="post" action="adminLoginOk">
            <div>
                <input type="text" name="admin_userid" id="txt" placeholder="어드민 아이디">
            </div>
            <div>
                <input type="password" name="pwd" id="txt" placeholder="비밀번호">
                <c:if test="${err==1}">
                    <div class="error-message">아이디 혹은 비밀번호가 틀립니다.</div>
                </c:if>
            </div>
            <div>
                <input type="submit" value="로그인" id="submit">
            </div>
        </form>
    </section>
</div>
</body>
</html>