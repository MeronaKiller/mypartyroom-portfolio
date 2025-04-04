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
<title>Insert title here</title>
<style>
	#roomrservtitle
	{
	
	}
	html
  	{
    scroll-behavior: smooth;
	}
  #rContainer_top
  {
  	width: 1100px;
  	height:300px;
  	border: 1px solid black;
  	margin:auto;
  }  
  
  .rContainer
  {
  	width: 1100px;
    margin:auto;
  }

  .rContent_wrapper
  {
    width:65%;
    height:auto;
    border: 1px solid black;
    overflow: auto;
    float:left;
  }

.facility-list {
      display: flex;
      flex-wrap: wrap;
      padding: 0;
      list-style: none;
      }
      .fimg
      {
      	margin-left: 20px;
            flex-grow: 1;
      }
	.fimg img
	{
		width: 40px;
		height: 40px;
	}
	.facility-item {
            width: 10%; /* 한 줄에 3개씩 */
            text-align: center;
        }
        .facility-item img {
            width: 30px;
            height: 30px;
        }
        .facility-item p {
            margin-top: 5px;
            font-size: 14px;
        }
        #reserveinfo1
        {
        float: right;
        }
        .reservinfo
        {
        	border: 1px solid black;
        }
        .rAside_menu
        {
		    width: 25%;
		    height: auto;
		    border: 1px solid black;
		    position: fixed;
		    right: 13%;
        }
        .rAside_menu .rAside_both
        {
        	overflow: hidden;
        }
        .rAside_menu .rAside_left
        {
        	width: 65%;
        	float: left;
        }
        .rAside_menu .rAside_right
        {
        	width: 30%;
        	float: right;
        }
        section .rform{
		display:none;
	}
	section .tdPay{
		width:1100px;
		height:150px;
		border:1px solid green;
	}
	section .pay{
		display:none;
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
<form method="post" action="reservOk" onsubmit="return check()">
<div id="rContainer_top">예약하기</div>
<div class="rContainer">
<div class="rContent_wrapper">
<div>
<div style="float: left;">예약 공간</div>
<div style="float: right;"><fmt:formatNumber value="${rdto.halinprice}" type="number" pattern="#,###"/>원/시간</div>
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
    
    
		<div> <input type="submit" value="예약하기"> </div><!-- 예약폼 시작 -->
		</div> <!-- 상품문의와 문의하기 링크 -->
		<div>  </div> <!-- 상품문의 출력 -->
	   </div> <!-- 상품 문의 -->
</aside>
</div>
</form>
</body>
</html>