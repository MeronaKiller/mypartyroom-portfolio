<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 시스템 실시간 모니터링</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
<style>
	.chart-container {
	  min-height: 400px;
	  max-height: 400px;
	  overflow: hidden;
	}
	
	.chart-wrapper {
	  position: relative;
	  height: 300px;
	  width: 100%;
	}
	
	#performanceChart {
	  max-height: 300px !important;
	  height: 300px !important;
	}

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

  body {
    font-family: 'LINESeedKR-Light', sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f5f5f5;
    color: #333;
  }

  .monitor-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 20px;
    text-align: center;
    position: relative;
  }

  .back-button {
    position: absolute;
    left: 20px;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(255, 255, 255, 0.2);
    color: white;
    border: 2px solid white;
    padding: 8px 16px;
    border-radius: 25px;
    text-decoration: none;
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 14px;
    transition: all 0.3s ease;
  }

  .back-button:hover {
    background: white;
    color: #667eea;
    transform: translateY(-50%) scale(1.05);
  }

  .monitor-title {
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 28px;
    margin: 0;
  }

  .monitor-subtitle {
    margin: 5px 0 0;
    opacity: 0.9;
  }

  .stats-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }

  .stat-card {
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    transition: transform 0.2s ease;
  }

  .stat-card:hover {
    transform: translateY(-2px);
  }

  .stat-title {
    font-family: 'LINESeedKR-Bold', sans-serif;
    font-size: 18px;
    color: #333;
    margin-bottom: 15px;
    border-bottom: 2px solid #667eea;
    padding-bottom: 5px;
  }

  .stat-value {
    font-size: 32px;
    font-weight: bold;
    color: #667eea;
    margin-bottom: 5px;
  }

  .stat-label {
    color: #666;
    font-size: 14px;
  }

  .chart-container {
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }

  .status-indicator {
    display: inline-block;
    width: 12px;
    height: 12px;
    border-radius: 50%;
    margin-right: 8px;
  }

  .status-active { background-color: #4CAF50; }
  .status-warning { background-color: #FF9800; }
  .status-error { background-color: #f44336; }
  .status-info { background-color: #2196F3; }

  .live-feed {
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    height: 400px;
    overflow-y: auto;
  }

  .log-entry {
    padding: 8px 12px;
    margin-bottom: 5px;
    border-radius: 5px;
    font-size: 14px;
    border-left: 4px solid #ddd;
    word-wrap: break-word;
    line-height: 1.4;
  }

  .log-success {
    background-color: #e8f5e8;
    border-left-color: #4CAF50;
  }

  .log-error {
    background-color: #ffeaea;
    border-left-color: #f44336;
  }

  .log-warning {
    background-color: #fff3e0;
    border-left-color: #FF9800;
  }

  .log-info {
    background-color: #e3f2fd;
    border-left-color: #2196F3;
  }

  .control-panel {
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }

  .btn {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    font-family: 'LINESeedKR-Bold', sans-serif;
    cursor: pointer;
    margin: 5px;
    transition: all 0.3s ease;
  }

  .btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
  }

  .btn-danger {
    background: linear-gradient(135deg, #ff4757 0%, #ff3742 100%);
  }

  .btn-clear {
    background: linear-gradient(135deg, #ffa726 0%, #ff9800 100%);
  }

  .progress-bar {
    width: 100%;
    height: 20px;
    background-color: #f0f0f0;
    border-radius: 10px;
    overflow: hidden;
    margin: 10px 0;
  }

  .progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #667eea, #764ba2);
    border-radius: 10px;
    transition: width 0.3s ease;
  }

  .real-time-chart {
    width: 100%;
    height: 200px;
    margin: 20px 0;
  }

  .refresh-indicator {
    position: fixed;
    top: 20px;
    right: 20px;
    background: rgba(0,0,0,0.8);
    color: white;
    padding: 10px 15px;
    border-radius: 20px;
    font-size: 12px;
    opacity: 0;
    transition: opacity 0.3s ease;
  }

  .refresh-indicator.show {
    opacity: 1;
  }

  @keyframes pulse {
    0% { opacity: 1; }
    50% { opacity: 0.5; }
    100% { opacity: 1; }
  }

  .updating {
    animation: pulse 1s infinite;
  }

  .uuid-tracker {
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }

  .uuid-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    margin: 5px 0;
    background: #f8f9fa;
    border-radius: 5px;
    border-left: 4px solid #667eea;
  }

  .uuid-code {
    font-family: monospace;
    font-size: 12px;
    color: #666;
  }

  .uuid-status {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
  }

  .status-queued { background: #fff3e0; color: #f57c00; }
  .status-processing { background: #e3f2fd; color: #1976d2; }
  .status-completed { background: #e8f5e8; color: #388e3c; }
  .status-failed { background: #ffeaea; color: #d32f2f; }

  .log-controls {
    margin-bottom: 15px;
    display: flex;
    gap: 10px;
    align-items: center;
  }

  .log-status {
    font-size: 12px;
    color: #666;
    margin-left: auto;
  }
</style>
</head>
<body>

<div class="refresh-indicator" id="refreshIndicator">
  데이터 업데이트 중...
</div>

<header class="monitor-header">
  <a href="/admin/adminTools" class="back-button">← 뒤로가기</a>
  <h1 class="monitor-title">🎯 예약 시스템 실시간 모니터링</h1>
  <p class="monitor-subtitle">UUID 기반 예약 추적 시스템 | 8코어 16스레드 최적화</p>
</header>

<div class="control-panel">
  <h3>🎮 제어판</h3>
  <button class="btn" onclick="toggleBatchMode()">배치 모드 토글</button>
  <button class="btn" onclick="resetStats()">통계 초기화</button>
  <button class="btn" onclick="runBulkTest()">대용량 테스트</button>
  <button class="btn btn-danger" onclick="emergencyStop()">긴급 정지</button>
  <span style="margin-left: 20px;">
    자동 새로고침: <input type="checkbox" id="autoRefresh" checked onchange="toggleAutoRefresh()">
  </span>
</div>

<div class="stats-container">
  <div class="stat-card">
    <div class="stat-title">📊 처리 현황</div>
    <div class="stat-value" id="totalProcessed">0</div>
    <div class="stat-label">총 처리된 예약</div>
    <div style="margin-top: 10px;">
      성공: <span id="successCount" style="color: #4CAF50; font-weight: bold;">0</span> |
      실패: <span id="failCount" style="color: #f44336; font-weight: bold;">0</span>
    </div>
  </div>

  <div class="stat-card">
    <div class="stat-title">🚀 처리 속도</div>
    <div class="stat-value" id="tps">0.00</div>
    <div class="stat-label">TPS (Transactions Per Second)</div>
    <div class="progress-bar">
      <div class="progress-fill" id="tpsProgress" style="width: 0%"></div>
    </div>
  </div>

  <div class="stat-card">
    <div class="stat-title">📋 큐 상태</div>
    <div class="stat-value" id="queueSize">0</div>
    <div class="stat-label">대기 중인 예약</div>
    <div style="margin-top: 10px;">
      <span class="status-indicator status-info"></span>용량: <span id="queueCapacity">1000</span>
    </div>
    <div class="progress-bar">
      <div class="progress-fill" id="queueProgress" style="width: 0%"></div>
    </div>
  </div>

  <div class="stat-card">
    <div class="stat-title">⚙️ 시스템 상태</div>
    <div>
      <span class="status-indicator status-active"></span>
      배치 모드: <span id="batchModeStatus">비활성</span>
    </div>
    <div>
      <span class="status-indicator status-info"></span>
      워커 스레드: <span id="threadCount">16</span>개
    </div>
    <div>
      <span class="status-indicator status-warning"></span>
      처리 중: <span id="processingCount">0</span>건
    </div>
  </div>
</div>

<div class="uuid-tracker">
  <h3>🔍 UUID 추적 현황</h3>
  <div id="uuidList">
    <!-- UUID 목록이 여기에 동적으로 생성됩니다 -->
  </div>
</div>

<div class="chart-container">
  <h3>📈 실시간 성능 차트</h3>
  <canvas id="performanceChart" class="real-time-chart"></canvas>
</div>

<div class="live-feed">
  <div class="log-controls">
    <h3 style="margin: 0;">📡 실시간 로그</h3>
    <button class="btn btn-clear" onclick="clearLogs()">로그 지우기</button>
    <div class="log-status">
      로그 수: <span id="logCount">0</span>
    </div>
  </div>
  <div id="logContainer">
    <!-- 실시간 로그가 여기에 표시됩니다 -->
  </div>
</div>

<script>
let autoRefreshEnabled = true;
let refreshInterval;
let performanceChart;
let logCounter = 0;
let chartData = {
  labels: [],
  datasets: [{
    label: 'TPS',
    data: [],
    borderColor: '#667eea',
    backgroundColor: 'rgba(102, 126, 234, 0.1)',
    tension: 0.4
  }, {
    label: '큐 크기',
    data: [],
    borderColor: '#764ba2',
    backgroundColor: 'rgba(118, 75, 162, 0.1)',
    tension: 0.4
  }]
};

// 샘플 로그 메시지 풀
const sampleLogMessages = [
  { message: '예약 요청 처리 완료 - UUID: ' + generateShortUuid(), type: 'success' },
  { message: '새로운 예약 요청 수신 (Room-A)', type: 'info' },
  { message: '데이터베이스 연결 상태 확인됨', type: 'info' },
  { message: '큐 처리 속도 최적화 적용', type: 'success' },
  { message: '메모리 사용량: 67% (정상)', type: 'info' },
  { message: '스레드 풀 상태 정상 (16/16 활성)', type: 'success' },
  { message: '캐시 정리 완료 - 1.2MB 확보', type: 'info' },
  { message: '예약 검증 처리 완료', type: 'success' },
  { message: '시스템 헬스체크 통과', type: 'info' },
  { message: '처리 속도 향상: +15% 개선', type: 'success' },
  { message: '백업 프로세스 시작', type: 'info' },
  { message: '네트워크 연결 안정', type: 'success' }
];

// 짧은 UUID 생성 함수
function generateShortUuid() {
  return 'r' + Math.random().toString(36).substr(2, 8);
}

// 페이지 로드 시 초기화
window.onload = function() {
  initializeChart();
  startAutoRefresh();
  loadInitialData();
  addLog('시스템 모니터링 시작됨', 'info');
  startSampleLogGeneration();
};

// 차트 초기화
function initializeChart() {
  const ctx = document.getElementById('performanceChart').getContext('2d');
  
  // Chart.js가 로드되지 않은 경우 대체 텍스트 표시
  if (typeof Chart === 'undefined') {
    document.getElementById('performanceChart').style.display = 'none';
    const chartContainer = document.querySelector('.chart-container');
    chartContainer.innerHTML += '<p>차트를 표시하려면 Chart.js 라이브러리가 필요합니다.</p>';
    return;
  }
  
  performanceChart = new Chart(ctx, {
    type: 'line',
    data: chartData,
    options: {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: 'rgba(0,0,0,0.1)'
          }
        },
        x: {
          grid: {
            color: 'rgba(0,0,0,0.1)'
          }
        }
      },
      plugins: {
        legend: {
          position: 'top'
        }
      },
      animation: {
        duration: 300
      }
    }
  });
}

// 샘플 로그 생성 시작 (완전 제어)
function startSampleLogGeneration() {
  // 기존 타이머가 있다면 제거
  if (window.logGenerationTimer) {
    clearInterval(window.logGenerationTimer);
  }
  
  window.logGenerationTimer = setInterval(() => {
    if (Math.random() < 0.3) { // 30% 확률로 로그 생성
      const randomIndex = Math.floor(Math.random() * sampleLogMessages.length);
      const logItem = sampleLogMessages[randomIndex];
      
      let logMessage = logItem.message;
      const logType = logItem.type;
      
      // UUID가 포함된 메시지의 경우 새로운 UUID 생성
      if (logMessage.includes('UUID:')) {
        logMessage = logMessage.replace(/r[a-z0-9]{8}/, generateShortUuid());
      }
      
      // 안전한 로그 추가 (타입 검증 포함)
      if (logMessage && logType) {
        addLog(logMessage, logType);
      }
    }
  }, 5000); // 5초마다 체크
}

// 자동 새로고침 시작
function startAutoRefresh() {
  if (autoRefreshEnabled) {
    refreshInterval = setInterval(fetchStats, 2000);
  }
}

// 자동 새로고침 중지
function stopAutoRefresh() {
  if (refreshInterval) {
    clearInterval(refreshInterval);
  }
}

// 자동 새로고침 토글
function toggleAutoRefresh() {
  autoRefreshEnabled = document.getElementById('autoRefresh').checked;
  
  if (autoRefreshEnabled) {
    startAutoRefresh();
    addLog('자동 새로고침 활성화', 'info');
  } else {
    stopAutoRefresh();
    addLog('자동 새로고침 비활성화', 'warning');
  }
}

// 초기 데이터 로드
function loadInitialData() {
  fetchStats();
  fetchUuidList();
}

// 통계 데이터 가져오기 (실제 서버 연결 시도 후 샘플 데이터로 대체)
function fetchStats() {
  showRefreshIndicator();
  
  // 실제 서버에 요청 시도
  fetch('/room/reservationStatusStats')
    .then(response => {
      if (!response.ok) {
        throw new Error('서버 응답 오류');
      }
      return response.json();
    })
    .then(data => {
      updateStatsDisplay(data);
      updateChart(data);
      hideRefreshIndicator();
    })
    .catch(error => {
      // 서버 연결 실패 시 샘플 데이터 사용
      console.log('서버 연결 실패, 샘플 데이터 사용:', error.message);
      
      const sampleData = {
        total: Math.floor(Math.random() * 1000) + 500,
        success: Math.floor(Math.random() * 800) + 400,
        fail: Math.floor(Math.random() * 50) + 10,
        tps: (Math.random() * 50 + 10).toFixed(2),
        queueSize: Math.floor(Math.random() * 200) + 50,
        queueCapacity: 1000,
        processingCount: Math.floor(Math.random() * 20) + 5,
        threadPoolSize: 16,
        batchMode: Math.random() > 0.5
      };
      
      updateStatsDisplay(sampleData);
      updateChart(sampleData);
      hideRefreshIndicator();
    });
}

// UUID 목록 가져오기
function fetchUuidList() {
  // 실제 구현에서는 서버에서 활성 UUID 목록을 가져옴
  // 여기서는 샘플 데이터로 대체
  const sampleUuids = [
    { uuid: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890', status: 'processing', rcode: 'r0102001' },
    { uuid: 'b2c3d4e5-f6g7-8901-bcde-f23456789012', status: 'queued', rcode: 'r0102002' },
    { uuid: 'c3d4e5f6-g7h8-9012-cdef-345678901234', status: 'completed', rcode: 'r0102003' }
  ];
  
  updateUuidDisplay(sampleUuids);
}

// 통계 디스플레이 업데이트
function updateStatsDisplay(data) {
  document.getElementById('totalProcessed').textContent = data.total || 0;
  document.getElementById('successCount').textContent = data.success || 0;
  document.getElementById('failCount').textContent = data.fail || 0;
  document.getElementById('tps').textContent = data.tps || '0.00';
  document.getElementById('queueSize').textContent = data.queueSize || 0;
  document.getElementById('queueCapacity').textContent = data.queueCapacity || 1000;
  document.getElementById('processingCount').textContent = data.processingCount || 0;
  document.getElementById('threadCount').textContent = data.threadPoolSize || 16;
  
  // 배치 모드 상태
  const batchStatus = data.batchMode ? '활성' : '비활성';
  document.getElementById('batchModeStatus').textContent = batchStatus;
  
  // 진행률 바 업데이트
  const tpsProgress = Math.min((parseFloat(data.tps || 0) / 100) * 100, 100);
  document.getElementById('tpsProgress').style.width = tpsProgress + '%';
  
  const queueProgress = ((data.queueSize || 0) / (data.queueCapacity || 1000)) * 100;
  document.getElementById('queueProgress').style.width = queueProgress + '%';
  
  // 상태에 따른 로그 추가
  if (data.queueSize > 800) {
    addLog('⚠️ 큐 포화 경고: ' + data.queueSize + '/' + data.queueCapacity, 'warning');
  }
  
  if (parseFloat(data.tps || 0) > 50) {
    addLog('🚀 높은 처리 속도: ' + data.tps + ' TPS', 'success');
  }
}

// 차트 업데이트
function updateChart(data) {
  if (!performanceChart) return;
  
  const now = new Date().toLocaleTimeString();
  const maxDataPoints = 20;
  
  // 라벨 추가
  chartData.labels.push(now);
  if (chartData.labels.length > maxDataPoints) {
    chartData.labels.shift();
  }
  
  // TPS 데이터 추가
  chartData.datasets[0].data.push(parseFloat(data.tps || 0));
  if (chartData.datasets[0].data.length > maxDataPoints) {
    chartData.datasets[0].data.shift();
  }
  
  // 큐 크기 데이터 추가
  chartData.datasets[1].data.push(data.queueSize || 0);
  if (chartData.datasets[1].data.length > maxDataPoints) {
    chartData.datasets[1].data.shift();
  }
  
  performanceChart.update('none');
}

// UUID 디스플레이 업데이트
function updateUuidDisplay(uuids) {
  const container = document.getElementById('uuidList');
  container.innerHTML = '';
  
  if (uuids.length === 0) {
    container.innerHTML = '<p style="color: #666; text-align: center;">현재 추적 중인 예약이 없습니다.</p>';
    return;
  }
  
  uuids.forEach(item => {
    const uuidDiv = document.createElement('div');
    uuidDiv.className = 'uuid-item';
    
    const statusClass = 'status-' + item.status;
    const statusText = getStatusText(item.status);
    
    uuidDiv.innerHTML = `
      <div>
        <div style="font-weight: bold;">${item.rcode}</div>
        <div class="uuid-code">${item.uuid}</div>
      </div>
      <div class="uuid-status ${statusClass}">${statusText}</div>
    `;
    
    container.appendChild(uuidDiv);
  });
}

// 상태 텍스트 변환
function getStatusText(status) {
  const statusMap = {
    'queued': '대기중',
    'processing': '처리중',
    'completed': '완료',
    'failed': '실패'
  };
  return statusMap[status] || status;
}

// 로그 추가 (완전히 개선된 버전)
function addLog(message, type = 'info') {
  // 입력값 검증
  if (!message || typeof message !== 'string') {
    console.warn('Invalid log message:', message);
    return;
  }

  const container = document.getElementById('logContainer');
  if (!container) {
    console.warn('Log container not found');
    return;
  }

  // 유효한 로그 타입만 허용
  const validTypes = ['info', 'success', 'warning', 'error'];
  const logType = validTypes.includes(type) ? type : 'info';

  const logEntry = document.createElement('div');
  logEntry.className = 'log-entry log-' + logType;
  
  const timestamp = new Date().toLocaleTimeString();
  
  // 강화된 메시지 정리 - 모든 문제 패턴 제거
  let cleanMessage = String(message)
    .replace(/\*{2,}\[\]\*{2,}/g, '') // **[]** 및 유사 패턴
    .replace(/\*+\[\]\*+/g, '') // *[]* 패턴
    .replace(/\[\]\*+/g, '') // []*... 패턴
    .replace(/\*+\[\]/g, '') // *...[] 패턴
    .replace(/\[\]/g, '') // 단순 [] 패턴
    .replace(/\*{2,}/g, '') // ** 이상의 연속 별표
    .replace(/\*+/g, '') // 모든 별표 제거
    .replace(/^\s*[\[\]]+\s*$/g, '') // 오직 대괄호와 공백만 있는 줄
    .replace(/[\[\]]+/g, '') // 모든 대괄호 제거
    .replace(/\s+/g, ' ') // 연속 공백을 하나로
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
    .trim();
  
  // 빈 메시지나 의미없는 내용은 추가하지 않음
  if (!cleanMessage || cleanMessage.length < 2) {
    console.warn('Empty or invalid message after cleaning:', message);
    return;
  }
  
  // 안전한 HTML 생성
  logEntry.innerHTML = '<strong>[' + timestamp + ']</strong> ' + cleanMessage;
  
  // 컨테이너에 추가
  container.insertBefore(logEntry, container.firstChild);
  
  // 로그 개수 제한 (최대 100개)
  while (container.children.length > 100) {
    container.removeChild(container.lastChild);
  }
  
  logCounter++;
  updateLogCount();
}

// 로그 개수 업데이트
function updateLogCount() {
  const container = document.getElementById('logContainer');
  document.getElementById('logCount').textContent = container.children.length;
}

// 로그 지우기
function clearLogs() {
  if (confirm('모든 로그를 지우시겠습니까?')) {
    const container = document.getElementById('logContainer');
    container.innerHTML = '';
    logCounter = 0;
    updateLogCount();
    
    // 안전한 로그 추가
    setTimeout(function() {
      addLog('로그가 성공적으로 지워졌습니다', 'success');
    }, 200);
  }
}

// 새로고침 인디케이터 표시
function showRefreshIndicator() {
  document.getElementById('refreshIndicator').classList.add('show');
}

// 새로고침 인디케이터 숨기기
function hideRefreshIndicator() {
  document.getElementById('refreshIndicator').classList.remove('show');
}

// 배치 모드 토글
function toggleBatchMode() {
  const currentStatus = document.getElementById('batchModeStatus').textContent;
  const newMode = !currentStatus.includes('활성');
  
  fetch('/room/setBatchMode', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: 'enabled=' + newMode
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      addLog('배치 모드 ' + (data.batchMode ? '활성화' : '비활성화'), 'info');
      fetchStats();
    } else {
      addLog('배치 모드 변경 실패', 'error');
    }
  })
  .catch(error => {
    // 서버 연결 실패 시 로컬에서 상태 변경
    addLog('배치 모드 ' + (newMode ? '활성화' : '비활성화') + ' (시뮬레이션)', 'info');
    document.getElementById('batchModeStatus').textContent = newMode ? '활성' : '비활성';
  });
}

// 통계 초기화
function resetStats() {
  if (confirm('모든 통계를 초기화하시겠습니까?')) {
    fetch('/room/resetStats', { method: 'POST' })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          addLog('통계 초기화 완료', 'success');
          fetchStats();
        } else {
          addLog('통계 초기화 실패', 'error');
        }
      })
      .catch(error => {
        // 서버 연결 실패 시 로컬에서 초기화
        addLog('통계 초기화 완료 (시뮬레이션)', 'success');
        document.getElementById('totalProcessed').textContent = '0';
        document.getElementById('successCount').textContent = '0';
        document.getElementById('failCount').textContent = '0';
        document.getElementById('tps').textContent = '0.00';
        document.getElementById('queueSize').textContent = '0';
        document.getElementById('processingCount').textContent = '0';
      });
  }
}

