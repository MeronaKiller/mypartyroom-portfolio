<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항(관리자모드)</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 20px;
    }
    table {
        border-collapse: collapse;
        text-align: center;
        width: 90%;
        max-width: 900px;
        margin: 0 auto;
        background-color: white;
    }
    
    table tr td, table tr th {
        border-left: none;
        border-right: none;
        border-top: 1px solid #ddd;
        border-bottom: 1px solid #ddd;
        padding: 12px 15px;
    }
    
    table tr:hover {
        background-color: #f5f5f5;
    }
    
    .notice-title {
        text-align: left;
        padding-left: 20px;
    }
    
    .notice-title a {
        text-decoration: none;
        color: #333;
    }
    
    .notice-title a:hover {
        text-decoration: underline;
        color: #5A7D9A;
    }
    
    h1 {
        text-align: center;
        font-size: 28px;
        padding-bottom: 25px;
        color: #5A7D9A;
        margin-top: 20px;
    }
    
    .table-header {
        background-color: #F8F9FA;
        font-weight: bold;
        font-size: 16px;
        height: 50px;
    }
    
    #nl-body {
        background-color: #F8F9FA;
    }
    
    .pagination {
        padding: 15px 0;
        text-align: center;
    }
    
    .pagination a {
        display: inline-block;
        padding: 5px 10px;
        margin: 0 2px;
        color: #666;
        text-decoration: none;
    }
    
    .pagination a:hover, .pagination a.active {
        color: #5A7D9A;
        font-weight: bold;
    }
    
    .pagination .current-page {
        color: #ff4081;
        font-weight: bold;
    }
    
    /* 버튼 컨테이너 스타일 */
    .buttons-container {
        width: 90%;
        max-width: 900px;
        margin: 0 auto 15px;
        display: flex;
        justify-content: space-between;
    }
    
    .admin-link {
        display: inline-block;
        padding: 8px 16px;
        background-color: #3A3A3A;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 14px;
    }
    
    .admin-link:hover {
        background-color: #555;
    }
    
    /* 삭제됨 및 삭제 버튼 스타일 */
    .deleted-status {
        color: #ff4040;
        font-weight: bold;
    }
    
    .delete-btn {
        display: inline-block;
        padding: 4px 8px;
        background-color: #ff4040;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-size: 12px;
    }
    
    .delete-btn:hover {
        background-color: #cc3333;
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
<body id="nl-body">
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
<h1>공지사항(관리자모드)</h1>

<!-- 버튼 컨테이너 추가 -->
<div class="buttons-container">
    <a href="../admin/adminTools" class="admin-link">돌아가기</a>
    <a href="../admin/noticeWrite" class="admin-link">글쓰기</a>
</div>

<table>
    <tr class="table-header">
        <td width="8%">번호</td>
        <td width="50%">제목</td>
        <td width="12%">작성자</td>
        <td width="20%">작성일</td>
        <td width="10%">삭제여부</td>
    </tr>
    
    <c:forEach var="notice" items="${nlist}">
        <tr>
            <td>${notice.noticeid}</td>
            <td class="notice-title">
                <a href="/admin/noticeContentManage?noticeList=${notice.noticeid}">
                    ${notice.title}
                </a>
            </td>
            <td>${notice.admin_name}</td>
            <td>${notice.writeday}</td>
            <td>
            
            <c:if test="${notice.state==1}">
              <span class="deleted-status">삭제됨</span>
            </c:if>
            <c:if test="${notice.state==0}">
              <span><a href="/admin/noticeContentDeleteOk?noticeid=${notice.noticeid}" class="delete-btn">삭제</a></span>
            </c:if>
            
            </td>
        </tr>
    </c:forEach>
    
    <!-- 페이지 출력 -->
    <tr>
        <td colspan="5">
            <div class="pagination">
                <!-- 이전 그룹 -->
                <c:if test="${pstart != 1}">
                    <a href="noticeManage?page=${pstart-1}">◁◁</a>
                </c:if>
                <c:if test="${pstart == 1}">
                    <span class="disabled">◁◁</span>
                </c:if>
                
                <!-- 이전 페이지 -->
                <c:if test="${page != 1}">
                    <a href="noticeManage?page=${page-1}">◁</a>
                </c:if>
                <c:if test="${page == 1}">
                    <span class="disabled">◁</span>
                </c:if>
                
                <!-- 페이지 번호 -->
                <c:forEach var="i" begin="${pstart}" end="${pend}">
                    <c:if test="${page == i}">
                        <a href="noticeManage?page=${i}" class="current-page">${i}</a>
                    </c:if>
                    <c:if test="${page != i}">
                        <a href="noticeManage?page=${i}">${i}</a>
                    </c:if>
                </c:forEach>
                
                <!-- 다음 페이지 -->
                <c:if test="${page != noticeGetChong}">
                    <a href="noticeManage?page=${page+1}">▷</a>
                </c:if>
                <c:if test="${page == noticeGetChong}">
                    <span class="disabled">▷</span>
                </c:if>
                
                <!-- 다음 그룹 -->
                <c:if test="${pend != noticeGetChong}">
                    <a href="noticeManage?page=${pend+1}">▷▷</a>
                </c:if>
                <c:if test="${pend == noticeGetChong}">
                    <span class="disabled">▷▷</span>
                </c:if>
            </div>
        </td>
    </tr>
</table>
</c:if>
</body>
</html>