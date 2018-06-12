<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/style.css">
<title>Insert title here</title>
</head>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<body>
<div class="join" align="center">
		<h1 class="joinText">회원탈퇴</h1>
		<form action="deletePro.jsp" method="post">
			<table class="joinPage">

				<tr>
					<td>패스워드</td>
					<td><input type=password name="password" size="30" style="height: 25px;"></td>
				</tr>
				
				<tr>
					<td><input type="checkbox" name="deletechk"> 회원탈퇴에 동의합니다</td>
				</tr>

			</table>


			<div align="center">
				<input type="submit" class="joinButton" name="submit" value="탈퇴하기" style="width: 100px; margin-right: 50px;">
				<input type="reset" class="resetButton" name="reset" value="취소" onclick="location.href='../member/login.jsp'" style="width: 100px;">
			</div>


		</form>


	</div>

</body>
<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>	
</html>