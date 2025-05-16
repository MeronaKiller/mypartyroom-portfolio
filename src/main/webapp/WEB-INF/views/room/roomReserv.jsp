<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<c:set var="duration" value="${endTime - startTime}" />
<c:set var="chongprice" value="${duration*rdto.halinprice}" />
<c:set var="hphone" value="${rdto.phone}" />
<html>
<head>
<meta charset="UTF-8">
<title>룸 예약하기</title>

<!-- 패키지 정보 파싱 -->
<c:set var="selectedPackage" value="${param.selectedPackage}" />
<c:set var="isPackage" value="${not empty selectedPackage}" />

<c:choose>
    <c:when test="${isPackage}">
        <!-- 패키지 정보가 있는 경우 -->
        <c:set var="packageParts" value="${fn:split(selectedPackage, ',')}" />
        <c:set var="packageName" value="${packageParts[0]}" />
        <c:set var="packagePrice" value="${packageParts[1]}" />
        <c:set var="packageStartTime" value="${packageParts[2]}" />
        <c:set var="packageEndTime" value="${packageParts[3]}" />
        
        <!-- 패키지 가격 설정 -->
        <c:set var="chongprice" value="${packagePrice}" />
        
		<!-- 패키지 시간 계산 -->
		<c:set var="startHour" value="${fn:substring(packageStartTime, 0, 2)}" />
		<c:set var="endHour" value="${fn:substring(packageEndTime, 0, 2)}" />
		<c:set var="startHourInt" value="${Integer.parseInt(startHour)}" />
		<c:set var="endHourInt" value="${Integer.parseInt(endHour)}" />
		<c:set var="duration" value="${endHourInt - startHourInt}" />
		<c:if test="${duration < 0}">
		    <c:set var="duration" value="${24 + duration}" /> <!-- 다음날로 넘어가는 경우 처리 -->
		</c:if>
    </c:when>
    <c:otherwise>
<!-- 일반 시간 예약인 경우 -->
<c:set var="duration" value="${endTime - startTime}" />
<c:if test="${duration < 0}">
    <c:set var="duration" value="${24 + duration}" /> <!-- 다음날로 넘어가는 경우 처리 -->
</c:if>
<c:set var="chongprice" value="${duration * rdto.halinprice}" />
    </c:otherwise>
</c:choose>

