<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파티플레이스</title>
<style>
 	 table /*임시*/
 	 {
 	    width: 1100px;
  	    border-collapse: collapse;
 	 }
 	 .sliderContainer
 	 {
 	 	width: 100%;
 	 	max-width: 1100px;
 	 	border-radius: 20px;
 	 	margin: auto;
 	 	overflow: hidden;
 	 	position: relative;
 	 	margin-bottom: 150px;
 	 }
 	 .sliderContainer #slider
 	 {
 	 	display: flex;
 	 	width: 3300px;
 	 	height: 200px;
 	 }
 	 #slider img
 	 {
 	 	display: block;
 	 	width: 1100px;
 	 	height: 200px;
 	 }
 	 #prev, #next
 	 {
 	 	cursor: pointer;
 	 	position: absolute;
 	 	top: 50%;
 	 	transform: translateY(-50%);
 	 	padding: 10px;
 	 	background: white;
 	 	color: black;
 	 	border: none;
 	 	z-index: 1;
 	 	border-radius: 50%;
 	 	padding: 15px;
 	 	background-color: rgba(255, 255, 255, 0.7);
 	 	font-size: 18px;
 	 	font-weight: bold;
 	 	box-shadow: 0 2px 5px rgba(0,0,0,0.2);
 	 }
 	 #prev:hover, #next:hover
 	 {
    background-color: rgba(255, 255, 255, 0.9);
	 }
 	 #prev
 	 {
 	 	left: 20px;
 	 }
 	 #next
 	 {
 	 	right: 20px;
 	 }
 	 #imgTd
 	 {
 	 	width: 30%;
 	 }
 	 #imgContainer
	 {
	     width: 100%;
	     height: 180px;
	 }
	 #imgContainer img
	 {
	 	
	 	width: 100%;
     	height: 100%;
	 	object-fit: cover; /* 빈 공간 없이 채우기, 일부 잘림 */
	 }
	 #popularRoom
	 {
	 	font-size: 25px;
	 	font-style: bold;
	 }
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>

