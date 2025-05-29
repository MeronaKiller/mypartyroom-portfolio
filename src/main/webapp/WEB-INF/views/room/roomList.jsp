<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>룸리스트</title>
<style>
	section
	{
	  width: 1100px;
	  height: auto;
	  margin: 0 auto;
	}
   section > table {
      border-spacing:20px;
   }
   section > table tr td {
      border:2px solid white;
      vertical-align:top;
   }
   section > table tr td:hover
   {
   
   }
   section table tr:last-child td { /* 페이지 출력되는 td에 외곽선 없애기 */
      border:none;
   }
   section table tr:last-child td a { /* 페이지 링크 a태그 */
      text-decoration:none;
      width:30px;
      height:25px;
      padding-top:5px;
      display:inline-block;
      color:black;
   }
   section table tr:last-child td a:hover {
      background:#5F007F;
      color:white;
   }
	#topDiv {
	  position:relative;
	  padding: 30px;
	  word-spacing: 10px;
	  text-align: left;
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
	#topDiv ul
	{
	  display: flex;
	  list-style: none;
	}
	
	#selectPeople
	{	
	  position:absolute;
	  width:300px;
	  height:100px;
	  border: 1px solid black;
	  display:none;
	}
	#selectDate
	{	
		position:absolute;
		width:300px;
		height:100px;
		border: 1px solid black;
		display:none;
	}
	#selectFilter
	{	
		position:absolute;
		width:300px;
		height:100px;
		border: 1px solid black;
		display:none;
	}
	#sort
	{
		padding: 30px;
		border-bottom: 1px solid black;
	}
	#imgTd
	{
 	 	width: 33.33%;
 	 	padding: 10px;
 	 	vertical-align: middle;
 	 	text-align: center;
	}
	#roomInfoCon
	{
	 	width: 90%;
	 	border-radius: 5px;
	 	overflow: hidden;
	 	box-shadow: 0 2px 5px rgba(0,0,0,0.2);
	 	cursor: pointer;
	 	text-align: left;
	 	margin: 0 auto;
	}
	#keywordCon
	{
	 	font-size:12px;
	 	background-color: #f5f5f5;
	 	color: #55555;
	 	border-radius: 5px;
	 	width: auto;
	 	padding: 3px;
	 	text-align: center;
		display: inline-block;
	}
	#PRoomTextCon
	{
	 	padding: 10px;
	 	line-height: 1.7;
	}
	#PRoomName
	{
	 	font-weight: bold;
	 	color: #262c4c;
	}
	#PRoomCapacity
	{
	 	color: #848a8f;
	}
	#PRoomHeart
	{
	 	color: #5A7D9A;
	}
	.rdtoprice
	{
	 	font-weight: bold;
	 	margin-left:0px;
	 	text-align: center;
	 	display: inline-block;
	 	display: flex;
	 	justify-content: center;
	 	align-items: center;
	}
	#rdtocapaheart1
	{
	 	display: flex;
	 	color: #262c4c;
	}
	#rdtocapaheart
	{
		margin-left: auto;
		display: flex;
		color: #262c4c;
	}
    .locCat
    {
	   position:relative;
       height:30px;
       border-bottom:none;
       margin-top:5px;
	   text-align: left;
       white-space: nowrap;
    }
    .locCat a
    {
	   text-decoration: none;
       color: #262c4c;
    }
    .locCat a:hover
    {
    	color: red;
    }
	.locCatUl
	{
	   visibility: hidden;
       position:absolute;
   	   top: 0px;
	}
	
    .locCatUl > li {
       width:auto;
       height:30px;
       line-height:30px;
       border-bottom:none;
       margin-top:5px;
       margin-right:30px;
	   text-align: left;
       white-space: nowrap;
    }
</style>
<script>
	var hnum=-1; // 이전에 보였는 인덱스
	function locCatSpan(n)
	{
		if(hnum!=-1)
			document.getElementsByClassName("locCatUl")[hnum].style.visibility="hidden";
		
		document.getElementsByClassName("locCatUl")[n].style.visibility="visible";
		
		hnum=n;
	}
</script>
</head>
<body>
<section>

<!-- 탑 바 -->
<div id="topDiv"> <!-- 탑 바 시작 -->
	
<span class="locCat" onmouseover="locCatSpan(0)" style="margin-left:40px;"> <!-- 카테고리 시작 -->
	<a href='../room/roomList?rcode=r01'>서울</a>
	<ul class="locCatUl" style="visibility: visible;">
	<li><a href='../room/roomList?rcode=r0101'>홍대/신촌</a></li>
	<li><a href='../room/roomList?rcode=r0102'>건대/잠실/강동구</a></li>
	<li><a href='../room/roomList?rcode=r0103'>사당</a></li>
	<li><a href='../room/roomList?rcode=r0104'>신도림/구로/노량진/선유도</a></li>
	<li><a href='../room/roomList?rcode=r0105'>연신내/은평구</a></li>
	<li><a href='../room/roomList?rcode=r0106'>혜화/이태원</a></li>
	<li><a href='../room/roomList?rcode=r0107'>강북구</a></li>
	<li><a href='../room/roomList?rcode=r0108'>마곡/까치산</a></li>
	</ul>
