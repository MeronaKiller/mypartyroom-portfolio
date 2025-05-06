<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
	    font-family: 'LINESeedKR-Light'; /* Light 버전 */
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Rg.woff2') format('woff2');
	    font-weight: 300;
	    font-style: normal;
	}
	
	@font-face { /* https://noonnu.cc/font_page/1051 */
	    font-family: 'LINESeedKR-Bold'; /* Bold 버전 */
	    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
	    font-weight: 700;
	    font-style: normal;
	}
	
    @font-face /* https://noonnu.cc/font_page/53 */
    {
  	font-family: 'BMJUA';
   	src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
    font-weight: normal;
   	font-style: normal;
	}
	
	body {
	font-family: 'LINESeedKR-Light', 'LINESeedKR-Bold', sans-serif;
	font-weight: 300; /* 적용 가능 */
	margin: 0;
	padding-top: 130px;
	}
	section
	{
	width: 1100px;
	flex-grow: 1;
	margin: auto;
	text-align: center;
	}
	#span1
	{
		position:relative;
		display:inline-block;
	}
	#top-bar
	{
	    width: 1100px;
	    height: 30px;
	    display: flex;
	    position: fixed;
	    top: 0;
        left: 50%;
        justify-content: right;
        align-items: center; /* 세로 중앙 정렬 */
        transform: translateX(-50%); /* 가운데 정렬 */
	    background-color: #3A3A3A; /* 배경 추가하여 가독성 확보 */
	    z-index: 4; /* 헤더보다 위에 배치 */
	}
	#top-bar_warp
	{
		width: 100%;
		height: 30px;
		background-color: #3A3A3A;
		position: fixed; /* 스크롤되도 유지 */
		top: 0;
		left: 0;
		z-index: 3;
	}
	#etcMySub
	{
       position:absolute;
       left:-50px;
       top:0px;
       background:white;
       visibility:hidden;
       border: 1px solid black;
	}
	
    #etcMySub > li {
       list-style-type:none;
       width:120px;
       height:30px;
       line-height:30px;
       text-align:left;
       border-bottom:none;
    }
	#etcMySub > li > a
	{
	   color: #3A3A3A;
	   text-decoration: none;
	}
	#header_warp
	{
		width: 100%;
		height: 80px;
		/*background-color: #f8f8f8;*/
		background-color: white;
		position: fixed; /* 스크롤되도 유지 */
		top: 0;
		left: 0;
		z-index: 2;
		padding-top: 30px;
		box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
	}
    header /* 헤더 전체 */
    {

    	width: 1100px; /* 헤더 가로 길이 */
        height: 80px; /* 헤더 높이 */
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
        justify-content: center; /* 가로 중앙 정렬 */
        gap: 20px; /* 아이콘과 로고 사이 간격 */
        /*background-color: #f8f8f8; /* 밝은 회색 */
		background-color: white;
        position: fixed;
        top: 0;
        left: 50%;
        transform: translateX(-50%); /* 가운데 정렬 */
        z-index: 3; /* 배경보다 위로 */
        padding-top: 30px;
    }
    header #logo /* 로고 스타일 */
    {
    	position: absolute;
    }
    header svg text
    {
		font-family: 'BMJUA', sans-serif;
		font-size: 30px;
		fill: #333333;
    }
    header #login
    {
    	margin-left: auto;
    	margin-top: 5px;
    	padding-right: 200px;
    }
    header #myMain {
    	position:relative;
    }
    header #mySub { /* ul태그 */
       position:absolute;
       left:-65px;
       top:0px;
       background:white;
       visibility:hidden;
       border: 1px solid black;
    }
    header #mySub > li {
       list-style-type:none;
       width:120px;
       height:30px;
       line-height:30px;
       text-align:left;
       border-bottom:none;
    }
    header #login a
    {
       text-decoration: none;
    }
	footer {
	   clear:both;
		width: 100%;
		height: 340px;
	    background-color: #F6F6F6;
	    padding: 20px 0;
	    text-align: center;
		z-index: 1;
		position: relative;
	}
	
	.footer-container {
	    max-width: 1100px;
	    margin: auto;
	}
	
	.footer-info, .footer-links, .footer-contact, .footer-social, .footer-copyright {
	    margin-bottom: 10px;
	}
	
	.footer-links a, .footer-social a {
	    text-decoration: none;
	    margin: 0 10px;
	}
	
	.footer-links a:hover, .footer-social a:hover {
	    text-decoration: underline;
	}
	.decotop a
	{
		text-decoration: none;
		color: white;
		margin-left: 5px;
		margin-right: 5px;
	}
</style>
<script>
	function viewMy()
	{
		document.getElementById("mySub").style.visibility="visible";
	}
	function hideMy()
	{
		document.getElementById("mySub").style.visibility="hidden";
	}
	function viewMy1()
	{
		document.getElementById("etcMySub").style.visibility="visible";
	}
	function hideMy1()
	{
		document.getElementById("etcMySub").style.visibility="hidden";
	}
</script>
  <sitemesh:write property="head"/>
