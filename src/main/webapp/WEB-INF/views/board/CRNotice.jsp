<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>취소/환불 안내</title>
    <style>
        .cs-page * {
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .cs-page-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
            color: #333;
            padding-top: 130px;
        }
        .cs-container {
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .cs-heading-primary {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }
        .cs-heading-secondary {
            color: #0066cc;
            margin-top: 30px;
            margin-bottom: 15px;
            font-size: 1.5em;
        }
        .cs-section {
            margin-bottom: 40px;
        }
        .cs-policy-item {
            margin-bottom: 20px;
            line-height: 1.6;
        }
        .cs-policy-item p {
            margin: 10px 0;
        }
        .cs-note {
            background-color: #f8f9fa;
            padding: 15px;
            border-left: 4px solid #0066cc;
            margin: 20px 0;
        }
        .cs-timeline {
            margin: 20px 0;
            padding: 0;
        }
        .cs-timeline li {
            list-style-type: none;
            position: relative;
            padding-left: 25px;
            margin-bottom: 15px;
        }
        .cs-timeline li:before {
            content: "•";
            color: #0066cc;
            font-size: 20px;
            position: absolute;
            left: 0;
        }
        .cs-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        .cs-table, .cs-table-head, .cs-table-data {
            border: 1px solid #ddd;
        }
        .cs-table-head, .cs-table-data {
            padding: 12px;
            text-align: left;
        }
        .cs-table-head {
            background-color: #f2f2f2;
        }
        .cs-contact-info {
            background-color: #e9f2fb;
            padding: 20px;
            border-radius: 5px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="cs-page">
        <div class="cs-page-wrapper">
            <div class="cs-container">
                <h1 class="cs-heading-primary">취소/환불 안내</h1>

                <div class="cs-section">
                    <h2 class="cs-heading-secondary">예약 취소 안내</h2>
                    <div class="cs-policy-item">
                        <p>고객님께서는 다음과 같은 경우에 파티룸 예약을 취소하실 수 있습니다:</p>
                        <ul>
                            <li>이용일 7일 전까지 - 마이페이지 또는 고객센터를 통해 전액 환불 가능</li>
                            <li>이용일 3~6일 전 - 예약 금액의 70% 환불</li>
                            <li>이용일 1~2일 전 - 예약 금액의 50% 환불</li>
                            <li>이용 당일 - 환불 불가</li>
                        </ul>
                    </div>
                    
                    <div class="cs-note">
                        <p><strong>예약 취소 안내:</strong> 예약 완료 후 24시간 이내에는 별도의 위약금 없이 마이페이지에서 직접 취소가 가능합니다. 다만, 이용일 기준 취소 정책이 우선 적용됩니다.</p>
                    </div>
                    
                    <div class="cs-policy-item">
                        <h3>취소 처리 과정</h3>
                        <ol class="cs-timeline">
                            <li>마이페이지 > 예약내역에서 취소하실 예약 선택</li>
                            <li>예약 상세 페이지에서 '예약 취소' 버튼 클릭</li>
                            <li>취소 사유 선택 및 추가 요청사항 입력</li>
                            <li>취소 신청 완료</li>
                            <li>취소 승인 및 환불 처리 (1~3영업일 소요)</li>
                        </ol>
                    </div>
                </div>

                <div class="cs-section">
                    <h2 class="cs-heading-secondary">예약 변경 정책</h2>
                    <div class="cs-policy-item">
                        <p>파티룸 예약 후 다음과 같은 경우에 예약 변경이 가능합니다:</p>
                        <ul>
                            <li>이용일 7일 전까지 - 날짜 및 시간 변경 무료</li>
                            <li>이용일 3~6일 전 - 예약 금액의 10% 수수료 발생</li>
                            <li>이용일 1~2일 전 - 예약 금액의 20% 수수료 발생</li>
                        </ul>
                    </div>
                    
                    <table class="cs-table">
                        <tr>
                            <th class="cs-table-head">예약 변경 가능 기간</th>
                            <td class="cs-table-data">이용일 기준 최소 24시간 전까지 (당일 변경 불가)</td>
                        </tr>
                        <tr>
                            <th class="cs-table-head">예약 변경 수수료</th>
                            <td class="cs-table-data">이용일 7일 전: 무료 / 3~6일 전: 10% / 1~2일 전: 20% / 당일: 변경 불가</td>
                        </tr>
                        <tr>
                            <th class="cs-table-head">예약 변경 불가 조건</th>
                            <td class="cs-table-data">
                                - 이용 당일 변경 요청<br>
                                - 특별 프로모션으로 예약한 특가 파티룸<br>
                                - 예약 시 명시된 변경 불가 상품<br>
                                - 단체 행사(20인 이상) 예약의 경우 별도 계약 조건 적용
                            </td>
                        </tr>
                    </table>
                    
                    <div class="cs-policy-item">
                        <h3>예약 변경 절차</h3>
                        <ol class="cs-timeline">
                            <li>마이페이지 > 예약내역에서 해당 예약 선택</li>
                            <li>'예약 변경 신청' 버튼 클릭</li>
                            <li>변경 희망 날짜/시간 선택 및 사유 작성</li>
                            <li>변경 가능 여부 확인 (최대 24시간 소요)</li>
                            <li>변경 승인 및 추가 비용 결제 또는 환불 처리</li>
                        </ol>
                    </div>
                </div>

                <div class="cs-section">
                    <h2 class="cs-heading-secondary">환불 안내</h2>
                    <div class="cs-policy-item">
                        <p>환불은 예약 취소 승인 시점을 기준으로 다음과 같이 처리됩니다:</p>
                        <ul>
                            <li>신용카드 결제: 카드사 취소 처리 (3~5영업일 소요)</li>
                            <li>체크카드/실시간 계좌이체: 환불 계좌로 입금 (1~3영업일 소요)</li>
                            <li>무통장 입금: 환불 계좌로 입금 (1~3영업일 소요)</li>
                            <li>휴대폰 결제: 익월 휴대폰 요금에서 차감 또는 계좌 환불</li>
                            <li>카카오페이/네이버페이: 원결제 수단으로 환불 (1~3영업일 소요)</li>
                        </ul>
                    </div>
                    
                    <div class="cs-note">
                        <p><strong>부분 취소 및 날짜/시간 변경:</strong> 동일 예약 건에서 일부 옵션만 취소하거나 날짜/시간 변경 시 발생하는 추가 비용이나 환불액은 취소 규정에 따라 처리됩니다. 쿠폰이나 프로모션 코드 사용 시 혜택이 변동될 수 있습니다.</p>
                    </div>
                    
                    <div class="cs-policy-item">
                        <h3>파티룸 이용 특별 규정</h3>
                        <ul>
                            <li>예약 인원보다 실제 이용 인원이 많은 경우 현장에서 추가 요금이 발생할 수 있습니다.</li>
                            <li>시설물 파손 또는 오염 발생 시 실비로 복구비용이 청구될 수 있습니다.</li>
                            <li>예약 시간 초과 이용 시 30분당 기본 이용 요금의 25%가 추가 부과됩니다.</li>
                            <li>금연 파티룸에서의 흡연 적발 시 청소비 5만원이 추가 청구됩니다.</li>
                        </ul>
                    </div>
                </div>

                <div class="cs-contact-info">
                    <h2 class="cs-heading-secondary">고객 지원 센터</h2>
                    <p>예약 취소/변경/환불에 관한 더 자세한 문의사항은 아래 고객센터로 연락해 주세요.</p>
                    <p><strong>고객센터 전화:</strong> 1588-0000 (매일 09:00~22:00, 연중무휴)</p>
                    <p><strong>이메일:</strong> reservation@partyroom.com</p>
                    <p><strong>카카오톡 플러스친구:</strong> @파티룸예약</p>
                    <p><strong>긴급 연락처:</strong> 010-1234-5678 (예약 당일 문의용)</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>