</span>

<span class="locCat" onmouseover="locCatSpan(1)">
	<a href='../room/roomList?rcode=r02'>인천/부천</a>
	<ul class="locCatUl">
	<li><a href='../room/roomList?rcode=r0201'>인천/부천</a></li>
	</ul>
</span>
	
<span class="locCat" onmouseover="locCatSpan(2)">
	<a href='../room/roomList?rcode=r03'>경기</a>
	<ul class="locCatUl">
	<li><a href='../room/roomList?rcode=r0301'>수원/동탄</a></li>
	<li><a href='../room/roomList?rcode=r0302'>분당</a></li>
	<li><a href='../room/roomList?rcode=r0303'>하남/남양주/구리</a></li>
	<li><a href='../room/roomList?rcode=r0304'>시흥/안양</a></li>
	<li><a href='../room/roomList?rcode=r0305'>파주</a></li>
	<li><a href='../room/roomList?rcode=r0306'>평택/오산</a></li>
	<li><a href='../room/roomList?rcode=r0307'>광주/용인</a></li>
	</ul>
</span>

<span class="locCat" onmouseover="locCatSpan(3)">
	<a href='../room/roomList?rcode=r04'>부산</a>
	<ul class="locCatUl">
	</ul>
</span>

<span class="locCat" onmouseover="locCatSpan(4)">
	<a href='../room/roomList?rcode=r05'>대구/경상</a>
	<ul class="locCatUl">
		<li><a href='../room/roomList?rcode=r0501'>대구</a></li>
		<li><a href='../room/roomList?rcode=r0502'>구미</a></li>
	</ul>
</span>

<span class="locCat" onmouseover="locCatSpan(5)">
	<a href='../room/roomList?rcode=r06'>대전/충청</a>
	<ul class="locCatUl">
	</ul>
</span>

<span class="locCat" onmouseover="locCatSpan(6)">
	<a href='../room/roomList?rcode=r07'>광주/전라</a>
	<ul class="locCatUl">
	<li><a href='../room/roomList?rcode=r0601'>광주</a></li>
	<li><a href='../room/roomList?rcode=r0602'>전주</a></li>
	</ul>
</span>

</div> <!-- 탑 바 끝 -->

<hr>

<table align="center" width="1100">
	<tr>
	<c:forEach items="${rlist}" var="rdto" varStatus="sts">
		<!-- 룸 사진 -->
		<td id="imgTd">
			<div id="roomInfoCon" onclick="location='roomContent?rcode=${rdto.rcode}'">
				<div id="imgContainer"><img src="../static/room/${rdto.pic}" alt="룸 이미지"></div>
				
				<!-- 할인율 -->
				<c:if test="${rdto.halin>0}">
					<div>할인율: ${rdto.halin}%</div>
				</c:if>
				
				<div id="PRoomTextCon"> <!-- 인기 파티룸 내용 텍스트 아이디 -->
					<!-- 룸 이름 -->
					<div id="PRoomName">${rdto.name}</div>
					
					<!-- 키워드 -->
					<div><span id="keywordCon">${rdto.keyword}</span></div>
					
					<div id="rdtocapaheart1">
						<!-- 단위 0일때:시간단위 아니면 패키지단위(패키지아직안함) -->
						<c:choose>
							<c:when test="${rdto.duration_type==2}">
								<span class="rdtoprice"><fmt:formatNumber value="${rdto.price}" type="number" pattern="#,###"/>원/시간</span>
							</c:when>
							<c:otherwise>
									
								<c:set var="priceArray" value="${fn:split(rdto.pkgprice, ',')}" />
								<c:set var="maxPrice" value="0" />
								
								<c:forEach var="price" items="${priceArray}">
									<c:if test="${not empty price and price != ''}">
										<c:set var="currentPrice" value="${price}"/>
										<c:if test="${currentPrice > maxPrice}">
											<c:set var="maxPrice" value="${currentPrice}" />
										</c:if>
									</c:if>
								</c:forEach>
								
								<span class="rdtoprice"><fmt:formatNumber value="${maxPrice}" type="number" pattern="#,###"/>원/패키지</span>
									
							</c:otherwise>
						</c:choose>
						
						<!-- 인원수 -->
						<span id="rdtocapaheart">
							<span id="PRoomCapacity">최대${rdto.capacity}인</span>
							<!-- 좋아요 수 -->
							<span id="PRoomHeart">♥${rdto.heart}</span>
						</span>
					</div>
				</div>
			</div>
		</td>
		
		<c:if test="${sts.count%3==0}">	
			</tr>
			<tr>
		</c:if> 
	</c:forEach>
	
	<!-- 남은 칸 채우기 -->
	<c:if test="${rlistSize % 3 !=0}">
		<c:forEach begin="1" end="${3-(rlistSize % 3)}">
			<td></td>
		</c:forEach>
	</c:if>
	</tr>
</table>

</section>
</body>
</html>