$(function() {
    // 자동 슬라이드 타이머 변수
    let slideTimer;
    
    const animationDuration = 200;
    const slideInterval = 5000;
    
    // 링크 URL 배열 저장
    const linkUrls = [];
    
    // 초기 링크 URL 저장
    $("#slider a").each(function(index) {
        linkUrls.push($(this).attr("href"));
    });
    
    // 다음 슬라이드 함수
    function moveNext() {
        $("#slider").animate(
            {
                marginLeft: "-1100px"
            },
            animationDuration,
            function() {
                // 첫 번째 요소를 뒤로 이동
                const $firstSlide = $("#slider a:first-child");
                $firstSlide.appendTo("#slider");
                
                // 링크 URL도 같이 순환시킴
                const firstLink = linkUrls.shift();
                linkUrls.push(firstLink);
                
                // 모든 링크에 URL 다시 할당
                $("#slider a").each(function(index) {
                    $(this).attr("href", linkUrls[index]);
                });
                
                // 슬라이더 위치 초기화
                $("#slider").css("marginLeft", "0px");
            }
        );
    }
    
    // 이전 슬라이드 함수
    function movePrev() {
        // 마지막 요소를 앞으로 이동
        const $lastSlide = $("#slider a:last-child");
        $lastSlide.prependTo("#slider");
        $("#slider").css("marginLeft", "-1100px");
        
        // 링크 URL도 같이 순환시킴
        const lastLink = linkUrls.pop();
        linkUrls.unshift(lastLink);
        
        // 모든 링크에 URL 다시 할당
        $("#slider a").each(function(index) {
            $(this).attr("href", linkUrls[index]);
        });
        
        // 애니메이션
        $("#slider").animate(
            {
                marginLeft: "0px"
            },
            animationDuration
        );
    }
    
    // 자동 슬라이드 시작
    function startAutoSlide() {
        if(slideTimer) {
            clearInterval(slideTimer);
        }
        
        slideTimer = setInterval(moveNext, slideInterval);
    }
    
    // 다음 버튼 클릭 이벤트
    $("#next").click(function() {
        clearInterval(slideTimer);
        moveNext();
        startAutoSlide();
    });
    
    // 이전 버튼 클릭 이벤트
    $("#prev").click(function() {
        clearInterval(slideTimer);
        movePrev();
        startAutoSlide();
    });
    
    // 마우스가 슬라이더 위에 있을 때 자동 슬라이드 정지
    $(".sliderContainer").hover(
        function() {
            clearInterval(slideTimer);
        },
        function() {
            startAutoSlide();
        }
    );
    
    // 페이지 로드 시 자동 슬라이드 시작
    startAutoSlide();
});
</script>
</head>
<body><!-- /main/main.jsp -->
<section>
	<div class="sliderContainer"><!-- 배너 컨테이너 배너 하나만 보여줌 -->
	 <div id="slider"><!-- 배너 이미지 -->
	 	
		<a href="../room/roomList?rcode=r01"><img src="../static/body/banner1.png" width="1100" height="200" alt="배너 이미지 1"></a>
		<a href="../room/roomList?rcode=r0105"><img src="../static/body/banner2.png" width="1100" height="200" alt="배너 이미지 2"></a>
		<a href="../room/roomList?rcode=r01"><img src="../static/body/banner3.png" width="1100" height="200" alt="배너 이미지 3"></a>
	 </div>
	<!-- 넘기는 버튼 -->
	<button id="prev">❮</button>
	<button id="next">❯</button>
	</div>
	<table>
	<h1 id="popularRoom">인기 파티룸</h1> <!-- 좋아요 수 높은순 -->
	<tr height="530">

	<c:forEach items="${rdto}" var="rdto" varStatus="sts">
	
	<!-- 룸 사진 -->
	<td id="imgTd" onclick="location='roomContent?rcode=${rdto.rcode}'">
	<div id="imgContainer"><img src="../static/room/${rdto.pic}" alt="룸 이미지"></div>
	
	<!-- 할인율 -->
	<c:if test="${rdto.halin>0}">
		<div>할인율: ${rdto.halin}%</div>
	</c:if>
	
	<!-- 룸 이름 -->
	<div>${rdto.name}</div>
	
	<!-- 키워드 -->
	<div>${rdto.keyword}</div>
	
	<div>
	<!-- 단위 0일때:시간단위 아니면 패키지단위(패키지아직안함) -->
	<c:choose>
	<c:when test="${rdto.duration_type==0}">
		<fmt:formatNumber value="${rdto.price}" type="number" pattern="#,###"/>원/시간
	</c:when>
	<c:when test="${rdto.duration_type==1}">
	
	</c:when>
	<c:otherwise>
			<fmt:formatNumber value="${rdto.price}" type="number" pattern="#,###"/>원/시간
			
	</c:otherwise>
	</c:choose>
	
	<!-- 인원수 -->
	최대${rdto.capacity}인
	<!-- 댓글 수(답변기능 추가해야함) -->
	<!-- 좋아요 수 -->
	♡${rdto.heart}</div>
	</td>
	</c:forEach>
   </table>
	
	<tr height="250">
	<td>파티플레이스</td>
	<td>서비스 소개</td>
	</tr>
	
	<tr height="730">
	<td colspan="2">사진(파티룸 내부 사진 & 시설 정보) <br>
	<a href="../room/roomInfo">파티룸 자세히 보기</a></td>
	</tr>
	
	
	
	
	
	<tr height="250">
	<td colspan="2"><a href="../room/roomList?rcode=r01">예약하기</a> / 파티룸 검색 기능(할거면 하고)</td>
	</tr>
	
	<tr height="250">
	<td colspan="2">사용 후기 & 신뢰도 정보 (예: "누적 예약 10,000회" 등)<br>
	<a href="../board/review">모든 리뷰 보기</a> <!-- 링크위치 임시 -->
	</td>
	</tr>
	
</section>
</body>
</html>