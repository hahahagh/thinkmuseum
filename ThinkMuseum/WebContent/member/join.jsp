<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/style.css">

<title>Insert title here</title>
<script src="../js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	/* function winopen() {
		//id란이 공백이면 '아이디를 입력하세요' 포커스 주기
		if(document.frm.id.value == ''){
			alert('아이디를 입력하세요');
			document.frm.id.focus();
			return;
		}
		//창열기 join_IDCheck.jsp width = 400, height = 200
		var userid = document.frm.id.value; 
		window.open('join_IDCheck.jsp?userid='+userid,'','width = 400, height = 200');
	
	} */
	
	$(document).ready(function () {
		$('input[name=id]').keyup(function () {
			var id = $('input[name=id]').val();
			
			$.ajax({
				url: 'join_IDCheck.jsp',
				data: {id: id},
				success: function (data) { // '1' or '0'
					var rowCount = parseInt(data);
					if (rowCount == 1) {
						$('#idCheckResult').html('중복된 아이디입니다.');
					} else {
						$('#idCheckResult').html('사용가능한 아이디입니다.');
					}
				}
			});
		});	
							
	});
	
	function checkPass(){
		var f= document.frm ;
		if(f.checkPassword.value!=f.password.value){
			document.getElementById("pwCheckResult").innerHTML="<font color='red'>비밀번호가 맞지 않습니다.</font>";
			return;
		}else{
			document.getElementById("pwCheckResult").innerHTML="<font color='green'>동일한 비밀번호 입니다.</font>";
		}
	}
	
	function checkReg(){
		var f = document.frm ;
		if(f.id.value==""){
			alert("아이디를 입력해주세요");
			f.id.focus();
			return;
		}

		else if(f.password.value==""){
			alert("비밀번호를 입력해주세요");
			f.password.focus();
			return;
		}else if(f.checkPassword.value!=f.password.value){
			alert("비밀번호가 맞지 않습니다.");
			f.checkPassword.focus();
			return;
		}else if(f.name.value==""){
			alert("이름을 입력하세요");
			f.name.focus();
			return;
		}else if(f.email.value==""){
			alert("이메일 주소를 입력하세요");
			f.email.focus();
			return;
		}else if(f.tel.value==""){
			alert("전화번호를 입력하세요");
			f.tel.focus();
			return;
		}else if(f.address.value==""){
			alert("주소를 입력하세요");
			f.address.focus();
			return;
		}
		f.submit();
	}
</script> 

</head>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<body>

	<div class="join">
		<h1 class="joinText">회원가입</h1>
		<form action="joinPro.jsp" method="post" name="frm">
			<table class="joinPage">
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="id" size="30"> 
					</td>
					<td>
						<span id="idCheckResult" style="font-size: 15px;">아이디를 입력하세요</span>
					</td>
				</tr>

				<tr>
					<td>패스워드</td>
					<td><input type=password name="password" size="30"></td>
				</tr>

				<tr>
					<td>패스워드 확인</td>
					<td><input type=password name="checkPassword" size="30" onkeyup="checkPass()"></td>
					<td><span id="pwCheckResult" style="font-size: 15px;"></span></td>
				</tr>

				<tr>
					<td>이름</td>
					<td><input type=text name="name" size="30"></td>
				</tr>
				
				<tr>
					<td>e-mail</td>
					<td><input type=text name="email" size="30"></td>
				</tr>

				<tr>
					<td>휴대폰</td>
					<td><input type=text name="tel" size="30"></td>
				</tr>

				<tr>
					<td>주소</td>
					<td><input type=text name="address" size="30"></td>
				</tr>

			</table>

			<table class="pInfo">
				<tr>
					<td>개인정보 보관기간</td>
				<tr>
			</table>

			<div class="ayear">
				<span> 
					<label>1년<input type="checkbox" value="1년" checked="checked"></label>
				</span> 
				<span> 
					<label>3년<input type="checkbox" value="3년"></label>
				</span> 
				<span> 
					<label>영구보관<input type="checkbox" value="영구보관"></label>
				</span>
			</div>

			<div class="jrButton">
				<input type="button" class="joinButton" value="가입하기" style="width: 170px; height: 50px;" onclick="checkReg()" >
				<input type="button" class="resetButton" value="취소" style="width: 170px; height: 50px;" onclick="location.href='join.jsp'">
			</div>


		</form>


	</div>

<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>	
</body>
</html>