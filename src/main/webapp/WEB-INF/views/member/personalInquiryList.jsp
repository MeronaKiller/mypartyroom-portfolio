<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html id="inquirySentPage">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 접수 완료</title>
    <style>
        /* 폰트 설정 */
        @font-face {
            font-family: 'LINESeedKR-Light';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Rg.woff2') format('woff2');
            font-weight: 300;
            font-style: normal;
        }
        
        @font-face {
            font-family: 'LINESeedKR-Bold';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }
        
        /* 기본 스타일 */
        #inquiryBody {
            font-family: 'LINESeedKR-Light', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-color: #f9f9f9;
            line-height: 1.6;
            margin-top: 130px;
        }
        
        /* 컨테이너 스타일 */
        #inquiryContainer {
            width: 80%;
            max-width: 600px;
            margin: 0 auto;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            background-color: white;
            text-align: center;
        }
        
        /* 아이콘 스타일 */
        #checkIcon {
            color: #4CAF50;
            font-size: 60px;
            margin-bottom: 20px;
        }
        
        /* 메시지 스타일 */
        #messageTitle {
            font-family: 'LINESeedKR-Bold', sans-serif;
            font-size: 24px;
            color: #5A7D9A;
            margin-bottom: 15px;
        }
        
        #messageBody {
            font-size: 16px;
            margin-bottom: 30px;
            line-height: 1.7;
        }
        
        /* 버튼 스타일 */
        #backButton {
            display: inline-block;
            background-color: #3A3A3A;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 5px;
            font-family: 'LINESeedKR-Bold', sans-serif;
            transition: all 0.3s;
        }
        
        #backButton:hover {
            background-color: #555;
            transform: translateY(-2px);
        }
    </style>
</head>
<body id="inquiryBody">
    <div id="inquiryContainer">
        <div id="checkIcon">✓</div>
        <div id="messageTitle">문의가 접수되었습니다</div>
        <div id="messageBody">
            영업일 기준 2~3일 이내에 답변드릴 예정이며, 등록하신 이메일로 회신드릴 예정입니다. 메일함을 확인해주세요.
        </div>
        <a href="../main/main" id="backButton">돌아가기</a>
    </div>
</body>
</html>