<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Insert title here</title>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=mx8e1c4689"></script>
    
    
<!-- Flatpickr -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- Day.js -->
<script src="https://cdn.jsdelivr.net/npm/dayjs/dayjs.min.js"></script>

    
    
<style>
  html
  	{
    scroll-behavior: smooth;
	}
  #cContainer_top
  {
  	width: 1100px;
  	height:300px;
  	border: 1px solid black;
  	margin:auto;
  }  
  
  .cContainer
  {
  	width: 1100px;
    margin:auto;
  }

  .cContent_wrapper
  {
    width:70%;
    height:auto;
    border: 1px solid black;
    overflow: auto;
    float:left;
  }

  .cAside_menu
  {
    width: 25%;
    height:auto;
    float:right;
    border: 1px solid black;
    }
    
   #cImgMain
   {
     width:770px;
     height:480px;
     margin:auto;
     overflow:hidden;
     position: relative;
   }
   .cImgAll .cImg
   {
	 width: 100%;
     height: 100%;
	 object-fit: cover; /* 빈 공간 없이 채우기, 일부 잘림 */
   }
   .cImg {
    position: absolute; /* 겹치게 설정 */
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: none; /* 처음에는 전부 숨김 */
	}

	.cImg:first-child {
	    display: block; /* 첫 번째 이미지만 보이게 */
	}
	.cfloor
	{
		width: 100px;
		height: 100px;
	}
	.topinfodiv
	{
		display: flex;
	}
	.topinfodiv .topinfo img
	{
		width: 40px;
		height: 40px;
	}
	.ctitle
	{
		text-align: center;
		font-size: 30px;
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
            width: 23%; /* 한 줄에 3개씩 */
            margin-bottom: 15px;
            text-align: center;
        }
        .facility-item img {
            width: 40px;
            height: 40px;
        }
        .facility-item p {
            margin-top: 5px;
            font-size: 14px;
        }
       .durationchk
       {
       	list-style: none;
       }

	</style>
	<style>/* 날짜 스타일 */
	.time-container { 
	    display: flex;
	    gap: 10px;
	    padding: 10px;
	    border: 1px solid black;
	    border-radius: 8px;
	    user-select: none;
	    flex-wrap: wrap;
	}
	
	.time-block {
	    min-width: 60px;
	    height: 50px;
	    background-color: #6a0dad;
	    color: #fff;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    border-radius: 5px;
	    cursor: pointer;
	    flex-shrink: 0;
	}
	
	.time-block.selected {
	    background-color: #f5b800;
	    color: #000;
	}
	
	.time-block.disabled {
	    background-color: #ddd;
	    color: #aaa;
	    cursor: not-allowed;
	}
	.pkgConCss {
    border: 1px solid #ddd;
    border-radius: 5px;
    margin: 10px 0;
    padding: 8px;
    cursor: pointer;
    transition: border-color 0.3s;
	}
	
	.pkgConCss:hover:not(.disabled) {
	    border-color: #f5b800;
	}
	
	.pkgConCss.selected {
	    border: 2px solid #f5b800;
	}
	
	.pkgConCss.disabled {
	    background-color: #ddd;
	    color: #888;
	    cursor: not-allowed;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const timeContainer = document.getElementById('timeContainer');
    const timeDiv = document.getElementById('timeDiv');
    const pkgTimeDiv = document.getElementById('pkgtimeDiv');
    const timeDurationCheckbox = document.getElementById('timeduration');
    const pkgDurationCheckbox = document.getElementById('pkgduration');
    let selectedStartTime = null;
    let selectedEndTime = null;
    let selectedDateStr = null; // 선택된 날짜 변수

    const times = Array.from({ length: 24 }, (_, i) => i.toString().padStart(2, '0') + ':00');

    // 패키지 예약 시간과 겹치는지 확인해서 비활성화
    function disablePackage(reservedStart, reservedEnd) {
        var pkgItems = document.querySelectorAll('#packageResults .pkgConCss');
        
        pkgItems.forEach(function(item) {
            var pkgText = item.textContent;
            var startMatch = pkgText.match(/(\d+)시~/);
            var endMatch = pkgText.match(/~(\d+)시/);
            
            if(startMatch && endMatch) {
                var pkgStart = parseInt(startMatch[1]);
                var pkgEnd = parseInt(endMatch[1]);
                
                var isOverlap = (pkgStart < reservedEnd && pkgEnd > reservedStart);
                
                if(isOverlap) {
                    item.classList.add('disabled');
                    item.style.backgroundColor = '#ddd';
                    item.style.color = '#888';
                    item.style.cursor = 'not-allowed';
                    item.onclick = null;
                }
            }
        });
    }

    // 시간대 렌더링 함수
    function renderTimeSlots(selectedDateStr) {
        timeContainer.innerHTML = '';
        resetSelection();
        const now = dayjs();
        const selectedDate = dayjs(selectedDateStr);

        times.forEach(time => {
            const block = document.createElement("div");
            block.classList.add("time-block");
            block.textContent = time;
            block.setAttribute('data-time', time);

            const [hour, minute] = time.split(':');
            const blockTime = selectedDate.hour(parseInt(hour)).minute(parseInt(minute));

            if (selectedDate.isBefore(now, 'day') || (selectedDate.isSame(now, 'day') && blockTime.isBefore(now))) {
                block.classList.add('disabled');
            } else {
                block.addEventListener("click", function () {
                    handleTimeSelection(block);
                });
            }

            timeContainer.appendChild(block);
        });
    }

    // 시간 선택 핸들러
    function handleTimeSelection(block) {
        const selectedTime = block.dataset.time;

        if (block.classList.contains('selected')) {
            resetSelection();
            return;
        }

        if (!selectedStartTime) {
            resetSelection();
            selectedStartTime = selectedTime;
            block.classList.add('selected');
        } 
        else if (!selectedEndTime) {
            if (selectedTime > selectedStartTime) {
                let hasDisabledBlocks = false;
                document.querySelectorAll('.time-block').forEach(timeBlock => {
                    const blockTime = timeBlock.dataset.time;
                    if (blockTime > selectedStartTime && blockTime <= selectedTime) {
                        if (timeBlock.classList.contains('disabled')) {
                            hasDisabledBlocks = true;
                        }
                    }
                });

                if (hasDisabledBlocks) {
                    alert("선택한 시간 범위에 이미 예약된 시간이 포함되어 있습니다.");
                    resetSelection();
                } else {
                    selectedEndTime = selectedTime;
                    selectTimeRange();
                }
            } else {
                alert("끝나는 시간은 시작 시간보다 늦어야 합니다.");
            }
        } 
        else {
            resetSelection();
            selectedStartTime = selectedTime;
            block.classList.add('selected');
        }
    }

    // 선택된 시간 범위 표시 및 값 저장
    function selectTimeRange() {
        let selecting = false;
        document.querySelectorAll('.time-block').forEach(block => {
            const time = block.dataset.time;
            if (time === selectedStartTime) selecting = true;
            if (selecting) block.classList.add('selected');
            if (time === selectedEndTime) selecting = false;
        });

        // Hidden input에 값 세팅
        document.getElementById('startTime').value = selectedStartTime;
        document.getElementById('endTime').value = selectedEndTime;

        console.log("선택된 날짜:", selectedDateStr);
        console.log("선택된 시간:", selectedStartTime, "~", selectedEndTime);

        if (selectedStartTime && selectedEndTime && selectedDateStr) {
            //alert(`선택된 날짜: ${selectedDateStr}\n선택된 시간: ${selectedStartTime} ~ ${selectedEndTime}`);
        } else {
            alert('날짜와 시간을 다시 선택해주세요.');
        }
    }

    // 시간 선택 초기화 함수
    function resetSelection() {
        document.querySelectorAll('.time-block').forEach(block => {
            block.classList.remove('selected');
        });
        selectedStartTime = null;
        selectedEndTime = null;
    }

    // 패키지 정보 렌더링 함수
    function renderPackageInfo(selectedDate) {
        // AJAX 요청을 통해 해당 날짜의 예약 정보 가져오기
        var chk = new XMLHttpRequest();
        chk.onload = function() {
            var reservationData = JSON.parse(chk.responseText);
            var reservedTimes = [];
            
            // 일반 예약 및 패키지 예약 시간 수집
            if(reservationData.timeReservations) {
                for(var dto of reservationData.timeReservations) {
                    reservedTimes.push({
                        start: parseInt(dto.startTime),
                        end: parseInt(dto.endTime)
                    });
                }
            }
            
            if(reservationData.packageReservations) {
                for(var pkg of reservationData.packageReservations) {
                    reservedTimes.push({
                        start: parseInt(pkg.startTime),
                        end: parseInt(pkg.endTime)
                    });
                }
            }
            
            // 패키지 정보 불러오기
            var pkgname = '${rdto.pkgname}';
            var pkgprice = '${rdto.pkgprice}';
            var pkgstart = '${rdto.pkgstart}';
            var pkgend = '${rdto.pkgend}';
            
            if(pkgname && pkgstart && pkgend) {
                var names = pkgname.split(',');
                var prices = pkgprice.split(',');
                var starts = pkgstart.split(',');
                var ends = pkgend.split(',');
                
                var results = [];
                var minLength = Math.min(names.length, prices.length, starts.length, ends.length);
                
                var pkgResultsElement = document.getElementById('packageResults');
                if(!pkgResultsElement) {
                    pkgResultsElement = document.createElement('div');
                    pkgResultsElement.id = 'packageResults';
                    document.getElementById('pkgtimeDiv').appendChild(pkgResultsElement);
                }
                
                pkgResultsElement.innerHTML = '';
                
                for(var i = 0; i < minLength; i++) {
                    // 콤마 사이에 빈값 체크
                    if(names[i] && names[i].trim() !== '' &&
                       starts[i] && starts[i].trim() !== '' &&
                       ends[i] && ends[i].trim() !== '') {
                        
                        var price = (prices[i] && prices[i].trim() !== '') ? prices[i] : '가격 정보 없음';
                        
                        var item = {
                            name: names[i].trim(),
                            price: price,
                            start: parseInt(starts[i].trim()),
                            end: parseInt(ends[i].trim())
                        };
                        
                        results.push(item);
                        
                        var isDisabled = false;
                        
                        // 예약된 시간과 겹치는지 확인
                        for(var j = 0; j < reservedTimes.length; j++) {
                            var reserved = reservedTimes[j];
                            if(item.start < reserved.end && item.end > reserved.start) {
                                isDisabled = true;
                                break;
                            }
                        }
                        
                        var pkgDiv = document.createElement('div');
                        pkgDiv.className = 'pkgConCss' + (isDisabled ? ' disabled' : '');
                        pkgDiv.textContent = '패키지 ' + (i+1) + ': ' + names[i] + ', ' + price + '원, ' + starts[i] + '시~' + ends[i] + '시';
                        
                        if(isDisabled) {
                            pkgDiv.style.backgroundColor = '#ddd';
                            pkgDiv.style.color = '#888';
                            pkgDiv.style.cursor = 'not-allowed';
                        } else {
                            pkgDiv.setAttribute('data-name', names[i]);
                            pkgDiv.setAttribute('data-price', price);
                            pkgDiv.setAttribute('data-start', starts[i]);
                            pkgDiv.setAttribute('data-end', ends[i]);
                            
                            pkgDiv.addEventListener('click', function() {
                                // 이미 선택된 패키지가 있으면 선택 해제
                                document.querySelectorAll('.pkgConCss').forEach(pkg => {
                                    pkg.classList.remove('selected');
                                    pkg.style.border = '1px solid #ddd';
                                });
                                
                                // 현재 클릭한 패키지 선택
                                this.classList.add('selected');
                                this.style.border = '2px solid #f5b800';
                                
                                // 선택한 패키지 정보를 hidden input에 저장
                                var pkgName = this.getAttribute('data-name');
                                var pkgPrice = this.getAttribute('data-price');
                                var pkgStart = this.getAttribute('data-start');
                                var pkgEnd = this.getAttribute('data-end');
                                
                                document.getElementById('selectedPackage').value = pkgName + ',' + pkgPrice + ',' + pkgStart + ',' + pkgEnd;
                                
                                // 시간 정보도 폼에 저장 (예약하기 버튼 클릭 시 전송되도록)
                                document.getElementById('pkgStartTime').value = pkgStart + ':00';
                                document.getElementById('pkgEndTime').value = pkgEnd + ':00';
                            });
                        }
                        
                        pkgResultsElement.appendChild(pkgDiv);
                    }
                }
            } else {
                console.warn("패키지 정보가 비어있습니다:", pkgname, pkgprice, pkgstart, pkgend);
            }
        };
        
        chk.open("get", "getReservTime?ymd=" + selectedDate + "&rcode=${rdto.rcode}");
        chk.send();
    }

    // Flatpickr 설정 (공통)
    const flatpickrConfig = {
        inline: true,
        enableTime: false,
        dateFormat: "Y-m-d",
        minDate: "today"
    };

    // 시간 단위 예약용 Flatpickr
    flatpickr("#calendar", {
        ...flatpickrConfig,
        onChange: function (selectedDates, dateStr) {
            if (dateStr) {
                selectedDateStr = dateStr;
                document.getElementById('selectedDate').value = dateStr;
                renderTimeSlots(dateStr);

                var chk = new XMLHttpRequest();
                chk.onload = function() {
                    var reservationData = JSON.parse(chk.responseText);
                    var timeblocks = document.getElementsByClassName("time-block");
                    
                    // 일반예약
                    if (reservationData.timeReservations) {
                        for(var dto of reservationData.timeReservations) {
                            var start = parseInt(dto.startTime);
                            var end = parseInt(dto.endTime);
                            
                            for (let i = start; i < end; i++) {
                                if (timeblocks[i]) {
                                    timeblocks[i].classList.add("disabled");
                                    timeblocks[i].style.pointerEvents = "none";
                                }
                            }
                        }
                    }
                    
                    // 패키지예약
                    if(reservationData.packageReservations) {
                        for(var pkg of reservationData.packageReservations) {
                            var pkgStart = parseInt(pkg.startTime);
                            var pkgEnd = parseInt(pkg.endTime);
                            
                            for(var i = pkgStart; i < pkgEnd; i++) {
                                if(timeblocks[i]) {
                                    timeblocks[i].classList.add("disabled");
                                    timeblocks[i].style.pointerEvents = "none";
                                }
                            }
                        }
                    }
                };
                chk.open("get", "getReservTime?ymd=" + dateStr + "&rcode=${rdto.rcode}");
                chk.send();
            }
        }
    });

    // 패키지 단위 예약용 Flatpickr
    flatpickr("#pkgCalendar", {
        ...flatpickrConfig,
        onChange: function(selectedDates, dateStr) {
            if(dateStr) {
                // 패키지 예약 폼의 selectedDate 값 설정
                document.getElementById('pkgSelectedDate').value = dateStr;
                renderPackageInfo(dateStr);
            }
        }
    });

    // 예약 방식 선택 이벤트
    timeDurationCheckbox.addEventListener('change', () => {
        if (timeDurationCheckbox.checked) {
            pkgDurationCheckbox.checked = false;
            timeDiv.style.display = 'block';
            pkgTimeDiv.style.display = 'none';
        } else {
            timeDiv.style.display = 'none';
        }
    });

    pkgDurationCheckbox.addEventListener('change', () => {
        if (pkgDurationCheckbox.checked) {
            timeDurationCheckbox.checked = false;
            timeDiv.style.display = 'none';
            pkgTimeDiv.style.display = 'block';
        } else {
            pkgTimeDiv.style.display = 'none';
        }
    });
});
	</script>