<c:set var="hphone" value="${rdto.phone}" />

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
  
  @font-face {
    font-family: 'BMJUA';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
    font-weight: normal;
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
  
  /* 상단 컨테이너 */
  #rContainer_top {
    width: 1100px;
    height: 160px;
    margin: 30px auto;
    border: none;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 28px;
    border-radius: 15px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    background-color: white;
  }
  
  .rContainer {
    width: 1100px;
    margin: 0 auto 50px;
    overflow: hidden;
    display: flex;
    gap: 20px;
  }

  .rContent_wrapper {
    width: 70%;
  height: auto;
  border: none;
  overflow: visible; /* auto에서 visible로 변경하여 스크롤바 제거 */
  padding: 25px;
  box-sizing: border-box;
  border-radius: 10px;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
  background-color: white;
  margin-bottom: 20px;
  }

  .rAside_menu {
    width: 27%;
    height: auto;
    border: none;
    position: sticky;
    top: 20px;
    padding: 20px;
    box-sizing: border-box;
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    background-color: white;
    right: auto;
  }
  
  /* 시설 리스트 */
  .facility-list {
    display: flex;
    flex-wrap: wrap;
    padding: 0;
    list-style: none;
    gap: 10px;
  }
  
  .facility-item {
    width: 12%;
    margin-bottom: 15px;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  
  .facility-item img {
    width: 40px;
    height: 40px;
    margin-bottom: 5px;
  }
  
  .facility-item p {
    margin: 5px 0 0;
    font-size: 13px;
    text-align: center;
  }
  
  .fimg {
    margin-left: 0;
    margin-bottom: 25px;
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
  
  /* 예약 정보 스타일 */
  .reservinfo {
    border: none;
    padding: 15px 0;
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 20px;
    border-bottom: 2px solid #DDD;
    margin: 30px 0 15px;
  }
  
  /* 사이드바 예약 정보 */
  .rAside_menu .rAside_both {
    overflow: hidden;
    padding-bottom: 15px;
    margin-bottom: 15px;
    border-bottom: 1px solid #eee;
  }
  
  .rAside_menu .rAside_left {
    width: 60%;
    float: left;
  }
  
  .rAside_menu .rAside_right {
    width: 40%;
    float: right;
    font-weight: bold;
    text-align: right;
    font-size: 16px;
    word-break: break-all;
  }
  
  /* 버튼 스타일 */
  input[type="submit"] {
    width: 100%;
    background-color: #3A3A3A;
    color: white;
    border: none;
    padding: 12px 20px;
    border-radius: 5px;
    font-family: 'LINESeedKR-Bold', sans-serif;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.3s;
    margin-top: 15px;
  }
  
  input[type="submit"]:hover {
    background-color: #DDD;
    color: #333;
  }
  
  /* 결제 수단 스타일 */
  .tdPay {
    width: 100%;
    height: auto;
    border: none;
    border-radius: 8px;
    background-color: #f9f9f9;
    padding: 15px;
    margin-bottom: 15px;
  }
  
  .pay {
    margin-bottom: 10px;
  }
  
  .rform {
    margin: 10px 0 10px 20px;
  }
  
  /* 라디오 버튼 스타일 */
  input[type="radio"] {
    margin-right: 10px;
  }
  
  /* 셀렉트 스타일 */
  select {
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ddd;
    margin-right: 10px;
  }
  
  /* 텍스트 에어리어 스타일 */
  textarea {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
    margin: 10px 0;
    font-family: 'LINESeedKR-Light', sans-serif;
    resize: vertical;
  }
  
  /* 화살표 버튼 */
  #arrow {
    cursor: pointer;
  }
  
  /* 공간 정보 영역 */
  .space-info {
    display: flex;
    align-items: flex-start;
    margin-bottom: 20px;
    padding: 15px 0;
    border-bottom: 1px solid #eee;
  }
  
  .space-info img, div[style*="padding:30px"] img {
  width: 200px; /* 140px에서 200px로 크기 증가 */
  height: 200px; /* 140px에서 200px로 크기 증가 */
  object-fit: cover;
  border-radius: 8px;
  }
  
  .space-details {
    flex-grow: 1;
  }
  
  .space-name {
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 20px;
    margin-bottom: 5px;
  }
  
  .space-desc {
    color: #666;
    margin-bottom: 10px;
  }
  
  /* 카테고리 제목 */
  .category-title {
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 18px;
    margin: 20px 0 10px;
  }
  
  /* pre 태그 스타일 */
  pre {
    white-space: pre-wrap;
    font-family: 'LINESeedKR-Light', sans-serif;
    font-size: 15px;
    line-height: 1.6;
    background-color: #f9f9f9;
    padding: 15px;
    border-radius: 5px;
    margin: 10px 0;
  }
  
  /* 글자수 카운터 */
  #chongWord, #chongWord1 {
    color: #888;
  }
  
  /* 호스트 정보 섹션 */
  .host-info {
    background-color: #f9f9f9;
    padding: 15px;
    border-radius: 8px;
    margin: 20px 0;
  }
  
  /* 가격 표시 */
  .price-display {
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 24px;
    color: #333;
    text-align: right;
    margin: 15px 0;
  }
</style>
<script>
	function wordlen(my)
	{
		var len=my.value.trim().length;
		document.getElementById("chongWord").innerText=len;
	}
	function wordlen1(my)
	{
		var len=my.value.trim().length;
		document.getElementById("chongWord1").innerText=len;
	}
	var payChk=0;
	function viewHide()
	{
		// class="pay"의 인덱스 2~5까지의 내용을 전부 보이기 or 전부 숨기기
		var pay=document.getElementsByClassName("pay");
		if(payChk%2==0)
		{
			for(i=2;i<pay.length;i++)
			{
				pay[i].style.display="block";
			}
			document.getElementById("arrow").innerText="▲";
		}
		else
		{
			for(i=2;i<pay.length;i++)
			{
				pay[i].style.display="none";
			}
			document.getElementById("arrow").innerText="▼";
		}
		payChk++;
	}
</script>
</head>
<body>
<c:set var="selectedPackage" value="${param.selectedPackage}" />

<!-- 패키지 정보가 있는 경우 처리 -->
<c:if test="${not empty selectedPackage}">
    <c:set var="packageParts" value="${fn:split(selectedPackage, ',')}" />
    <c:set var="packageName" value="${packageParts[0]}" />
    <c:set var="packagePrice" value="${packageParts[1]}" />
    <c:set var="packageStartTime" value="${packageParts[2]}" />
    <c:set var="packageEndTime" value="${packageParts[3]}" />
    
    <!-- 패키지 정보를 hidden 필드로 추가 -->
    <input type="hidden" name="selectedPackage" value="${selectedPackage}">
</c:if>

