<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	h3
	{
	   text-align: center;
	   font-size: 32px;
	   padding-top: 75px;
	   padding-bottom: 30px;
	}
	body
	{
		margin: 0;
		padding-top: 100px;
		background-color: #F6F6F6;
	}
	section
	{
		width: 650px;
		height: 1000px;
		flex-grow: 1;
		margin: auto;
		text-align: center;
		background-color: white;
		padding-top: 30px;
		padding-bottom: 30px;
	}
	section div
	{
		margin-top: 15px;
	}
	section #txt
	{
		width:580px;
		height:50px;
	}
	section #email
	{
		width:580px;
		height:50px;
	}
</style>
<script>
	function useridCheck(userid) // 아이디 중복체크
	{
		if(userid.length>=6)
		{
			var chk=new XMLHttpRequest();
			chk.onload=function()
			{
				if(chk.responseText=="0")
				{
					document.getElementById("umsg").innerText="✓사용가능한 아이디입니다.";
					document.getElementById("umsg").style.color="#0F8521"; //진한 초록색
					uchk=1;
				}
				else
				{
					document.getElementById("umsg").innerText="사용불가능한 아이디입니다.";
					document.getElementById("umsg").style.color="#F03F40"; //연한 빨간색
					uchk=0;
				}
			}
			chk.open("get","useridCheck?userid="+userid);
			chk.send();
		}
		else
		{
			document.getElementById("umsg").innerText="아이디는 여섯 글자 이상 입력해주세요.";
			document.getElementById("umsg").style.color="#F03F40"; //연한 빨간색
			uchk=0;
		}
	}
	
	function pwdCheck() // 비밀번호 중복체크
	{
		var pwd=document.mform.pwd.value;
		var pwd2=document.mform.pwd2.value;
		
		if(pwd2.length != 0)
		{
			if(pwd == pwd2)
			{
				document.getElementById("pmsg").innerText="✓사용 가능한 비밀번호입니다.";
				document.getElementById("pmsg").style.color="#0F8521";
				pchk=1;
			}
			else
			{
				document.getElementById("pmsg").innerText="새 비밀번호가 일치하지 않습니다.";
				document.getElementById("pmsg").style.color="#F03F40";
				pchk=0;
			}
		}
	}
	
	
	
	var uchk=0; // 중복 확인 완료(중복X)는 1
	var pchk=0;
	
	function check()
	{
		if(uchk==0) //아이디 중복체크가 되었는지 검사
		{
			return false;
		}
		else if(pchk==0) //패스워드 검사
		{
			return false;
		}
		else if(document.mform.name.value=="") //이름 검사
		{
			return false;
		}
		else if(document.mform.phone.value.length==0) // 폰 검사
		{
			return false;
		}
		else
		{
			return true;
		}
		
	}
	function atCheck() //at = @
	{
		var email=document.getElementById("email").value.trim();
		var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 정규식
		
		if(!emailPattern.test(email))
		{
			document.getElementById("emsg").innerText="이메일을 올바르게 입력해주세요.";
			document.getElementById("emsg").style.color="#F03F40";
			echk=0;
		}
		else
		{
			document.getElementById("emsg").innerText="✓사용 가능한 이메일 입니다.";
			document.getElementById("emsg").style.color="#0F8521";
			echk=1;
		}
		
		 
	}
</script>
</head>
<body><!-- /member/member 회원가입창 -->
   <h3> 회원가입 </h3>
 <section>
  <div>
   <form name="mform" method="post" action="memberOk" onsubmit="return check()">
   
    <div> <!-- 아이디 인풋 -->
     <input type="text"name="userid" onblur="useridCheck(this.value)" id="txt" placeholder="아이디를 입력해주세요">
     <br> <span id="umsg"></span>
    </div>
    
    <div> <!-- 이름 인풋 -->
     <input type="text" name="name" id="txt" placeholder="이름">
    </div>
    
    <div> <!-- 비밀번호 인풋 -->
     <input type="password" name="pwd" onblur="pwdCheck()" id="txt" placeholder="비밀번호">
    </div>
    
    <div> <!-- 비밀번호 확인 인풋 -->
     <input type="password" name="pwd2" onblur="pwdCheck()" id="txt" placeholder="비밀번호 확인">
     <br> <span id="pmsg"></span>
    </div>
    
    <div> <!-- 이메일 인풋 -->
     <input type="text" name="email" id="email" onblur="atCheck()" placeholder="이메일">
     <br> <span id="emsg"></span>
    </div>
    
    <div> <!-- 전화번호 인풋 -->
     <input type="text" name="phone" id="txt" placeholder="휴대폰 번호 (숫자만 입력해주세요.)">
    </div>
    
    <div> <!-- 서브밋 -->
     <input type="submit" value="가입하기" id="txt">
    </div>
    
   </form>
  </div>
 </section>
</body>
</html>