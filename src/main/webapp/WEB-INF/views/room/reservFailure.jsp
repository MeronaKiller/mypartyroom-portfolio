<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 실패</title>
    <style>
        body {
            font-family: 'LINESeedKR-Light', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }
        
        .failure-container {
            max-width: 600px;
            margin: 50px auto;
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-top: 130px;
        }
        
        .failure-title {
            color: #e74c3c;
            font-size: 28px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        
        .failure-message {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .failure-btn {
            display: inline-block;
            background-color: #3A3A3A;
            color: white;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 5px;
            font-size: 16px;
            transition: all 0.3s;
            margin: 0 10px;
        }
        
        .failure-btn:hover {
            background-color: #555;
            transform: translateY(-2px);
        }
        
        .failure-btn.secondary {
            background-color: #ddd;
            color: #333;
        }
        
        .failure-btn.secondary:hover {
            background-color: #bbb;
        }
    </style>
</head>
<body>
    <div class="failure-container">
        <div class="failure-title">예약 실패</div>
        <div class="failure-message">
            죄송합니다. 해당 시간대에 이미 예약이 있거나<br>
            예약 처리 중 오류가 발생했습니다.<br><br>
            다른 시간대를 선택하시거나 잠시 후 다시 시도해주세요.
        </div>
        <a href="/room/roomList" class="failure-btn">방 목록으로 돌아가기</a>
        <a href="javascript:history.back()" class="failure-btn secondary">이전 페이지</a>
    </div>
</body>
</html>