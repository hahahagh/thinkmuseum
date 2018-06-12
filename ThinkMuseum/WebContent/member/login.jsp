<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/style.css">
<title>Insert title here</title>
</head>

<body>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<div class="login" align="center">
		<h1 class="loginText">로그인</h1>
		<form action="loginPro.jsp" method="post">
			<table class="joinPage">
				<tr>
					<td>아이디</td>
					<td><input type=text name="id" size="30" style="height: 20px;"></td>
				</tr>

				<tr>
					<td>패스워드</td>
					<td><input type=password name="password" size="30" style="height: 20px;"></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="keepLogin" value="yes" id="keepLogin">
					<label for="keepLogin">로그인 상태 유지</label>
					</td>
				</tr>

			</table>


			<div class="jrButton">
				<input type="submit" class="joinButton" name="submit" value="로그인" style="width: 100px; margin-right: 30px;">
				<input type="reset" class="resetButton" name="reset" value="취소" style="width: 100px; onclick="location.href='login.jsp'">
			</div>


		</form>


	</div>
<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>	
</body>

</html>