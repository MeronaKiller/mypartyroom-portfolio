<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파티룸 등록</title>
<style>
    body {
        font-family: 'Malgun Gothic', sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 1000px; /* 컨테이너 너비 확장 */
        margin: 30px auto;
        background-color: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
    }
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }
    h3 {
        margin: 0;
        color: #333;
        font-size: 24px;
    }
    .back-link {
        display: inline-block;
        padding: 8px 15px;
        background-color: #f2f2f2;
        color: #333;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
    }
    .back-link:hover {
        background-color: #e0e0e0;
    }
    .form-table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed; /* 테이블 레이아웃을 고정으로 설정 */
    }
    .form-table td {
        padding: 15px;
        vertical-align: top; /* top으로 변경하여 레이블이 상단에 정렬되도록 함 */
        overflow-wrap: break-word; /* 긴 텍스트가 있을 때 자동 줄바꿈 */
    }
    .form-table td:first-child {
        width: 200px; /* 좌측 항목 너비 확장 */
        font-weight: bold;
        color: #555;
        text-align: left; /* 왼쪽 정렬로 변경 */
        padding-right: 20px;
        white-space: nowrap; /* 텍스트가 줄바꿈되지 않도록 설정 */
    }
    .separator {
        height: 1px;
        background-color: #eee;
        border: none;
        margin: 0;
    }
    
    input[type="text"], 
    input[type="password"], 
    input[type="number"],
    textarea,
    select {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
        transition: border-color 0.3s;
        width: 100%;
        max-width: 600px; /* 입력 필드 최대 너비 확장 */
    }
    
    input[type="text"]:focus, 
    input[type="password"]:focus, 
    input[type="number"]:focus,
    textarea:focus,
    select:focus {
        border-color: #4CAF50;
        outline: none;
    }
    
    .small-width {
        width: 200px;
    }
    
    .tiny-width {
        width: 80px;
    }
    
    input[type="file"] {
        margin-bottom: 8px;
        display: block;
    }
    
    .btn {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s;
    }
    
    .btn:hover {
        background-color: #45a049;
    }
    
    .btn-secondary {
        background-color: #f2f2f2;
        color: #333;
    }
    
    .btn-secondary:hover {
        background-color: #e0e0e0;
    }
    
    textarea {
        resize: vertical;
        min-height: 100px;
    }
    
    .checkbox-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr); /* 그리드 컬럼 수 변경 */
        gap: 12px; /* 간격 약간 증가 */
    }
    
    .checkbox-label {
        display: flex;
        align-items: center;
        cursor: pointer;
    }
    
    .checkbox-label input {
        margin-right: 8px;
    }
    
    .refund-policy {
        margin-bottom: 10px;
        display: flex;
        align-items: center;
    }
    
    .refund-policy-day {
        width: 120px; /* 환불정책 날짜 부분 너비 증가 */
        font-weight: normal;
        margin-right: 15px;
    }
    
    .input-group {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .input-with-unit {
        display: flex;
        align-items: center;
    }
    
    .input-with-unit input {
        margin-right: 8px;
    }
    
    .input-with-unit span {
        white-space: nowrap;
    }
    
    .image-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr); /* 그리드 컬럼 수 변경 */
        gap: 12px; /* 간격 약간 증가 */
    }
    
    .submit-row {
        text-align: center;
        padding: 25px 0 10px 0;
    }
    
    .error-message {
        color: red;
        font-weight: bold;
        text-align: center;
        padding: 20px;
        background-color: #ffe6e6;
        border: 1px solid #ff9999;
        border-radius: 5px;
        margin: 50px auto;
        max-width: 500px;
    }
    
    /* 환불정책 테이블 스타일 개선 */
    .refund-table td {
        padding: 8px 15px;
    }
    
    .refund-table td:first-child {
        width: 150px;
    }
</style>
<script>
    function getSo(dae)
    {
        if(dae=="")
        {
            
        }
        else
        {
            var dae=document.rform.dae.value;
            var so=document.rform.so.value;
            var daeso=dae+so;
         
            var chk=new XMLHttpRequest();
            chk.onload=function()
            {
                var sos=JSON.parse(chk.responseText);
                
                document.rform.so.options.length=sos.length+1;
                var i=1;
                for(so of sos)
                {
                       document.rform.so.options[i].value=so.socode;
                       document.rform.so.options[i].text=so.name;
                       i++;
                }
            }
               chk.open("get","getSo?daeid="+dae);
               chk.send();
        }
    }
    function getRcode()
    {
        var dae=document.rform.dae.value;
        var so=document.rform.so.value;
        
        var rcode="r"+dae+so;
        
           var chk=new XMLHttpRequest();
           chk.onload=function()
           {
               document.rform.rcode.value=chk.responseText;
           }
           chk.open("get","getRcode?rcode="+rcode);
           chk.send();
    }
       function chgNumber(my)
       {
        my.value=my.value.replace(/[^0-9]/g,"");
       }
