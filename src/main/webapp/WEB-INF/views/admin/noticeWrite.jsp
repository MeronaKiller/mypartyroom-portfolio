<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<style>
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
</style>
</head>
<body>
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
                <input type="hidden" id="adminid" name="adminid" class="adminid" value="1"></input>
            </div>
            <div class="button-group">
                <button type="submit" class="submit-btn">등록하기</button>
                <a href="/admin/noticeManage" class="cancel-btn">취소하기</a>
            </div>
        </form>
    </div>
</body>
</html>