</head>
<body> <!-- default.jsp -->
<div id="top-bar_warp"></div>
<div id="top-bar">
	<c:if test="${userid!=null}"> <!-- 로그인이 되었을 경우 -->
    <div class="decotop"><a href="../member/order">${name}님</a> <a href="../login/logout">로그아웃</a> 
    <span id="span1" onmouseover="viewMy1()" onmouseout="hideMy1()">
    	<a href="../board/noticeList">고객센터</a>
       	<ul id="etcMySub">
       		<li><a href="../board/noticeList">공지사항</a></li>
       		<li><a href="../board/fna">자주하는 질문</a></li>
       		<li><a href="../member/personalInquiry">1:1 문의</a></li>
       		<li><a href="../board/CRNotice">취소/환불 안내</a></li>
       	</ul>
    </span>
    </div>
    </c:if>
    
	<c:if test="${userid==null}"> <!-- 로그인이 안되었을 경우 -->
    <div class="decotop"><a href="../login/login">로그인</a> <a href="../member/member">회원가입</a> 
    <span id="span1" onmouseover="viewMy1()" onmouseout="hideMy1()">
    	<a href="../board/noticeList">고객센터</a>
       	<ul id="etcMySub">
       		<li><a href="../board/noticeList">공지사항</a></li>
       		<li><a href="../board/fna">자주하는 질문</a></li>
       		<li><a href="../login/login">1:1 문의</a></li>
       		<li><a href="../board/CRNotice">취소/환불 안내</a></li>
       	</ul>
    </span>
    </div>
    </c:if>
    
</div>
<div>
<div id="header_warp"></div>
    <header> <!-- 헤더 시작 -->
        <div id="logo" style="position: absolute; left: 10px;">  <!-- SVG 로고 시작 -->
        
           
            <svg width="300" height="100" viewBox="0 0 300 100" xmlns="http://www.w3.org/2000/svg">
                <!-- 로고 텍스트 -->
                <a xlink:href="/"> <!-- xlink:href 사용해서 이동 -->
                <text x="50%" y="50%" text-anchor="middle" dominant-baseline="middle" dy="0.1em">
                    파티플레이스<tspan fill="red"></tspan>
                </text>
                </a>
            </svg> 
        </div><!-- SVG 로고 끝 -->
        
        <!-- 검색창 추가 -->
  	  <div id="search-container" style="position: absolute; left: 50%; transform: translateX(-50%);">
        <form action="../room/roomList" method="get">
            <input type="text" name="searchKeyword" placeholder="파티룸 이름 또는 키워드 검색" style="width: 300px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
            <button type="submit" style="padding: 8px 15px; background: #3A3A3A; color: white; border: none; border-radius: 4px; cursor: pointer;">검색</button>
        </form>
  	  </div>
        
       <div id="login"> <!-- 알람,  -->
       <c:if test="${userid==null}"> <!-- 로그이 안되었을 경우 -->
        <span id="myMain" onmouseover="viewMy()" onmouseout="hideMy()">
       	<a href="../login/login">
       	<img src="../static/header/person_icon_159921.svg" width="30px" height="30px">
       	</a>
       	<ul id="mySub">
       		<li><a href="../login/login">주문내역</a></li> <!-- 프로필내역 메인 -->
       		<li><a href="../login/login">취소/환불 내역</a></li>
       	</ul>       	
       	</span>
       	</c:if>
       <c:if test="${userid!=null}"> <!-- 로그인 되었을 경우 -->
       	<span id="myMain" onmouseover="viewMy()" onmouseout="hideMy()">
       	<a href="../member/order">
       	<img src="../static/header/person_icon_159921.svg" width="30px" height="30px">
       	</a>
       	<ul id="mySub">
       		<li><a href="../member/order">예약내역</a></li> <!-- 프로필내역 메인 -->
       		<li><a href="../member/cancelReturnList">취소/환불 내역</a></li>
       		<li><a href="../login/logout">로그아웃</a></li>
       	</ul>
       	</span>
       </c:if>
       </div>
       
       
    </header> <!-- 헤더 끝 -->
</div>
    <sitemesh:write property="body"/>
    
    <footer>
    <div class="footer-container">
        <!-- 1. 회사 정보 -->
        <div class="footer-info">
            <h3>파티플레이스</h3>
            <p>특별한 순간을 위한 공간</p>
        </div>

        <!-- 2. 이용 약관 & 개인정보 보호 정책 -->
        <div class="footer-links">
            <a href="/about/terms">이용약관</a> | 
            <a href="/about/privacy">개인정보 처리방침</a>
        </div>

        <!-- 3. 고객센터 정보 -->
        <div class="footer-contact">
            <p>고객센터: 1234-5678</p>
            <p>이메일: support@partyplace.com</p>
            <p>운영시간: 평일 09:00 ~ 18:00</p>
        </div>

        <!-- 4. 소셜 미디어 -->
        <div class="footer-social">
            <a href="https://facebook.com" target="_blank">Facebook</a> <!-- 이미지넣던가 -->
            <a href="https://instagram.com" target="_blank">Instagram</a>
            <a href="https://youtube.com" target="_blank">YouTube</a>
        </div>

        <!-- 5. 저작권 정보 -->
        <div class="footer-copyright">
            <p>© 2025 파티플레이스. All rights reserved.</p>
        </div>
    </div>
    <div id="footer-wrap"></div>
</footer>
 <!-- 임시임 -->
</body>
</html>