</head>
<body>

<div id="cContainer_top">
	<div class="ctitle">
		<div>${rdto.name}</div>
		<div>${rdto.subname}</div>
		<div>${rdto.keyword}</div>
	</div>
</div>

<div class="cContainer">
  <div class="cContent_wrapper"> <!-- 왼쪽 메인 div -->
<button id="prevBtn" disabled>이전</button>
<button id="nextBtn">다음</button>


  	<div id="cImgMain">
  	 <div class="cImgAll">
  	 <c:forEach var="ccimg" items="${fn:split(rdto.subpic, '/')}">
  	  <img class="cImg" src="../static/room/${ccimg}">
  	  </c:forEach>
  	 </div>
  	</div>
  
  <div>${rdto.subname}</div>
  <!-- 바(아직안만듬) -->
  
  <div> 공간소개 </div>
  <div><pre style="white-space: pre-wrap;">${rdto.description}</pre></div>
  <div><span>영업시간 ${rdto.officehour}</span>|<span>휴무일 ${rdto.closedday}</span></div>
  <div class="topinfodiv">
  
   <!-- topinfo -->
   <div class="topinfo"><img src="../static/facility/floor.png"><p>${rdto.floor}</div>
   <div class="topinfo"><img src="../static/facility/parking.png"><p><c:if test="${rdto.car==0}">주차 불가</c:if><c:if test="${rdto.car==1}">주차 가능</c:if></div>
   <div class="topinfo"><img src="../static/facility/elevator.png"><p><c:if test="${rdto.elevator==0}">엘레베이터 없음</c:if><c:if test="${rdto.elevator==1}">엘레베이터 있음</c:if></div>
  
  </div>
  
  <!-- 유의사항 -->
  <div>예약시 유의사항</div>
  <div><pre style="white-space: pre-wrap;">${rdto.caution}</pre></div>
  <!-- 유의사항 끝 -->
  
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
  
  <!-- 가게정보 --> 
  <div>${rdto.name}</div>
  <div>${rdto.roadadress}</div>
  
  
  <!-- 네이버지도 api -->
  <div id="map" style="width:100%;height:620px;"></div>
		<script>
		var mapOptions = {
		    center: new naver.maps.LatLng(${rdto.mapy}, ${rdto.mapx}),
		    zoom: 10
		};
		
		var map = new naver.maps.Map('map', mapOptions);
		</script>
	  
  
  
  
  
  
  

  
  </div><!-- 왼쪽 메인 div 끝 -->
  <aside class="cAside_menu"> <!-- 오른쪽 div -->
	<div>세부공간 선택</div>
	<div>결제 후 바로 예약확정</div>
	<div>빠르고 확실한 예약을 위해 온라인 결제를 진행하세요!</div>
	<div>
		<input type="checkbox" checked onclick="return false">${rdto.name} &#8361;
		
		
		<c:choose>
		<c:when test="${roomInfo.halinprice>=0}">
		<fmt:formatNumber value="${roomInfo.halinprice}" type="number" pattern="#,###"/>
		</c:when>
		<c:otherwise>
		
		<c:set var="priceArray" value="${fn:split(roomInfo.pkgprice, ',')}" />
		<c:set var="maxPrice" value="0" />
		
		<c:forEach var="price" items="${priceArray}">
		 <c:if test="${not empty price and price != ''}">
		 <c:set var="currentPrice" value="${price}" />
		 
		 <c:if test="${currentPrice > maxPrice}">
		 <c:set var="maxPrice" value="${currentPrice}" />
		</c:if>
		</c:if>
		</c:forEach>
		
		<fmt:formatNumber value="${maxPrice}" type="number" pattern="#,###"/>원
		</c:otherwise>
		</c:choose>
		
	</div>
	
	
	
	
	<div><img style="width:100%; height:50%;" src="../static/room/${rdto.pic}"></div>
	<div><pre style="white-space: pre-wrap; font-size: 15px">${rdto.subdesc}</pre></div>
	
	<div>
	<ul>
		<hr width="90%">
		<li><span>예약시간</span><span>최소 1시간 부터</span></li>
		<hr width="90%">
		<li><span>수용인원</span><span>${rdto.capacity}명</span></li>
		<hr width="90%">	
	</ul>
	</div>
	
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
	<div class="fimg">예약 선택</div>
	<hr width="90%">
	<div class="fimg">
	<ul class="durationchk">
	<c:if test="${rdto.duration_type==0 or rdto.duration_type==2}">
	<li><input type="checkbox" id="timeduration" name="duration">시간 단위로 예약하기</li>
	</c:if>
	<c:if test="${rdto.duration_type==1 or rdto.duration_type==2}">
	<li><input type="checkbox" id="pkgduration" name="duration">패키지 단위로 예약하기</li>
	</c:if>
	</ul>
<div id="timeDiv" style="display: none;">
    <div id="calendar"></div>
    <div id="timeContainer" class="time-container"></div>
	<form action="roomReserv" method="get">
		<input type="hidden" id="selectedDate" name="selectedDate">
	    <input type="hidden" id="startTime" name="startTime">
	    <input type="hidden" id="endTime" name="endTime">
	    <input type="hidden" name="rcode" value="${rdto.rcode}">
	    <button type="submit">예약하기</button>
	</form>
    
</div>
	
<div id="pkgtimeDiv" style="display: none;">
    <div id="pkgCalendar"></div>
    <div id="packageResults">
        <!-- 패키지 정보가 여기에 표시됩니다 -->
    </div>
    <form action="roomReserv" method="get">
        <input type="hidden" id="pkgSelectedDate" name="selectedDate">
        <input type="hidden" id="pkgStartTime" name="startTime">
        <input type="hidden" id="pkgEndTime" name="endTime">
        <input type="hidden" id="selectedPackage" name="selectedPackage">
        <input type="hidden" name="rcode" value="${rdto.rcode}">
        <button type="submit">예약하기</button>
    </form>
</div>

	
	
	</div>
	
	
	</div>
		
  </aside>
  
</div>

</body>
</html>