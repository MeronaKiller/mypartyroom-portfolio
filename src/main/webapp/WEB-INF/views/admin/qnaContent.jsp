<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세 보기</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
    }
    .qna-container {
        width: 90%;
        max-width: 800px;
        margin: 20px auto;
        background-color: white;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    
    .qna-header {
        padding: 15px 20px;
        border-bottom: 1px solid #ddd;
    }
    
    .qna-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    
    .qna-info {
        font-size: 14px;
        color: #666;
        display: flex;
        justify-content: space-between;
        margin-bottom: 5px;
    }
    
    .qna-category {
        display: inline-block;
        padding: 3px 8px;
        border-radius: 3px;
        font-size: 12px;
        background-color: #e0e0e0;
        margin-right: 10px;
    }
    
    .qna-content-area {
        padding: 30px 20px;
        min-height: 200px;
        line-height: 1.6;
        border-bottom: 1px solid #ddd;
    }
    
    .qna-answer-area {
        padding: 20px;
        background-color: #f9f9f9;
        border-bottom: 1px solid #ddd;
    }
    
    .qna-answer-title {
        font-weight: bold;
        margin-bottom: 10px;
    }
    
    .qna-answer-form {
        padding: 20px;
    }
    
    .qna-answer-form textarea {
        width: 100%;
        min-height: 150px;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 4px;
        resize: vertical;
    }
    
    .qna-footer {
        padding: 15px;
        text-align: center;
    }
    
    .qna-btn {
        display: inline-block;
        padding: 8px 16px;
        background-color: #3A3A3A;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 14px;
        margin: 0 5px;
        border: none;
        cursor: pointer;
    }
    
    .qna-btn:hover {
        background-color: #555;
    }
    
    .complete-btn {
        background-color: #4CAF50;
    }
    
    .complete-btn:hover {
        background-color: #3e8e41;
    }
    
    .pending-status {
        color: #ff4040;
        font-weight: bold;
    }
    
    .completed-status {
        color: #4CAF50;
        font-weight: bold;
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
    <div class="qna-container">
        <div class="qna-header">
            <div class="qna-title">${qdto.title}</div>
            <div class="qna-info">
                <span>
                    <c:choose>
                        <c:when test="${qdto.category == 0}">
                            <span class="qna-category">예약 문의</span>
                        </c:when>
                        <c:when test="${qdto.category == 1}">
                            <span class="qna-category">환불 문의</span>
                        </c:when>
                        <c:when test="${qdto.category == 2}">
                            <span class="qna-category">시설 문의</span>
                        </c:when>
                        <c:when test="${qdto.category == 3}">
                            <span class="qna-category">기타</span>
                        </c:when>
                    </c:choose>
                    작성자: ${qdto.userid}
                </span>
                <span>작성일: ${qdto.writeday}</span>
            </div>
            <div class="qna-info">이메일: ${qdto.email}</div>
            <div class="qna-info">
                <span>
                    처리상태: 
                    <c:if test="${qdto.state == 0}">
                        <span class="pending-status">접수중</span>
                    </c:if>
                    <c:if test="${qdto.state == 1}">
                        <span class="completed-status">처리됨</span>
                        <span>(처리일: ${qdto.answerwriteday})</span>
                    </c:if>
                </span>
            </div>
        </div>
        
        <div class="qna-content-area">
            ${qdto.content}
        </div>
        
        
        <c:if test="${qdto.state == 0}">
            <form action="/admin/qnaAnswerOk" method="get" class="qna-answer-form">
                <input type="hidden" name="personalInquiryid" value="${qdto.personalInquiryid}">
                <div class="qna-footer">
                    <button type="submit" class="qna-btn complete-btn">답변 등록 및 처리 완료</button>
                    <a href="/admin/qnaAnswer" class="qna-btn">목록</a>
                </div>
            </form>
        </c:if>
        
        <c:if test="${qdto.state == 1}">
            <div class="qna-footer">
                <a href="/admin/qnaAnswer" class="qna-btn">목록</a>
            </div>
        </c:if>
    </div>
</c:if>
</body>
</html>w