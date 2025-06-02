<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 처리중</title>
</head>
<body>
<section>
<div class="status-container">
    <!-- 처리중 상태 -->
    <div id="processing-state">
        <div class="status-icon">
            <div class="spinner"></div>
        </div>
        
        <h1 class="status-title">예약 처리중입니다<span class="loading-dots"></span></h1>
        <p class="status-message">
            <span style="color: #3A3A3A; font-family: 'LINESeedKR-Bold', sans-serif;">마이<span style="color: #FF5A5F;">파티</span>룸</span>에서 고객님의 예약 요청을 안전하게 처리하고 있습니다.<br>
            잠시만 기다려 주세요.
        </p>

        <div class="progress-bar">
            <div class="progress-fill"></div>
        </div>

        <div class="status-steps">
            <div class="step completed">
                <div class="step-circle">✓</div>
                <div class="step-label">요청접수</div>
                <div class="step-line"></div>
            </div>
            <div class="step active">
                <div class="step-circle">2</div>
                <div class="step-label">예약처리</div>
                <div class="step-line"></div>
            </div>
            <div class="step">
                <div class="step-circle">3</div>
                <div class="step-label">확인중</div>
                <div class="step-line"></div>
            </div>
            <div class="step">
                <div class="step-circle">4</div>
                <div class="step-label">완료</div>
            </div>
        </div>

        <div class="reservation-info">
            <div class="info-row">
                <span class="info-label">예약 공간:</span>
                <span class="info-value">${not empty roomName ? roomName : ''}</span>
            </div>
            <div class="info-row">
                <span class="info-label">예약 일시:</span>
                <span class="info-value">${reservationDate} ${startTime}시~${endTime}시</span>
            </div>
            <div class="info-row">
                <span class="info-label">예약자:</span>
                <span class="info-value">${not empty userName ? userName : ''}</span>
            </div>
        </div>

        <div class="queue-info">
            <div class="queue-stats">
                <div class="queue-stat">
                    <span class="queue-number" id="queuePosition">조회중</span>
                    <span class="queue-label">대기순번</span>
                </div>
                <div class="queue-stat">
                    <span class="estimated-time" id="estimatedTime">조회중</span>
                    <span class="queue-label">예상시간</span>
                </div>
            </div>
            
            <div id="queueWarning" class="queue-warning" style="display: none;">
                현재 많은 예약 요청이 몰려 처리 시간이 지연될 수 있습니다.
            </div>
            
            <div class="real-time-status">
                마지막 업데이트: <span id="lastUpdate">-</span>
            </div>
        </div>

        <div class="uuid-display">
            <strong>처리 번호:</strong> <span id="reservationUuid">${reservationUuid}</span>
        </div>
    </div>

    <!-- 성공 상태 -->
    <div id="success-state" class="success-state">
        <div class="success-icon">✅</div>
        <h1 class="status-title">예약이 완료되었습니다!</h1>
        <p class="status-message">
            예약 확인서가 등록하신 이메일로 발송되었습니다.<br>
            감사합니다.
        </p>
        <button class="btn-continue" onclick="goToReservationList()">예약 내역 보기</button>
    </div>

    <!-- 오류 상태 -->
    <div id="error-state" class="error-state">
        <div class="error-icon">❌</div>
        <h1 class="status-title">예약 처리 중 오류가 발생했습니다</h1>
        <p class="status-message" id="errorMessage">
            시간 중복 또는 시스템 오류로 인해 예약이 실패했습니다.<br>
            다시 시도해 주세요.
        </p>
        <button class="btn-retry" onclick="retryReservation()">다시 시도</button>
        <button class="btn-continue" onclick="goHome()">홈으로 돌아가기</button>
    </div>

    <div class="status-footer">
        문의사항이 있으시면 고객센터(1234-5678)로 연락주세요.
    </div>
</div>
</section>

