<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="formattedStartDate" value="${fn:replace(fn:substring(rsdto.startTime, 0, 10), '-', '.')}" />
<c:set var="formattedStartTime" value="${fn:substring(rsdto.startTime, 11, 13)}시" />
<c:set var="formattedEndDate" value="${fn:replace(fn:substring(rsdto.endTime, 0, 10), '-', '.')}" />
<c:set var="formattedEndTime" value="${fn:substring(rsdto.endTime, 11, 13)}시" />
<c:set var="duration" value="${endTime - startTime}" />
<c:set var="chongprice" value="${duration*rdto.halinprice}" />
<c:set var="hphone" value="${rdto.phone}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 확인</title>
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
        html {
            scroll-behavior: smooth;
        }
        
        body {
            font-family: 'LINESeedKR-Light', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-color: #f9f9f9;
            line-height: 1.6;
            margin-top: 130px;
        }
        
        /* 컨테이너 스타일 */
        .container {
            width: 1100px;
            margin: 30px auto;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            background-color: white;
        }
        
        /* 제목 스타일 */
        .page-title {
            font-family: 'LINESeedKR-Bold', sans-serif;
            font-size: 28px;
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #DDD;
            color: #5A7D9A;
        }
        
        .back-link {
            float: right;
            text-decoration: none;
            color: #3A3A3A;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .back-link:hover {
            background-color: #eee;
        }
        
        /* 섹션 제목 스타일 */
        .section-title {
            font-family: 'LINESeedKR-Bold', sans-serif;
            font-size: 20px;
            border-bottom: 2px solid #DDD;
            padding-bottom: 10px;
            margin: 30px 0 15px;
            color: #333;
        }
        
        /* 테이블 스타일 */
        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        
        .info-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }
        
        .info-table tr:last-child td {
            border-bottom: none;
        }
        
        .label-col {
            width: 30%;
            font-weight: bold;
            color: #555;
        }
        
        /* 환불 정책 스타일 */
        .refund-policy {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .refund-policy .warning {
            color: #e74c3c;
            font-weight: bold;
            margin-bottom: 15px;
        }
        
        .refund-list {
            list-style: none;
            padding: 0;
        }
        
        .refund-list li {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px dashed #ddd;
        }
        
        .refund-list li:last-child {
            border-bottom: none;
        }
        
        /* 위치 정보 스타일 */
        .location-info {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .location-name {
            font-family: 'LINESeedKR-Bold', sans-serif;
            font-size: 18px;
            margin-bottom: 10px;
        }
        
        /* 액션 버튼 */
        .action-buttons {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        
        .action-button {
            display: inline-block;
            background-color: #3A3A3A;
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 5px;
            font-family: 'LINESeedKR-Bold', sans-serif;
            text-align: center;
            width: 45%;
            transition: all 0.3s;
        }
        
        .action-button:hover {
            background-color: #DDD;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="page-title">예약확인</h1>
        <a href="../member/order" class="back-link">돌아가기</a>
        
        <h2 class="section-title">파티룸 예약 정보</h2>
        <table class="info-table">
            <tr>
                <td class="label-col">예약신청일</td>
                <td>${rsdto.writeday}</td>
            </tr>
            <tr>
                <td class="label-col">예약공간</td>
                <td>${rdto.name}</td>
            </tr>
            <tr>
                <td class="label-col">예약내용</td>
                <td>${formattedStartDate} / ${formattedStartTime}~${formattedEndTime}</td>
            </tr>
            <tr>
                <td class="label-col">예약가격</td>
                <td><fmt:formatNumber value="${rsdto.reservprice}" type="number" pattern="#,###"/>원</td>
            </tr>
            <tr>
                <td class="label-col">요청사항</td>
                <td>${rsdto.requesttohost}</td>
            </tr>
            <tr>
                <td class="label-col">사용목적</td>
                <td>${rsdto.purposeuse}</td>
            </tr>
            <tr>
                <td class="label-col">예약코드</td>
                <td>${rsdto.jumuncode}</td>
            </tr>
        </table>
        
        <h2 class="section-title">예약자 정보</h2>
        <table class="info-table">
            <tr>
                <td class="label-col">예약자명</td>
                <td>${mdto.name}</td>
            </tr>
            <tr>
                <td class="label-col">연락처</td>
                <td>${mdto.phone}</td>
            </tr>
            <tr>
                <td class="label-col">이메일</td>
                <td>${mdto.email}</td>
            </tr>
        </table>
        
        <h2 class="section-title">환불규정 안내</h2>
        <div class="refund-policy">
            <div class="warning">이용당일(첫 날) 이후의 환불 관련 사항은 호스트에게 직접 문의하셔야 합니다.</div>
            
            <ul class="refund-list">
                <c:set var="days" value="이용 8일 전,이용 7일 전,이용 6일 전,이용 5일 전,이용 4일 전,이용 3일 전,이용 2일 전,이용 전날,이용 당일" />
                <c:forEach var="i" begin="0" end="8">
                    <li>
                        <strong><c:out value="${fn:split(days, ',')[i]}"/></strong>
                        <span>
                            <c:set var="refund" value="${fn:split(rdto.refundpolicy, ',')[i]}" />
                            <c:choose>
                                <c:when test="${refund == '-1'}">환불 불가</c:when>
                                <c:when test="${refund == '0'}">총 금액의 100% 환불</c:when>
                                <c:when test="${refund == '1'}">총 금액의 90% 환불</c:when>
                                <c:when test="${refund == '2'}">총 금액의 80% 환불</c:when>
                                <c:when test="${refund == '3'}">총 금액의 70% 환불</c:when>
                                <c:when test="${refund == '4'}">총 금액의 60% 환불</c:when>
                                <c:when test="${refund == '5'}">총 금액의 50% 환불</c:when>
                                <c:when test="${refund == '6'}">총 금액의 40% 환불</c:when>
                                <c:when test="${refund == '7'}">총 금액의 30% 환불</c:when>
                                <c:when test="${refund == '8'}">총 금액의 20% 환불</c:when>
                                <c:otherwise>환불 정책 없음</c:otherwise>
                            </c:choose>
                        </span>
                    </li>
                </c:forEach>
            </ul>
        </div>
        
        <h2 class="section-title">위치 정보</h2>
        <div class="location-info">
            <div class="location-name">${rdto.name}</div>
            <div>${rdto.roadadress}</div>
            <div>연락처: ${fn:substring(hphone, 0, 3)}-${fn:substring(hphone, 3, 7)}-${fn:substring(hphone, 7, 11)}</div>
            
            <div class="action-buttons">
                <a href="tel:${rdto.phone}" class="action-button">전화걸기</a>
                <a href="https://map.naver.com/v5/search/${rdto.roadadress}" class="action-button">길찾기</a>
            </div>
        </div>
    </div>
</body>
</html>