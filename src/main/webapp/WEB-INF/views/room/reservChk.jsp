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
<title>Insert title here</title>
</head>
<body>
	<section>
		<h3>예약확인</h3>
		<hr>
		<div>파티룸 예약 정보</div>
		<div style="float: right"><a href="../member/order">돌아가기</a></div>
		<hr>
		<table>
		<tr>
		 <td>예약신청일</td>
		 <td>${rsdto.writeday}</td>
		</tr>
		<tr>
		 <td colspan="2">예약공간</td>
		</tr>
		<tr>
		 <td>${rsdto.name}</td>
		 <td></td>
		</tr>
		<tr>
		 <td>예약내용</td>
		 <td>${formattedStartDate}/${formattedStartTime}~${formattedEndTime}</td>
		</tr>
		<tr>
			<td>예약가격</td>
			<td><fmt:formatNumber value="${rsdto.reservprice}" type="number" pattern="#,###"/>원</td>
		</tr>
		<tr>
		 <td>요청사항</td>
		 <td>${rsdto.requesttohost}</td>
		</tr>
		<tr>
		 <td>사용목적</td>
		 <td>${rsdto.purposeuse}</td>
		</tr>
		<tr>
		 <td>예약코드</td>
		 <td>${rsdto.jumuncode}</td>
		</tr>
		<tr>
		 <td colspan="2">예약자 정보</td>
		</tr>
		<tr>
		 <td>예약자명</td>
		 <td>${mdto.name}</td>
		</tr>
		<tr>
		 <td>연락처</td>
		 <td>${mdto.phone}</td>
		</tr>
		<tr>
		 <td>이메일</td>
		 <td>${mdto.email}</td>
		</tr>
		<tr>
		 <td colspan="2">환불규정 안내</td>
		 <td>
		 
		 <!-- 환불규정 안내 -->
  <div>환불규정 안내</div>
  <div style="color: red">이용당일(첫 날) 이후의 환불 관련 사항은 호스트에게 직접 문의하셔야 합니다.</div>
  
  
	<c:set var="days" value="이용 8일 전,이용 7일 전,이용 6일 전,이용 5일 전,이용 4일 전,이용 3일 전,이용 2일 전,이용 전날,이용 당일" />
	<ul style="list-style: none;">
	    <c:forEach var="i" begin="0" end="8">
	        <li>
	            <!-- 날짜 출력 -->
	            <c:out value="${fn:split(days, ',')[i]}"/> 
	
	            <!-- 환불 정책 값 가져오기 -->
	            <c:set var="refund" value="${fn:split(rdto.refundpolicy, ',')[i]}" />
	
	            <!-- 환불 정책 처리 -->
	            <c:choose>
	                <c:when test="${refund == '-1'}">환불 불가</c:when>
	                <c:when test="${refund == '0'}">총 금액의 100% 환불</c:when>
	                <c:when test="${refund == '1'}">총 금액의 90% 환불</c:when>
	                <c:when test="${refund == '2'}">총 금액의 80% 환불</c:when>
	                <c:when test="${refund == '3'}">총 금액의 70% 환불</c:when>
	                <c:when test="${refund == '4'}">총 금액의 60% 환불</c:when>
	                <c:when test="${refund == '5'}">총 금액의 50% 환불</c:when>
	                <c:when test="${refund == '6'}">총 금액의 40% 환불</c:when>
	                <c:when test="${refund == '7'}">총 금액의 80% 환불</c:when>
	                <c:when test="${refund == '8'}">총 금액의 90% 환불</c:when>
	                <c:otherwise>환불 정책 없음</c:otherwise>
	            </c:choose>
	        </li>
	    </c:forEach>
	</ul>
	<!-- 환불규정 안내 끝 -->
		 
		 </td>
		</tr>
		</table>
		<div>위치</div>
		<div>${rdto.name}</div>
 		<div>${rdto.roadadress}</div>
 		<div>${fn:substring(hphone, 0, 3)}-${fn:substring(hphone, 3, 7)}-${fn:substring(hphone, 7, 11)}</div>
 		<table>
 		<tr>
 		<td><a href="tel:${rdto.phone}">전화걸기</a></td>
 		<td><a href="https://map.naver.com/v5/search/${rdto.roadadress}">길찾기</a></td>
 		</tr>
 		</table>
	</section>
</body>
</html>