<style>
    .status-container {
        background: white;
        border-radius: 20px;
        padding: 40px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        text-align: center;
        max-width: 600px;
        width: 90%;
        animation: slideUp 0.6s ease-out;
        margin: 20px auto;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .status-icon {
        width: 80px;
        height: 80px;
        margin: 0 auto 20px;
        position: relative;
    }

    .spinner {
        width: 80px;
        height: 80px;
        border: 4px solid #f3f3f3;
        border-top: 4px solid #3A3A3A;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    .status-title {
        font-family: 'LINESeedKR-Bold', sans-serif;
        font-size: 28px;
        color: #333;
        margin-bottom: 15px;
    }

    .status-message {
        font-size: 16px;
        color: #666;
        line-height: 1.6;
        margin-bottom: 30px;
    }

    .progress-bar {
        width: 100%;
        height: 8px;
        background-color: #f0f0f0;
        border-radius: 4px;
        overflow: hidden;
        margin-bottom: 20px;
    }

    .progress-fill {
        height: 100%;
        background: linear-gradient(90deg, #3A3A3A, #555555);
        border-radius: 4px;
        animation: progress 3s ease-in-out infinite;
        width: 0%;
    }

    @keyframes progress {
        0% { width: 0%; }
        50% { width: 70%; }
        100% { width: 100%; }
    }

    .status-steps {
        display: flex;
        justify-content: space-between;
        margin: 30px 0;
        position: relative;
    }

    .step {
        flex: 1;
        text-align: center;
        position: relative;
    }

    .step-circle {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        background-color: #ddd;
        margin: 0 auto 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .step.active .step-circle {
        background-color: #3A3A3A;
        animation: pulse 1.5s ease-in-out infinite;
    }

    .step.completed .step-circle {
        background-color: #4CAF50;
    }

    @keyframes pulse {
        0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(58, 58, 58, 0.4); }
        50% { transform: scale(1.1); box-shadow: 0 0 0 10px rgba(58, 58, 58, 0); }
        100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(58, 58, 58, 0); }
    }

    .step-label {
        font-size: 12px;
        color: #666;
    }

    .step-line {
        position: absolute;
        top: 15px;
        left: 60%;
        right: -40%;
        height: 2px;
        background-color: #ddd;
        z-index: -1;
    }

    .step:last-child .step-line {
        display: none;
    }

    .step.completed .step-line {
        background-color: #4CAF50;
    }

    .reservation-info {
        background-color: #f8f9fa;
        border-radius: 10px;
        padding: 20px;
        margin: 20px 0;
        text-align: left;
    }

    .info-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
        align-items: center;
    }

    .info-label {
        font-family: 'LINESeedKR-Bold', sans-serif;
        color: #333;
        min-width: 100px;
    }

    .info-value {
        color: #666;
        text-align: right;
    }

    .uuid-display {
        background-color: #f0f0f0;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        font-family: monospace;
        font-size: 14px;
        color: #666;
        border-left: 4px solid #3A3A3A;
    }

    .queue-info {
        background: linear-gradient(135deg, #3A3A3A20, #55555520);
        border-radius: 10px;
        padding: 20px;
        margin: 20px 0;
        border: 1px solid #3A3A3A30;
    }

    .queue-stats {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
        margin-bottom: 15px;
    }

    .queue-stat {
        text-align: center;
        padding: 10px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .queue-number {
        font-family: 'LINESeedKR-Bold', sans-serif;
        color: #3A3A3A;
        font-size: 20px;
        display: block;
        margin-bottom: 5px;
        word-break: break-all;
    }

    .queue-label {
        font-size: 12px;
        color: #666;
    }

    .estimated-time {
        font-family: 'LINESeedKR-Bold', sans-serif;
        color: #3A3A3A;
        font-size: 18px;
        display: block;
        margin-bottom: 5px;
    }

    .queue-warning {
        background: #fff3cd;
        border: 1px solid #ffeaa7;
        border-radius: 8px;
        padding: 10px;
        margin: 15px 0;
        font-size: 14px;
        color: #856404;
    }

    .queue-warning.high-load {
        background: #f8d7da;
        border-color: #f5c6cb;
        color: #721c24;
    }

    .status-footer {
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #eee;
        font-size: 14px;
        color: #999;
    }

    .error-state, .success-state {
        display: none;
    }

    .error-state.show, .success-state.show {
        display: block;
    }

    .error-icon {
        color: #ff4757;
        font-size: 60px;
        margin-bottom: 20px;
    }

    .success-icon {
        color: #4CAF50;
        font-size: 60px;
        margin-bottom: 20px;
    }

    .btn-retry, .btn-continue {
        background: #3A3A3A;
        color: white;
        border: none;
        padding: 12px 30px;
        border-radius: 25px;
        font-family: 'LINESeedKR-Bold', sans-serif;
        font-size: 16px;
        cursor: pointer;
        margin: 10px;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }

    .btn-retry:hover, .btn-continue:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        background: #555555;
    }

    .loading-dots {
        display: inline-block;
        animation: dots 1.5s infinite;
    }

    @keyframes dots {
        0%, 20% { content: ''; }
        40% { content: '.'; }
        60% { content: '..'; }
        80%, 100% { content: '...'; }
    }

    .real-time-status {
        font-size: 12px;
        color: #999;
        margin-top: 10px;
        font-style: italic;
    }
</style>

<script>
let reservationUuid = '${reservationUuid}';
let pollCount = 0;
let maxPollCount = 180; // 최대 6분간 폴링
let currentStep = 1;
let lastQueuePosition = -1;
let initialQueuePosition = -1;

// 페이지 로드 시 상태 체크 시작
window.onload = function() {
    console.log('페이지 로드됨. reservationUuid:', reservationUuid);
    
    if (!reservationUuid || reservationUuid === '' || reservationUuid === 'null') {
        showError('잘못된 접근입니다. 예약 처리 번호가 없습니다.');
        return;
    }
    
    // 초기 표시 설정
    document.getElementById('queuePosition').textContent = '조회중';
    document.getElementById('estimatedTime').textContent = '조회중';
    
    updateLastUpdateTime();
    pollReservationStatus();
};

function pollReservationStatus() {
    if (pollCount >= maxPollCount) {
        showError('처리 시간이 초과되었습니다. 고객센터로 문의해 주세요.');
        return;
    }

    console.log(`폴링 시도 ${pollCount + 1}/${maxPollCount}, UUID: ${reservationUuid}`);

    fetch('/room/reservationStatusAPI?uuid=' + encodeURIComponent(reservationUuid))
        .then(response => {
            console.log('응답 상태:', response.status, response.ok);
            if (!response.ok) {
                throw new Error('서버 응답 오류: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            console.log('API 응답 데이터:', JSON.stringify(data, null, 2));
            updateUI(data);
            updateLastUpdateTime();
            pollCount++;
            
            if (data.status === 'processing' || data.status === 'queued') {
                let interval = calculatePollingInterval(data.queuePosition);
                console.log(`다음 폴링까지 ${interval}ms 대기`);
                setTimeout(pollReservationStatus, interval);
            } else if (data.status === 'completed') {
                console.log('예약 완료');
                showSuccess();
            } else if (data.status === 'failed') {
                console.log('예약 실패:', data.message);
                showError(data.message || '예약 처리에 실패했습니다.');
            } else {
                console.log('알 수 없는 상태:', data.status);
                // 알 수 없는 상태일 경우 계속 폴링
                setTimeout(pollReservationStatus, 3000);
            }
        })
        .catch(error => {
            console.error('상태 확인 오류:', error);
            pollCount++;
            if (pollCount < maxPollCount) {
                console.log(`오류 발생. ${5000}ms 후 재시도`);
                setTimeout(pollReservationStatus, 5000);
            } else {
                showError('네트워크 오류가 지속적으로 발생했습니다. 새로고침 후 다시 시도해 주세요.');
            }
        });
}

function calculatePollingInterval(queuePosition) {
    // 대기열 위치에 따른 폴링 간격 조정
    if (queuePosition <= 10) return 1000;      // 1초
    else if (queuePosition <= 100) return 2000; // 2초
    else if (queuePosition <= 1000) return 3000; // 3초
    else return 5000; // 5초
}

function updateUI(data) {
    console.log('updateUI 호출됨 - 전체 응답:', JSON.stringify(data, null, 2));
    
    // ✅ 큐 위치 업데이트 - 더 많은 필드명 확인
    console.log('큐 위치 관련 모든 데이터 확인:');
    Object.keys(data).forEach(key => {
        if (key.toLowerCase().includes('queue') || key.toLowerCase().includes('position') || key.toLowerCase().includes('order')) {
            console.log(`- ${key}:`, data[key], '(타입:', typeof data[key], ')');
        }
    });
    
    let queuePosition = data.queuePosition || data.queue_position || data.position || 
                       data.queueOrder || data.order || data.waitingNumber || data.waiting;
    
    if (queuePosition !== undefined && queuePosition !== null && queuePosition !== '') {
        const queueElement = document.getElementById('queuePosition');
        
        console.log('큐 위치 처리 시작 - 원본값:', queuePosition, '타입:', typeof queuePosition);
        
        // 문자열이라면 숫자로 변환 시도
        let numericQueue;
        if (typeof queuePosition === 'string') {
            numericQueue = parseInt(queuePosition.replace(/[^0-9]/g, '')); // 숫자가 아닌 문자 제거
        } else {
            numericQueue = Number(queuePosition);
        }
        
        console.log('변환된 큐 위치:', numericQueue, 'isNaN:', isNaN(numericQueue));
        
        if (isNaN(numericQueue) || numericQueue < 0) {
            queueElement.textContent = '조회중';
            console.log('큐 위치 변환 실패 - 조회중으로 표시');
        } else if (numericQueue === 0) {
            queueElement.textContent = '처리중';
            queueElement.style.fontSize = '18px';
            console.log('처리중 상태');
        } else {
            // ✅ 큰 숫자도 제대로 표시 (콤마 포함)
            let displayValue = numericQueue.toLocaleString('ko-KR');
            queueElement.textContent = displayValue;
            queueElement.style.fontSize = '20px';
            console.log('대기순번 최종 표시:', displayValue, '(원본 숫자:', numericQueue, ')');
            
            // 실제로 큰 수인지 확인
            if (numericQueue > 10000) {
                console.log('🔥 대용량 대기자 감지:', numericQueue.toLocaleString());
            }
        }
        
        // 초기 위치 저장
        if (initialQueuePosition === -1 && !isNaN(numericQueue)) {
            initialQueuePosition = numericQueue;
        }
        
        // 대기열 경고 표시
        if (!isNaN(numericQueue)) {
            updateQueueWarning(numericQueue, data.totalQueue || data.total_queue);
            lastQueuePosition = numericQueue;
        }
    } else {
        console.log('🚨 큐 위치 정보가 응답에 전혀 없음');
        document.getElementById('queuePosition').textContent = '조회중';
    }
    
    // ✅ 예상 시간 업데이트
    console.log('예상 시간 관련 모든 데이터 확인:');
    Object.keys(data).forEach(key => {
        if (key.toLowerCase().includes('time') || key.toLowerCase().includes('wait') || key.toLowerCase().includes('estimated')) {
            console.log(`- ${key}:`, data[key]);
        }
    });
    
    let estimatedTime = data.estimatedTime || data.estimated_time || data.waitTime || 
                       data.estimatedWaitTime || data.processingTime;
    
    if (estimatedTime && estimatedTime !== '' && estimatedTime !== 'null') {
        document.getElementById('estimatedTime').textContent = estimatedTime;
        console.log('서버 제공 예상시간 사용:', estimatedTime);
    } else if (queuePosition !== undefined) {
        updateEstimatedTime(data);
    } else {
        document.getElementById('estimatedTime').textContent = '조회중';
        console.log('예상시간 계산 불가 - 조회중으로 표시');
    }
    
    // ✅ 단계 업데이트
    let currentStep = data.currentStep || data.current_step || data.step || data.phase;
    if (currentStep && currentStep !== currentStep) {
        updateSteps(currentStep);
        currentStep = currentStep;
        console.log('단계 업데이트:', currentStep);
    }
}

function updateEstimatedTime(data) {
    const timeElement = document.getElementById('estimatedTime');
    
    // 서버에서 제공하는 예상시간이 있다면 우선 사용
    let estimatedTime = data.estimatedTime || data.estimated_time || data.waitTime;
    if (estimatedTime && estimatedTime !== '') {
        timeElement.textContent = estimatedTime;
        console.log('서버 제공 예상시간 사용:', estimatedTime);
        return;
    }
    
    // queuePosition을 기반으로 계산
    let queuePos = data.queuePosition || data.queue_position || data.position;
    let numericQueue = Number(queuePos);
    
    console.log('예상시간 계산 - 큐 위치:', numericQueue);
    
    if (isNaN(numericQueue) || numericQueue < 0) {
        timeElement.textContent = '조회중';
        console.log('큐 위치가 유효하지 않음 - 조회중');
        return;
    }
    
    let estimatedSeconds;
    if (numericQueue === 0) {
        estimatedSeconds = 3;
        console.log('현재 처리중 - 3초 예상');
    } else {
        // ✅ 5만건 처리에 12초 기준으로 더 정확한 계산
        // 50,000건 = 12초이므로 1건당 약 0.00024초
        // 하지만 실제로는 배치 처리, 네트워크 지연 등을 고려해야 함
        
        if (numericQueue <= 10) {
            estimatedSeconds = Math.ceil(numericQueue * 0.5); // 작은 수는 0.5초씩
        } else if (numericQueue <= 100) {
            estimatedSeconds = Math.ceil(numericQueue * 0.3); // 0.3초씩
        } else if (numericQueue <= 1000) {
            estimatedSeconds = Math.ceil(numericQueue * 0.1); // 0.1초씩
        } else if (numericQueue <= 10000) {
            estimatedSeconds = Math.ceil(numericQueue * 0.05); // 0.05초씩
        } else if (numericQueue <= 50000) {
            estimatedSeconds = Math.ceil(numericQueue * 0.00024 * 1000); // 실제 처리 시간 기준
        } else {
            estimatedSeconds = Math.ceil(numericQueue * 0.0002 * 1000); // 더 큰 수
        }
        
        // 최소 1초, 최대 10분으로 제한
        estimatedSeconds = Math.max(1, Math.min(estimatedSeconds, 600));
        console.log(`대기순번 ${numericQueue}에 대한 계산된 예상시간: ${estimatedSeconds}초`);
    }
    
    // 시간 포맷팅
    if (estimatedSeconds < 60) {
        timeElement.textContent = estimatedSeconds + '초';
    } else if (estimatedSeconds < 3600) {
        const minutes = Math.ceil(estimatedSeconds / 60);
        timeElement.textContent = minutes + '분';
    } else {
        const hours = Math.floor(estimatedSeconds / 3600);
        const minutes = Math.ceil((estimatedSeconds % 3600) / 60);
        if (minutes === 0) {
            timeElement.textContent = hours + '시간';
        } else {
            timeElement.textContent = hours + '시간 ' + minutes + '분';
        }
    }
    
    console.log('최종 표시 예상시간:', timeElement.textContent);
}

function updateQueueWarning(queuePosition, totalQueue) {
    const warningElement = document.getElementById('queueWarning');
    
    if (queuePosition > 30000) {
        warningElement.className = 'queue-warning high-load';
        warningElement.textContent = `현재 ${queuePosition.toLocaleString('ko-KR')}번째 대기중입니다. 처리 시간이 상당히 지연될 수 있습니다.`;
        warningElement.style.display = 'block';
    } else if (queuePosition > 10000) {
        warningElement.className = 'queue-warning';
        warningElement.textContent = `현재 ${queuePosition.toLocaleString('ko-KR')}번째 대기중입니다. 처리 시간이 지연될 수 있습니다.`;
        warningElement.style.display = 'block';
    } else if (queuePosition > 1000) {
        warningElement.className = 'queue-warning';
        warningElement.textContent = '현재 많은 예약 요청이 몰려 처리 시간이 지연될 수 있습니다.';
        warningElement.style.display = 'block';
    } else {
        warningElement.style.display = 'none';
    }
}

function updateLastUpdateTime() {
    const now = new Date();
    const timeString = now.toLocaleTimeString('ko-KR', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    });
    document.getElementById('lastUpdate').textContent = timeString;
}

function updateSteps(step) {
    const steps = document.querySelectorAll('.step');
    
    steps.forEach((stepEl, index) => {
        const circle = stepEl.querySelector('.step-circle');
        
        if (index < step - 1) {
            stepEl.classList.remove('active');
            stepEl.classList.add('completed');
            circle.textContent = '✓';
        } else if (index === step - 1) {
            stepEl.classList.remove('completed');
            stepEl.classList.add('active');
            circle.textContent = step;
        } else {
            stepEl.classList.remove('active', 'completed');
            circle.textContent = index + 1;
        }
    });
}

function showSuccess() {
    document.getElementById('processing-state').style.display = 'none';
    document.getElementById('success-state').classList.add('show');
}

function showError(message) {
    document.getElementById('processing-state').style.display = 'none';
    document.getElementById('errorMessage').textContent = message;
    document.getElementById('error-state').classList.add('show');
}

function retryReservation() {
    history.back();
}

function goToReservationList() {
    window.location.href = '/room/reservList?jumuncode=${jumuncode}';
}

function goHome() {
    window.location.href = '/';
}

// 페이지 새로고침 방지
window.addEventListener('beforeunload', function(e) {
    if (document.getElementById('processing-state').style.display !== 'none') {
        e.preventDefault();
        e.returnValue = '예약 처리가 진행중입니다. 페이지를 나가시겠습니까?';
    }
});

// 페이지 포커스 시 즉시 상태 확인
window.addEventListener('focus', function() {
    if (document.getElementById('processing-state').style.display !== 'none') {
        pollReservationStatus();
    }
});
</script>
</body>
</html>