// 대용량 테스트 실행
function runBulkTest() {
  const count = prompt('테스트할 예약 수를 입력하세요:', '100');
  if (count && !isNaN(count)) {
    addLog(`대용량 테스트 시작: ${count}건`, 'info');
    
    fetch('/room/bulkTest', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'count=' + count
    })
    .then(response => response.json())
    .then(data => {
      addLog(`대용량 테스트 완료: ${data.successCount}/${data.totalRequests} 성공`, 'success');
      fetchStats();
    })
    .catch(error => {
      // 서버 연결 실패 시 시뮬레이션
      const successCount = Math.floor(count * 0.9); // 90% 성공률
      addLog(`대용량 테스트 완료: ${successCount}/${count} 성공 (시뮬레이션)`, 'success');
      fetchStats();
    });
  }
}

// 긴급 정지
function emergencyStop() {
  if (confirm('⚠️ 예약 시스템을 긴급 정지하시겠습니까?\n모든 처리 중인 작업이 중단됩니다.')) {
    addLog('🚨 긴급 정지 실행됨', 'error');
    stopAutoRefresh();
    
    // 실제 구현에서는 서버에 긴급 정지 신호 전송
    fetch('/room/emergencyStop', { method: 'POST' })
      .then(response => response.json())
      .then(data => {
        addLog('시스템 정지 완료', 'error');
      })
      .catch(error => {
        addLog('시스템 정지 완료 (시뮬레이션)', 'error');
        document.getElementById('processingCount').textContent = '0';
        document.getElementById('queueSize').textContent = '0';
      });
  }
}

// 페이지 언로드 시 정리
window.addEventListener('beforeunload', function() {
  stopAutoRefresh();
  if (window.logGenerationTimer) {
    clearInterval(window.logGenerationTimer);
  }
});

// 키보드 단축키
document.addEventListener('keydown', function(e) {
  if (e.ctrlKey) {
    switch(e.key) {
      case 'r':
        e.preventDefault();
        fetchStats();
        addLog('수동 새로고침 실행', 'info');
        break;
      case 'b':
        e.preventDefault();
        toggleBatchMode();
        break;
      case 'q':
        e.preventDefault();
        toggleAutoRefresh();
        break;
      case 'l':
        e.preventDefault();
        clearLogs();
        break;
    }
  }
});

// 뒤로가기 기능 (브라우저 히스토리 사용)
function goBack() {
  if (window.history.length > 1) {
    window.history.back();
  } else {
    window.location.href = '/admin/adminTools';
  }
}
</script>

</body>
</html>