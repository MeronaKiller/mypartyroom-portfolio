<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

	<form name="rform" method="post" action="roomWriteOk" enctype="multipart/form-data">
		<table width="1000" align="center">
			<caption> <h3> 파티룸 등록 </h3> </caption>
			<td><a href="../admin/adminTools">돌아가기</a></td>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 룸코드 </td>
				<td>
					<input type="text" name="rcode" readonly placeholder="버튼 누르면 코드 자동 생성">
						<select name="dae" onchange="getSo(this.value)">
						<option value=""> 대분류 </option>
						<c:forEach items="${dlist}" var="ddto">
							<option value="${ddto.daecode}"> ${ddto.name} </option>
						</c:forEach>
					</select>
					<select name="so">
							<option value=""> 소분류 </option>
					</select>
					<input type="button" onclick="getRcode()" value="룸코드생성">
				</td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 메인사진 </td>
				<td><input type="file" name="pic1"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 세부사진(여러개 가능) </td>
				<td>
				<input type="file" name="subpic0"><br>
				<input type="file" name="subpic1"><br>
				<input type="file" name="subpic2"><br>
				<input type="file" name="subpic3"><br>
				<input type="file" name="subpic4"><br>
				<input type="file" name="subpic5"><br>
				<input type="file" name="subpic6"><br>
				<input type="file" name="subpic7"><br>
				<input type="file" name="subpic8"><br>
				<input type="file" name="subpic9"><br>
				<input type="file" name="subpic10"><br>
				<input type="file" name="subpic11"><br>
				<input type="file" name="subpic12"><br>
				<input type="file" name="subpic13"><br>
				<input type="file" name="subpic14"><br>
				<input type="file" name="subpic15"><br>
				<input type="file" name="subpic16"><br>
				<input type="file" name="subpic17"><br>
				<input type="file" name="subpic18"><br>
				</td>
			</tr>
				<tr>
				<td colspan="3"><hr></td>
				</tr>
			
			<tr>
				<td> 룸 이름 </td>
				<td><input type="text" name="name" style="width:400px;" placeholder="룸 이름"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
							<tr>
				<td> 룸 sub 이름 </td>
				<td><input type="text" name="subname" style="width:400px;" placeholder="Content 룸 아래에 나오는 이름"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<td> 주소 </td>
				<td><input type="text" name="adress" style="width:400px;" placeholder="룸 주소"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<td> 도로명 주소 </td>
				<td><input type="text" name="roadadress" style="width:400px;" placeholder="룸 도로명 주소"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<td> 전화번호 </td>
				<td><input type="text" name="phone" onkeyup="chgNumber(this)" placeholder="숫자만 입력"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<td> x축(경도) </td>
				<td><input type="text" name="mapx" placeholder="x축 예 ex)14128793.8259228"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<td> y축(위도) </td>
				<td><input type="text" name="mapy" placeholder="y축 예 ex)4516394.1835569"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				
			<tr>
				<td> 시간당 가격(패키지만 사용시 -1입력) </td>
				<td><input type="text" name="price" placeholder="숫자만 입력">원/시간</td>
			</tr>
				<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 할인율 </td>
				<td><input type="text" name="halin" onkeyup="chgNumber(this)" style="width:40px;" placeholder="숫자만">%</td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 공간소개 </td>
				<td ><textarea style="width:500px; height:300px;" type="text" name="description" placeholder="공간 소개"></textarea></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				
			<tr>
			<td> 영업시간 </td>
			<td><input type="text" name="officehour" placeholder="ex)06~24시"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
			<td> 휴무일 </td>
			<td><input type="text" name="closedday" placeholder="ex)공휴일 or 무휴"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<td> 몇층인지 </td>
			<td><input type="text" name="floor" placeholder="ex) 6층"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 주차 여부 </td>
				<td><input type="text" name="car" onkeyup="chgNumber(this)" style="width:100px;" placeholder="0:불가, 1:가능"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 엘리베이터 여부 </td>
				<td><input type="text" name="elevator" onkeyup="chgNumber(this)" style="width:100px;" placeholder="0:없음, 1:있음"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<tr>
				<td> 시설 현황 </td>
					<td>
				    <label><input type="checkbox" name="fstatus" value="0"> 냉/낭반기 </label>
				    <label><input type="checkbox" name="fstatus" value="1"> 주차 </label>
				    <label><input type="checkbox" name="fstatus" value="2"> 바베큐 시설 </label>
				    <label><input type="checkbox" name="fstatus" value="3"> 테라스/루프탑 </label>
				    <label><input type="checkbox" name="fstatus" value="4"> 내부 화장실 </label>
				    <label><input type="checkbox" name="fstatus" value="5"> 외부 화장실 </label>
				    <label><input type="checkbox" name="fstatus" value="6"> 바닥 난방 </label>
				    <label><input type="checkbox" name="fstatus" value="7"> 온수 </label>
				    <label><input type="checkbox" name="fstatus" value="8"> 인터넷/wifi </label>
				    <label><input type="checkbox" name="fstatus" value="9"> 실내 흡연 금지 </label>
				    <label><input type="checkbox" name="fstatus" value="10"> 실내 흡연 가능 </label>
				    <label><input type="checkbox" name="fstatus" value="11"> 엘리베이터 있음 </label>
				    </td>
				    </tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<tr>
				<td> 내부 안내 </td>
				<td>
				    <label><input type="checkbox" name="ininfo" value="0"> 빔프로젝터 </label>
				    <label><input type="checkbox" name="ininfo" value="1"> TV </label>
				    <label><input type="checkbox" name="ininfo" value="2"> 담요/매트리스 </label>
				    <label><input type="checkbox" name="ininfo" value="3"> 테이블/의자 </label>
				    <label><input type="checkbox" name="ininfo" value="4"> 전신거울 </label>
				    <label><input type="checkbox" name="ininfo" value="5"> 블루투스 스피커 </label>
				    <label><input type="checkbox" name="ininfo" value="6"> PC </label>
				    </td>
				    </tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<tr>
				<td> 놀이 </td>
				<td>
				    <label><input type="checkbox" name="play" value="0"> 보드 게임 </label>
				    <label><input type="checkbox" name="play" value="1"> 노래방 기능 </label>
				    <label><input type="checkbox" name="play" value="2"> 미러볼 </label>
				    <label><input type="checkbox" name="play" value="3"> 기타 게임 </label>
				    <label><input type="checkbox" name="play" value="4"> 오락기 </label>
				    <label><input type="checkbox" name="play" value="5"> 파티 소품 </label>
				    <label><input type="checkbox" name="play" value="6"> 홀덤 테이블 </label>
				    <label><input type="checkbox" name="play" value="7"> 수영장 </label>
				    </td>
				    </tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				<tr>
				<td> 주방 </td>
				<td>
				    <label><input type="checkbox" name="kitchen" value="0"> 싱크대 </label>
				    <label><input type="checkbox" name="kitchen" value="1"> 취사시설 </label>
				    <label><input type="checkbox" name="kitchen" value="2"> 전자레인지 </label>
				    <label><input type="checkbox" name="kitchen" value="3"> 전기포트 </label>
				    <label><input type="checkbox" name="kitchen" value="4"> 식기/수저 </label>
				    <label><input type="checkbox" name="kitchen" value="5"> 컵/잔 </label>
				    <label><input type="checkbox" name="kitchen" value="6"> 커피 머신 </label>
				    <label><input type="checkbox" name="kitchen" value="7"> 정수기 </label>
				    <label><input type="checkbox" name="kitchen" value="8"> 제빙기 </label>
				    </td>
				    </tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 유의 사항 </td>
				<td ><textarea style="width:500px; height:300px;" type="text" name="caution" placeholder="엔터로 줄바꾸면 줄 숫자 매겨짐"></textarea></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
			<td rowspan="9"> 환불정책 </td>
			<c:forEach var="i" begin="1" end="9">
			<td>
			<c:choose>
			<c:when test="${(9-i) == 1}">
				이용 전날
				</c:when>
			<c:when test="${(9-i) == 0}">
				이용 당일
				</c:when>
			<c:otherwise>
				이용 ${9-i}일 전
			</c:otherwise>
			</c:choose>
			

				<select name="refundpolicy">
					<option value="0"> 총 금액의 100% 환불 </option>
					<option value="1"> 총 금액의 90% 환불 </option>
					<option value="2"> 총 금액의 80% 환불 </option>
					<option value="3"> 총 금액의 70% 환불 </option>
					<option value="4"> 총 금액의 60% 환불 </option>
					<option value="5"> 총 금액의 50% 환불 </option>
					<option value="6"> 총 금액의 40% 환불 </option>
					<option value="7"> 총 금액의 30% 환불 </option>
					<option value="8"> 총 금액의 20% 환불 </option>
					<option value="9"> 총 금액의 10% 환불 </option>
					<option value="-1"> 환불불가 </option>
				</select>
				<br>
				</td>
			</tr>
			</c:forEach>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			<tr>
				<td> 이용가능한 최대 인원 </td>
				<td>최대<input type="text" name="capacity" onkeyup="chgNumber(this)" style="width:30px;" placeholder="숫자">명</td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
				
			<tr>
				<td> 키워드 </td>
				<td><input type="text" name="keyword" style="width:700px;" placeholder="ex) #강남#홍대#신촌#테라스#빔프로젝터#루프탑"></td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			
			<tr>
			    <td> 단위 선택 </td>
			    <td>
			        <select name="duration_type">
			            <option value="0">시간</option>
			            <option value="1">패키지</option>
			            <option value="2">시간 + 패키지</option>
			        </select>
			        패키지만 선택시에는 시간당 가격 -1로, 시간만 선택시에는 밑에 패키지 빈칸으로
			    </td>
			</tr>
							<tr>
				<td colspan="3"><hr></td>
				</tr>
			
			
			<c:forEach var="i" begin="1" end="6">
			<tr><!-- 패키지 시작 -->
				<td> 패키지 이름 </td>
				<td>
					<input type="text" name="pkgname" placeholder="ex)오전패키지 6~12시">
				패키지 가격 <input name="pkgprice" type="number" onkeyup="chgNumber(this)" placeholder="ex)24000">원/패키지</td>
			</tr>
				
								<!-- 시간 선택 input -->
				<tr>
				
				<td><label>이용 시작 시간:</label></td>
				<td><input name="pkgstart" type="text" id="start_time" placeholder="시간 선택"></td>
				
				</tr>
				<tr>
				
				<td><label>이용 종료 시간:</label></td>
				<td><input name="pkgend" type="text" id="end_time" placeholder="시간 선택"></td>
				<tr>
				<td colspan="3"><hr></td>
				</tr>
				</tr><!-- 패키지 끝 -->
			</c:forEach>
				
				
				<!-- Flatpickr 라이브러리 추가 -->
				<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
				<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
				
				<script>
				  flatpickr("#start_time", {
				    enableTime: true,  // 시간 선택 활성화
				    noCalendar: true,  // 달력 비활성화 (시간만 선택)
				    dateFormat: "H:i", // 24시간 형식 (예: 14:30)
				    time_24hr: true,   // 24시간 형식 사용
				    minuteIncrement: 30 // 30분 단위로 선택 가능
				  });
				
				  flatpickr("#end_time", {
				    enableTime: true,
				    noCalendar: true,
				    dateFormat: "H:i",
				    time_24hr: true,
				    minuteIncrement: 30
				  });
				</script>
								
				
				</td>
				
				
				
			</tr>
			</tr>
			
			
			
			<tr align="center">
				<td colspan="2"><input type="submit" value="룸 등록"></td>
			</tr>
			
		</table>
	</form>

</body>
</html>