</script>
</head>
<body>
<!-- 관리자 확인 -->
<c:if test="${admin_userid ne 'pkc'}">
    <div class="error-message">
        잘못된 접근입니다. 관리자 로그인이 필요합니다.
        <script>
            setTimeout(function() {
                window.location.href = "/admin/adminLogin";
            }, 3000); // 3초 후 로그인 페이지로 이동
        </script>
    </div>
</c:if>
<c:if test="${admin_userid eq 'pkc'}">
<div class="container">
    <div class="header">
        <h3>파티룸 등록</h3>
        <a href="../admin/adminTools" class="back-link">돌아가기</a>
    </div>
    
    <form name="rform" method="post" action="roomWriteOk" enctype="multipart/form-data">
        <table class="form-table">
            <tr>
                <td>룸코드</td>
                <td>
                    <div style="margin-bottom: 10px;">
                        <input type="text" name="rcode" readonly placeholder="버튼 누르면 코드 자동 생성">
                    </div>
                    <div style="display: flex; gap: 10px; align-items: center;">
                        <select name="dae" onchange="getSo(this.value)" style="width: 33%;">
                            <option value="">대분류</option>
                            <c:forEach items="${dlist}" var="ddto">
                                <option value="${ddto.daecode}">${ddto.name}</option>
                            </c:forEach>
                        </select>
                        <select name="so" style="width: 33%;">
                            <option value="">소분류</option>
                        </select>
                        <button type="button" class="btn btn-secondary" onclick="getRcode()">룸코드생성</button>
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>메인사진</td>
                <td><input type="file" name="pic1"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>세부사진</td>
                <td>
                    <div class="image-grid" style="grid-template-columns: repeat(2, 1fr);">
                        <input type="file" name="subpic0">
                        <input type="file" name="subpic1">
                        <input type="file" name="subpic2">
                        <input type="file" name="subpic3">
                        <input type="file" name="subpic4">
                        <input type="file" name="subpic5">
                        <input type="file" name="subpic6">
                        <input type="file" name="subpic7">
                        <input type="file" name="subpic8">
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>룸 이름</td>
                <td><input type="text" name="name" placeholder="룸 이름"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>룸 sub 이름</td>
                <td><input type="text" name="subname" placeholder="Content 룸 아래에 나오는 이름"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>주소</td>
                <td><input type="text" name="adress" placeholder="룸 주소"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>도로명 주소</td>
                <td><input type="text" name="roadadress" placeholder="룸 도로명 주소"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>전화번호</td>
                <td><input type="text" name="phone" onkeyup="chgNumber(this)" placeholder="숫자만 입력"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>x축(경도)</td>
                <td><input type="text" name="mapx" placeholder="x축 예 ex)14128793.8259228"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>y축(위도)</td>
                <td><input type="text" name="mapy" placeholder="y축 예 ex)4516394.1835569"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>시간당 가격</td>
                <td>
                    <div class="input-with-unit">
                        <input type="text" name="price" class="small-width" placeholder="숫자만 입력">
                        <span>원/시간</span>
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>할인율</td>
                <td>
                    <div class="input-with-unit">
                        <input type="text" name="halin" onkeyup="chgNumber(this)" class="tiny-width" placeholder="숫자만">
                        <span>%</span>
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>공간소개</td>
                <td><textarea name="description" style="height: 150px;" placeholder="공간 소개"></textarea></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>영업시간</td>
                <td><input type="text" name="officehour" placeholder="ex)06~24시"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>휴무일</td>
                <td><input type="text" name="closedday" placeholder="ex)공휴일 or 무휴"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>몇층인지</td>
                <td><input type="text" name="floor" class="small-width" placeholder="ex) 6층"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>주차 여부</td>
                <td>
                    <select name="car" class="small-width">
                        <option value="0">주차 불가</option>
                        <option value="1">주차 가능</option>
                    </select>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>엘리베이터 여부</td>
                <td>
                    <select name="elevator" class="small-width">
                        <option value="0">엘리베이터 없음</option>
                        <option value="1">엘리베이터 있음</option>
                    </select>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>시설 현황</td>
                <td>
                    <div class="checkbox-grid">
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="0"> 냉/난방기</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="1"> 주차</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="2"> 바베큐 시설</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="3"> 테라스/루프탑</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="4"> 내부 화장실</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="5"> 외부 화장실</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="6"> 바닥 난방</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="7"> 온수</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="8"> 인터넷/wifi</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="9"> 실내 흡연 금지</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="10"> 실내 흡연 가능</label>
                        <label class="checkbox-label"><input type="checkbox" name="fstatus" value="11"> 엘리베이터 있음</label>
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>내부 안내</td>
                <td>
                    <div class="checkbox-grid">
                        <label class="checkbox-label"><input type="checkbox" name="ininfo" value="0"> 빔프로젝터</label>
                        <label class="checkbox-label"><input type="checkbox" name="ininfo" value="1"> TV</label>
                        <label class="checkbox-label"><input type="checkbox" name="ininfo" value="2"> 담요/매트리스</label>
                        <label class="checkbox-label"><input type="checkbox" name="ininfo" value="3"> 테이블/의자</label>
                        <label class="checkbox-label"><input type="checkbox" name="ininfo" value="4"> 전신거울</label>
                        <label class="checkbox-label"><input type="checkbox" name="ininfo" value="5"> 블루투스 스피커</label>
                        <label class="checkbox-label"><input type="checkbox" name="ininfo" value="6"> PC</label>
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>놀이</td>
                <td>
                    <div class="checkbox-grid">
                        <label class="checkbox-label"><input type="checkbox" name="play" value="0"> 보드 게임</label>
                        <label class="checkbox-label"><input type="checkbox" name="play" value="1"> 노래방 기능</label>
                        <label class="checkbox-label"><input type="checkbox" name="play" value="2"> 미러볼</label>
                        <label class="checkbox-label"><input type="checkbox" name="play" value="3"> 기타 게임</label>
                        <label class="checkbox-label"><input type="checkbox" name="play" value="4"> 오락기</label>
                        <label class="checkbox-label"><input type="checkbox" name="play" value="5"> 파티 소품</label>
                        <label class="checkbox-label"><input type="checkbox" name="play" value="6"> 홀덤 테이블</label>
                        <label class="checkbox-label"><input type="checkbox" name="play" value="7"> 수영장</label>
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>주방</td>
                <td>
                    <div class="checkbox-grid">
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="0"> 싱크대</label>
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="1"> 취사시설</label>
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="2"> 전자레인지</label>
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="3"> 전기포트</label>
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="4"> 식기/수저</label>
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="5"> 컵/잔</label>
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="6"> 커피 머신</label>
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="7"> 정수기</label>
                        <label class="checkbox-label"><input type="checkbox" name="kitchen" value="8"> 제빙기</label>
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>유의 사항</td>
                <td><textarea name="caution" style="height: 150px;" placeholder="엔터로 줄바꾸면 줄 숫자 매겨짐"></textarea></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <!-- 환불정책 부분 개선 -->
            <tr>
                <td>환불정책</td>
                <td>
                    <table class="refund-table" style="width: 100%; border-collapse: collapse;">
                        <c:forEach var="i" begin="1" end="9">
                            <tr>
                                <td style="padding: 8px 0;">
                                    <span class="refund-policy-day">
                                        <c:choose>
                                            <c:when test="${(9-i) == 1}">이용 전날</c:when>
                                            <c:when test="${(9-i) == 0}">이용 당일</c:when>
                                            <c:otherwise>이용 ${9-i}일 전</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <select name="refundpolicy" style="width: 100%;">
                                        <option value="0">총 금액의 100% 환불</option>
                                        <option value="1">총 금액의 90% 환불</option>
                                        <option value="2">총 금액의 80% 환불</option>
                                        <option value="3">총 금액의 70% 환불</option>
                                        <option value="4">총 금액의 60% 환불</option>
                                        <option value="5">총 금액의 50% 환불</option>
                                        <option value="6">총 금액의 40% 환불</option>
                                        <option value="7">총 금액의 30% 환불</option>
                                        <option value="8">총 금액의 20% 환불</option>
                                        <option value="9">총 금액의 10% 환불</option>
                                        <option value="-1">환불불가</option>
                                    </select>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>이용가능한 최대 인원</td>
                <td>
                    <div class="input-with-unit">
                        <span>최대</span>
                        <input type="text" name="capacity" onkeyup="chgNumber(this)" class="tiny-width" placeholder="숫자">
                        <span>명</span>
                    </div>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>키워드</td>
                <td><input type="text" name="keyword" placeholder="ex) #강남#홍대#신촌#테라스#빔프로젝터#루프탑"></td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td>단위 선택</td>
                <td>
                    <select name="duration_type" class="small-width">
                        <option value="0">시간</option>
                        <option value="1">패키지</option>
                        <option value="2">시간 + 패키지</option>
                    </select>
                </td>
            </tr>
            <tr><td colspan="2"><hr class="separator"></td></tr>
            
            <tr>
                <td colspan="2" class="submit-row">
                    <button type="submit" class="btn">룸 등록</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</c:if>
</body>
</html>