<form method="post" action="reservOk" onsubmit="return check()">
<div id="rContainer_top">예약하기</div>
<div class="rContainer">
<div class="rContent_wrapper">
<div>
<div style="float: left;">예약 공간</div>
<div style="float: right;">
    <c:choose>
        <c:when test="${not empty selectedPackage}">
            <fmt:formatNumber value="${packagePrice}" type="number" pattern="#,###"/>원/패키지
        </c:when>
        <c:otherwise>
            <fmt:formatNumber value="${rdto.halinprice}" type="number" pattern="#,###"/>원/시간
        </c:otherwise>
    </c:choose>
</div>
</div>
<div><!-- 회원 정보 -->
<div>
<div style="padding:30px;"><img style="width:140px; height:140px; float:left;" src="../static/room/${rdto.pic}"></div>
	<div id="reservinfo1">${rdto.name} <br><hr>
	${rdto.subdesc}</div>
</div>
<div>최대인원:${rdto.capacity}명</div>
<div class="fimg"><!-- 아이콘쪽시작 -->
		<!-- 시설형황 -->
	<div>시설 현황</div>
	<ul class="facility-list">
	<c:forEach var="status" items="${rdto.fstatus}">
	<li class="facility-item">
	<c:choose>
	<c:when test="${status == 0}">
        <img src="../static/facility/aircon.png">
        <p>냉/난방기</p>
    </c:when>
	<c:when test="${status == 1}">
        <img src="../static/facility/parking.png">
        <p>주차</p>
    </c:when>
	<c:when test="${status == 2}">
        <img src="../static/facility/bbq.png">
        <p>바베큐 시설</p>
    </c:when>
	<c:when test="${status == 3}">
        <img src="../static/facility/rooftop.png">
        <p>테라스/루프탑</p>
    </c:when>
	<c:when test="${status == 4}">
        <img src="../static/facility/inwc.png">
        <p>내부 화장실</p>
    </c:when>
	<c:when test="${status == 5}">
        <img src="../static/facility/outwc.png">
        <p>외부 화장실</p>
    </c:when>
	<c:when test="${status == 6}">
        <img src="../static/facility/heating.png">
        <p>바닥 난방</p>
    </c:when>
	<c:when test="${status == 7}">
        <img src="../static/facility/hotwater.png">
        <p>온수</p>
    </c:when>
	<c:when test="${status == 8}">
        <img src="../static/facility/internet.png">
        <p>인터넷/wifi</p>
    </c:when>
	<c:when test="${status == 9}">
        <img src="../static/facility/nosmoking.png">
        <p>실내 흡연 금지</p>
    </c:when>
	<c:when test="${status == 10}">
        <img src="" alt="실내 흡연 가능">
        <p>실내 흡연 가능</p>
    </c:when>
    <c:otherwise>
        <img src="../static/facility/elevator.png">
        <p>엘리베이터 있음</p>
    </c:otherwise>
    </c:choose>
    </li>
    </c:forEach>
    </ul>
	</div>
		
	<div class="fimg"><!-- 아이콘쪽시작 -->
	<div>내부 안내</div>
		<!-- 내부안내 -->
		
	<ul class="facility-list">
	<c:forEach var="status" items="${rdto.ininfo}">
	<li class="facility-item">
	<c:choose>
	<c:when test="${status == 0}">
        <img src="../static/facility/beampjt.png">
        <p>빔프로젝터</p>
    </c:when>
	<c:when test="${status == 1}">
        <img src="../static/facility/tv.png">
        <p>TV</p>
    </c:when>
	<c:when test="${status == 2}">
        <img src="../static/facility/damyo.png">
        <p>담요/매트리스</p>
    </c:when>
	<c:when test="${status == 3}">
        <img src="../static/facility/table.png">
        <p>테이블/의자</p>
    </c:when>
	<c:when test="${status == 4}">
        <img src="../static/facility/mirror.png">
        <p>전신거울</p>
    </c:when>
	<c:when test="${status == 5}">
        <img src="../static/facility/bluespeaker.png">
        <p>블루투스 스피커</p>
    </c:when>
    <c:otherwise>
        <img src="../static/facility/pc.png">
        <p>PC</p>
    </c:otherwise>
    </c:choose>
    </li>
    </c:forEach>
    </ul>
	</div>
		
		
	<div class="fimg"><!-- 아이콘쪽시작 -->
	<div>놀이</div>
		<!-- 놀이 -->
	<ul class="facility-list">
	<c:forEach var="status" items="${rdto.play}">
	<li class="facility-item">
	<c:choose>
	<c:when test="${status == 0}">
        <img src="../static/facility/boardgame.png">
        <p>보드 게임</p>
    </c:when>
	<c:when test="${status == 1}">
        <img src="../static/facility/sing.png">
        <p>노래방 기능</p>
    </c:when>
	<c:when test="${status == 2}">
        <img src="../static/facility/mirrorball.png">
        <p>미러볼</p>
    </c:when>
	<c:when test="${status == 3}">
        <img src="../static/facility/etcgame.png">
        <p>기타 게임</p>
    </c:when>
	<c:when test="${status == 4}">
        <img src="../static/facility/game.png">
        <p>오락기</p>
    </c:when>
	<c:when test="${status == 5}">
        <img src="../static/facility/party.png">
        <p>파티 소품</p>
    </c:when>
	<c:when test="${status == 6}">
        <img src="../static/facility/poker.png">
        <p>홀덤 테이블</p>
    </c:when>
    <c:otherwise>
        <img src="../static/facility/swim.png">
        <p>수영장</p>
    </c:otherwise>
    </c:choose>
    </li>
    </c:forEach>
    </ul>
	</div>
		
	<div class="fimg"><!-- 아이콘쪽시작 -->
	<div>주방</div>
		<!-- 주방 -->
	<ul class="facility-list">
	<c:forEach var="status" items="${rdto.kitchen}">
	<li class="facility-item">
	<c:choose>
	<c:when test="${status == 0}">
        <img src="../static/facility/sink.png">
        <p>싱크대</p>
    </c:when>
	<c:when test="${status == 1}">
        <img src="../static/facility/cook.png">
        <p>취사시설</p>
    </c:when>
	<c:when test="${status == 2}">
        <img src="../static/facility/microwave.png">
        <p>전자레인지</p>
    </c:when>
	<c:when test="${status == 3}">
        <img src="../static/facility/elecpot.png">
        <p>전기포트</p>
    </c:when>
	<c:when test="${status == 4}">
        <img src="../static/facility/tableware.png">
        <p>식기/수저</p>
    </c:when>
	<c:when test="${status == 5}">
        <img src="../static/facility/cup.png">
        <p>컵/잔</p>
    </c:when>
	<c:when test="${status == 6}">
        <img src="../static/facility/coffee.png">
        <p>커피 머신</p>
    </c:when>
	<c:when test="${status == 7}">
        <img src="../static/facility/waterdisp.png">
        <p>정수기</p>
    </c:when>
    <c:otherwise>
        <img src="../static/facility/ice.png">
        <p>제빙기</p>
    </c:otherwise>
    </c:choose>
    </li>
    </c:forEach>
    </ul>
	</div>
	
	<div class="reservinfo">예약정보</div><!-- 예약정보 -->
	<div>예약 날짜: ${formattedDate} (${dayOfWeek}) / ${startTime}시~${endTime}시</div>

	<div>예약자 정보</div><!-- 예약자 정보 -->
	<div>예약자:${mdto.name}</div>
	<div>연락처:${mdto.phone}</div>
	<div>이메일:${mdto.email}</div>
	
	 <!-- 결제수단 -->
  <table width="1100" align="center">
  	<caption><h3 align="left"> 결제수단 </h3></caption>
  	<tr>
  	 <td class="tdPay">
  	 <div class="pay">
  		<input type="radio" name="pay" value="0" onclick="chgPay(this.value)"> 신용/체크카드
  		<div class="rform"> <!-- 입력할 폼 생성 -->
  			<select name="card1">
  				<option value="0"> 신한은행 </option>
  				<option value="1"> 우리은행 </option>
  				<option value="2"> 농협은행 </option>
  				<option value="3"> KB은행 </option>
  			</select>
  			<select name="halbu1">
  				<option value="0"> 일시불 </option>
  				<option value="1"> 2개월 </option>
  				<option value="2"> 3개월 </option>
  				<option value="3"> 6개월 </option>
  				<option value="4"> 12개월 </option>
  			</select>
  		</div>
  	</div>
  	<div class="pay">
  		<input type="radio" name="pay" value="1" onclick="chgPay(this.value)"> 차니페이
  		<div class="rform"> <!-- 입력할 폼 생성 -->
  			0원
  		</div>
  		<div class="pay"> 
  	 </td>
  	</tr>
  	<tr>
  	<td class="tdPay"> 
  		<div onclick="viewHide()"> 다른 결제 수단 <span id="arrow">▼</span> </div>
  	 	<div class="pay">
  		<input type="radio" name="pay" value="2" onclick="chgPay(this.value)"> 계좌이체
  		<div class="rform">
  			<select name="bank1">
  				<option value="0"> 신한은행 </option>
  				<option value="1"> 농협은행 </option>
  				<option value="2"> 우리은행 </option>
  				<option value="3"> KB은행 </option>
  			</select>
  		</div>
  	</div>
  		<div class="pay">
  		<input type="radio" name="pay" value="3" onclick="chgPay(this.value)"> 법인카드
  		<div class="rform">
  		 <select name="card2">
               <option value="0"> 신한카드 </option>
               <option value="1"> 우리카드 </option>
               <option value="2"> 농협카드 </option>
               <option value="3"> KB카드 </option>
               </select>
  		</div>
  	</div>
  		<div class="pay">
  		<input type="radio" name="pay" value="4" onclick="chgPay(this.value)"> 휴대폰
  		<div class="rform">
            <select name="tel">
               <option value="0"> SKT </option>
               <option value="1"> KT </option>
               <option value="2"> LG </option>
               <option value="3"> 알뜰통신 </option>
             </select>
  		</div>
  	</div>
  		<div class="pay">
  		<input type="radio" name="pay" value="5" onclick="chgPay(this.value)"> 무통장입금
  		<div class="rform">
            <select name="bank2">
              <option value="0"> 신한은행 </option>
              <option value="1"> 농협은행 </option>
              <option value="2"> 우리은행 </option>
              <option value="3"> KB은행 </option>
            </select>
  		</div>
  	</div>
  	 </td>
  	</tr>
  </table>
	
		사용목적<textarea maxlength="100" onkeyup="wordlen(this)" name="purposeuse" style="width:650px; height:30px;" placeholder="촬영, 파티, 모임, 수업 등 공간의 사용 목적을 입력해주세요.(최대 100자)"></textarea><br>
		<div> 총글자수(<span id="chongWord">0</span>) </div>
		요청사항<textarea maxlength="500" onkeyup="wordlen1(this)" name="requesttohost" style="width:650px; height:300px;" placeholder="남기고 싶은말을 적어주세요. (최대 500자)"></textarea>
		<div> 총글자수(<span id="chongWord1">0</span>) </div>
	예약자 정보로 알림톡과 이메일이 발송됩니다. 정확한 정보인지 확인해주세요.
	
	
	
	<div>호스트 정보</div>
	<div>공간상호:${rdto.bname}</div>
	<div>대표자명:${rdto.hostname}</div>
	<div>소재지:${rdto.roadadress}</div>
	<div>사업자번호:${rdto.bnum}</div>
	<div>연락처:${fn:substring(hphone, 0, 3)}-${fn:substring(hphone, 3, 7)}-${fn:substring(hphone, 7, 11)}이메일: ${rdto.hostemail}</div>

	<div>예약시 주의사항</div>
	<div><pre style="white-space: pre-wrap;">${rdto.caution}</pre></div>
	
	


