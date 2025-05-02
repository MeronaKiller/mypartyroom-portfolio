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
  #cContainer_top {
    width: 1100px;
    height: 300px;
    margin: 30px auto;
  }
  
  .cContainer {
    width: 1100px;
    margin: 0 auto 50px;
    overflow: hidden;
    display: flex;
    gap: 20px; /* 두 요소 사이의 간격 */
}

/* float 속성 제거 */
.cContent_wrapper {
    width: 70%;
    padding: 25px;
    box-sizing: border-box;
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    background-color: white;
    /* float: left; 제거 */
    margin-bottom: 20px;
}

.cAside_menu {
    width: 27%;
    padding: 20px;
    box-sizing: border-box;
    /* float: right; 제거 */
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
    background-color: white;
    position: sticky;
    top: 130px;
}
  
  /* 메인 이미지 */
  #cImgMain {
    width: 100%;
    height: 480px;
    margin: 0 auto 30px;
    overflow: hidden;
    position: relative;
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
  }
  
  .cImgAll .cImg {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .cImg {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: none;
  }
  
  .cImg:first-child {
    display: block;
  }
  
  /* 타이틀 스타일 */
  .ctitle {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 300px;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 20px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  }
  
  .ctitle1 {
    text-align: center;
    font-size: 30px;
    margin-bottom: 10px;
    font-weight: bold;
    font-family: 'LINESeedKR-Bold', sans-serif;
  }
  
  .ctitle2 {
    text-align: center;
    font-size: 20px;
    color: #5A5A5A;
    margin-bottom: 10px;
  }
  
  .ctitle3 {
    text-align: center;
    font-size: 20px;
    color: black;
    background-color: #FAFAFA;
    border-radius: 5px;
    padding: 5px 15px;
  }
  
  /* 섹션 구분 */
  .section-title {
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 22px;
    border-bottom: 2px solid #DDD;
    padding-bottom: 10px;
    margin: 30px 0 15px;
    color: #333;
  }
  
  /* 상단 정보 영역 */
  .topinfodiv {
    display: flex;
    gap: 20px;
    padding: 15px 0;
    border-bottom: 1px solid #eee;
    margin-bottom: 20px;
  }
  
  .topinfo {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .topinfo img {
    width: 40px;
    height: 40px;
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
    width: 23%;
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
    font-size: 14px;
    text-align: center;
  }
  
  /* 예약 선택 스타일 */
  .durationchk {
    list-style: none;
    padding: 0;
  }
  
  .durationchk li {
    margin-bottom: 10px;
    display: flex;
    align-items: center;
  }
  
  .durationchk input[type="checkbox"] {
    margin-right: 10px;
  }
  
  /* 날짜 및 시간 스타일 */
  .time-container {
    display: flex;
    gap: 10px;
    padding: 15px;
    border: 1px solid #eee;
    border-radius: 8px;
    user-select: none;
    flex-wrap: wrap;
    margin: 20px 0;
  }
  
  .time-block {
    min-width: 60px;
    height: 50px;
    background-color: #3A3A3A;
    color: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 5px;
    cursor: pointer;
    flex-shrink: 0;
    transition: all 0.2s ease;
  }
  
  .time-block.selected {
  background-color: #DDD;
  color: #000;
  border-color: #DDD;
  transform: scale(1.05);
  }
  
  .time-block.disabled {
  background-color: #f1f1f1;
  color: #999;
  cursor: not-allowed;
  border-color: #ddd;
  }
  
  /* 패키지 스타일 */
  .pkgConCss {
    border: 1px solid #ddd;
    border-radius: 5px;
    margin: 10px 0;
    padding: 15px;
    cursor: pointer;
    transition: all 0.3s;
  }
  
  .pkgConCss:hover:not(.disabled) {
    border-color: #DDD;
    background-color: #fffdf5;
    transform: translateY(-2px);
  }
  
  .pkgConCss.selected {
    border: 2px solid #DDD;
    background-color: yellow;
  }
  
  .pkgConCss.disabled {
    background-color: #f5f5f5;
    color: #888;
    cursor: not-allowed;
  }
  
  /* 버튼 스타일 */
  button {
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
  
  button:hover {
    background-color: #DDD;
    color: #333;
  }
  
  button:disabled {
    background-color: #ddd;
    cursor: not-allowed;
  }
  
  /* 이미지 네비게이션 버튼 */
  #prevBtn, #nextBtn {
    padding: 8px 15px;
    margin-right: 10px;
    margin-bottom: 10px;
  }
  
  /* 설명 텍스트 */
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
  
  /* 환불 정책 리스트 */
  .refund-list {
    list-style: none;
    padding: 0;
  }
  
  .refund-list li {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
  }
  
  /* 지도 컨테이너 */
  #map {
    width: 100%;
    height: 450px;
    margin: 30px 0;
    border-radius: 10px;
    overflow: hidden;
  }
  
  /* 사이드바 스타일 */
  .side-section {
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
  }
  
  .side-title {
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 18px;
    margin: 0 0 10px;
  }
  
  .side-subtitle {
    font-size: 14px;
    color: #666;
    margin-bottom: 15px;
  }
  
  .side-image {
    width: 100%;
    height: auto;
    border-radius: 8px;
    margin-bottom: 15px;
  }
  
  .side-info-list {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  
  .side-info-item {
    display: flex;
    justify-content: space-between;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
  }
  
  .reservation-button {
    width: 100%;
    padding: 12px;
    background-color: #DDD;
    color: #333;
    font-weight: bold;
    margin-top: 20px;
  }
  
  .warning-text {
    color: #e74c3c;
    font-size: 14px;
    margin: 15px 0;
  }
  
/* 날짜 선택 캘린더 스타일 수정 */
	.flatpickr-calendar {
	  width: 100% !important;
	  max-width: 320px !important; /* 280px에서 320px로 증가 */
	  font-size: 14px !important;
	  margin: 0 auto !important;
	  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
	  border-radius: 8px !important;
	}

.flatpickr-day {
  height: 32px !important;
  line-height: 32px !important;
  margin: 2px !important;
}

	.flatpickr-month {
	  height: 50px !important; /* 40px에서 50px로 증가 */
	  padding: 5px 0 !important;
	}
	
	.flatpickr-current-month {
	  padding: 0 10px !important;
	  width: auto !important;
	}

/* 시간 선택 블록 스타일 수정 */
.time-container {
  display: flex;
  gap: 6px;
  padding: 12px;
  border: 1px solid #eee;
  border-radius: 8px;
  user-select: none;
  flex-wrap: wrap;
  margin: 15px 0;
  max-height: 200px;
  overflow-y: auto;
}

.time-block {
  min-width: 55px;
  height: 40px;
  background-color: white;
  color: #333;
  border: 1px solid #ccc;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 5px;
  cursor: pointer;
  flex-shrink: 0;
  transition: all 0.2s ease;
  font-size: 13px;
  margin-bottom: 5px;
}

.time-block:hover:not(.disabled) {
  border-color: #3A3A3A;
  background-color: #f8f4ff;
}
/* 캘린더 컨테이너가 부모 div를 벗어나지 않도록 설정 */
#calendar, #pkgCalendar {
  width: 100%;
  max-width: 280px;
  margin: 0 auto;
}

/* 패키지 아이템 스타일 개선 */
.pkgConCss {
  padding: 12px;
  margin-bottom: 8px;
  font-size: 14px;
}
  
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
//이미지 슬라이드 기능 추가
document.addEventListener("DOMContentLoaded", function () {
    const images = document.querySelectorAll('.cImg');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    let currentIndex = 0;
    const imageCount = images.length;

    // 초기 버튼 상태 설정
    updateButtonStates();

    // 다음 버튼 클릭 이벤트
    nextBtn.addEventListener('click', function() {
        if (currentIndex < imageCount - 1) {
            images[currentIndex].style.display = 'none';
            currentIndex++;
            images[currentIndex].style.display = 'block';
            updateButtonStates();
        }
    });

    // 이전 버튼 클릭 이벤트
    prevBtn.addEventListener('click', function() {
        if (currentIndex > 0) {
            images[currentIndex].style.display = 'none';
            currentIndex--;
            images[currentIndex].style.display = 'block';
            updateButtonStates();
        }
    });

    // 버튼 상태 업데이트 함수
    function updateButtonStates() {
        prevBtn.disabled = currentIndex === 0;
        nextBtn.disabled = currentIndex === imageCount - 1;
    }
});

// 기존 DOMContentLoaded 이벤트에 영향을 주지 않기 위해 별도로 처리


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
                        start: parseInt(dto.startTime.split(':')[0]), // 시간 부분만 추출하여 숫자로 변환
                        end: parseInt(dto.endTime.split(':')[0])
                    });
                }
            }
            
            if(reservationData.packageReservations) {
                for(var pkg of reservationData.packageReservations) {
                    reservedTimes.push({
                        start: parseInt(pkg.startTime.split(':')[0]), // 시간 부분만 추출하여 숫자로 변환
                        end: parseInt(pkg.endTime.split(':')[0])
                    });
                }
            }
            
            // 디버깅용 로그 추가
            console.log("예약된 시간:", reservedTimes);
            
            // 패키지 정보 불러오기
            var pkgname = '${rdto.pkgname}';
            var pkgprice = '${rdto.pkgprice}';
            var pkgstart = '${rdto.pkgstart}';
            var pkgend = '${rdto.pkgend}';
            
            console.log("패키지 정보:", pkgname, pkgprice, pkgstart, pkgend);
            
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
                        
                        // 예약된 시간과 겹치는지 확인 (수정된 로직)
                        for(var j = 0; j < reservedTimes.length; j++) {
                            var reserved = reservedTimes[j];
                            // 겹치는 경우 확인: 하나의 시작이 다른 하나의 끝보다 앞에 있고, 하나의 끝이 다른 하나의 시작보다 뒤에 있으면 겹침
                            if((item.start < reserved.end) && (item.end > reserved.start)) {
                                console.log("패키지 겹침 발견:", item.name, item.start, item.end, "예약:", reserved.start, reserved.end);
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
                                this.style.border = '2px solid #DDD';
                                
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

 // Flatpickr 날짜 선택 이벤트
    flatpickr("#calendar", {
        ...flatpickrConfig,
        onChange: function (selectedDates, dateStr) {
            if (dateStr) {
                selectedDateStr = dateStr;
                document.getElementById('selectedDate').value = dateStr;
                
                // 먼저 시간 블록 렌더링
                renderTimeSlots(dateStr);
                
                // 그 다음 AJAX로 예약 정보 가져와서 비활성화 처리
                fetchReservations(dateStr);
            }
        }
    });

    // 예약 정보를 가져오는 함수
    function fetchReservations(dateStr) {
    var chk = new XMLHttpRequest();
    chk.onload = function() {
        if (chk.status === 200 && chk.responseText) {
            try {
                console.log("원본 응답:", chk.responseText); // 원본 데이터 확인
                var reservationData = JSON.parse(chk.responseText);
                console.log("파싱된 예약 데이터:", reservationData);
                console.log("시간 예약:", reservationData.timeReservations);
                
                if (reservationData.timeReservations && reservationData.timeReservations.length > 0) {
                    console.log("첫 번째 예약 시간:", reservationData.timeReservations[0].startTime, "~", reservationData.timeReservations[0].endTime);
                }
                
                // 예약된 시간대 비활성화 처리
                disableReservedTimeSlots(reservationData);
            } catch (e) {
                console.error("예약 데이터 처리 오류:", e);
            }
        }
    };
    chk.open("get", "getReservTime?ymd=" + dateStr + "&rcode=${rdto.rcode}");
    chk.send();
}

    function disableReservedTimeSlots(reservations) {
        console.log("비활성화 함수 실행됨");

        reservations.forEach(function(reservation, index) {
            let startTime = reservation.startTime;
            let endTime = reservation.endTime;

            let startHour = parseInt(startTime.toString().split(':')[0], 10);
            let endHour = parseInt(endTime.toString().split(':')[0], 10);

            console.log(`예약 ${index + 1}: ${startHour}시 ~ ${endHour}시`);

            document.querySelectorAll('.time-block').forEach(function(block) {
                let blockTime = block.getAttribute('data-time');
                let blockHour = parseInt(blockTime.split(':')[0], 10);

                if (blockHour >= startHour && blockHour < endHour) {
                    console.log("비활성화 대상 시간 블록:", blockHour);

                    block.classList.add('disabled');
                    block.style.backgroundColor = "#ddd";
                    block.style.color = "#aaa";
                    block.style.cursor = "not-allowed";
                }
            });
        });
    }



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
		<div class="ctitle1">${rdto.name}</div>
		<div class="ctitle2">${rdto.subname}</div>
		<div class="ctitle3">${rdto.keyword}</div>
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
  <div id="map" style="width:100%;height:620px;border-radius:15px;box-shadow:0 4px 8px rgba(0,0,0,0.1);"></div>
		<script>
		var mapOptions = {
		    center: new naver.maps.LatLng(${rdto.mapy}, ${rdto.mapx}),
		    zoom: 15,
		    zoomControl: true,
		    zoomControlOptions: {
		        position: naver.maps.Position.TOP_RIGHT
		    }
		};
		var map = new naver.maps.Map('map', mapOptions);
		
		// 마커 생성
		var markerPosition = new naver.maps.LatLng(${rdto.mapy}, ${rdto.mapx});
		var marker = new naver.maps.Marker({
		    position: markerPosition,
		    map: map,
		    icon: {
		        content: '<div style="background-color:#3A3A3A;width:20px;height:20px;border-radius:50%;border:3px solid white;box-shadow:0 2px 5px rgba(0,0,0,0.3);"></div>',
		        anchor: new naver.maps.Point(12, 12)
		    },
		    animation: naver.maps.Animation.DROP
		});
		
		// 정보창 생성
		var contentString = [
		    '<div style="padding:15px;min-width:200px;font-family:\'LINESeedKR-Light\', sans-serif;line-height:1.5;">',
		    '   <h4 style="margin:0 0 10px;color:#3A3A3A;font-family:\'LINESeedKR-Bold\', sans-serif;">${rdto.name}</h4>',
		    '   <p style="margin:5px 0;color:#333;">${rdto.subname}</p>',
		    '   <p style="margin:5px 0;color:#666;font-size:13px;">${rdto.roadadress}</p>',
		    '   <div style="margin-top:10px;padding-top:10px;border-top:1px solid #eee;display:flex;justify-content:space-between">',
		    '       <span style="color:#5A5A5A;font-size:12px;">영업시간: ${rdto.officehour}</span>',
		    '       <a href="https://map.naver.com/p/directions/-/${rdto.mapx},${rdto.mapy}" target="_blank" style="color:#3A3A3A;font-size:12px;text-decoration:none;">길찾기</a>',
		    '   </div>',
		    '</div>'
		].join('');
		
		var infowindow = new naver.maps.InfoWindow({
		    content: contentString,
		    maxWidth: 300,
		    backgroundColor: "white",
		    borderColor: "#DDD",
		    borderWidth: 2,
		    anchorSize: new naver.maps.Size(20, 20),
		    anchorSkew: true,
		    anchorColor: "white",
		    pixelOffset: new naver.maps.Point(0, -10)
		});
		
		// 마커 클릭 시 정보창 열기
		naver.maps.Event.addListener(marker, "click", function() {
		    if (infowindow.getMap()) {
		        infowindow.close();
		    } else {
		        infowindow.open(map, marker);
		    }
		});
		
		// 지도 로드 시 자동으로 정보창 열기
		infowindow.open(map, marker);
		
		// 지도 스타일 커스터마이징
		var mapStyles = [
		    {
		        featureType: 'poi',
		        elementType: 'labels.icon',
		        stylers: [
		            { visibility: 'on' }
		        ]
		    },
		    {
		        featureType: 'transit',
		        elementType: 'labels',
		        stylers: [
		            { visibility: 'on' }
		        ]
		    }
		];
		
		// 주변 정보 표시 (교통, 음식점 등)
		naver.maps.Event.once(map, 'init', function() {
		    map.setOptions('mapTypeControl', true);
		});
		
		// 지도 기능 추가
		var locationBtnHtml = '<div style="position:absolute;bottom:15px;right:15px;z-index:100;background:#fff;padding:8px;border-radius:5px;box-shadow:0 2px 5px rgba(0,0,0,0.2);cursor:pointer;display:flex;align-items:center;justify-content:center;width:32px;height:32px;"><img src="https://cdn-icons-png.flaticon.com/512/25/25694.png" style="width:18px;height:18px;"></div>';
		var customControl = new naver.maps.CustomControl(locationBtnHtml);
		
		customControl.setMap(map);
		naver.maps.Event.addDOMListener(customControl.getElement(), 'click', function() {
		    map.setCenter(markerPosition);
		    map.setZoom(15);
		});
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