<!-- 룸 정보 -->
<%-- <p>룸 코드: ${rdto.rcode}</p>
<p>할인율: ${rdto.halin}%</p></div> --%>
</div>
</div>
<aside class="rAside_menu">
<!-- 왼 -->
<div class="rAside_both">
<div class="rAside_left">
<div>결제예정금액</div>
<div>예약 날짜${formattedDate}(${dayOfWeek})</div>
<div>예약시간${startTime}시~${endTime}시,
${duration}시간</div>
<div>예약최대인원 ${rdto.capacity}명</div>
</div>
<!-- 오 -->
<div class="rAside_right">
&#8361;<fmt:formatNumber value="${chongprice}" type="number" pattern="#,###"/>
</div>
</div>

	<div style="clear: both; margin-top: 10px;">
		&#8361;<fmt:formatNumber value="${chongprice}" type="number" pattern="#,###"/>
    </div>
    
    
    <input type="hidden" value="${rdto.rcode}" name="rcode">
    <input type="hidden" value="${userid}" name="userid">
    <input type="hidden" value="${selectedDate}" name="selectedDate">
    <input type="hidden" value="${startTime}" name="startTime">
    <input type="hidden" value="${endTime}" name="endTime">
    <input type="hidden" value="${chongprice}" name="reservprice">
    <input type="hidden" value="${rdto.name}" name="name">
    
    
		<div> <input type="submit" value="예약하기"> </div><!-- 예약폼 시작 -->
		</div> <!-- 상품문의와 문의하기 링크 -->
		<div>  </div> <!-- 상품문의 출력 -->
	   </div> <!-- 상품 문의 -->
</aside>
</div>
</form>
</body>
</html>