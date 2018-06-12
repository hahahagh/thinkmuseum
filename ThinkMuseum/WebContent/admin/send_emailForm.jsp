<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function check() {
		//if(document.fr.name.value == ''){}
		if(document.fr.password.value.length == 0 ){
			alert('비밀번호를 입력하세요');
			document.fr.password.focus();
			return false;
		}
		if(document.fr.subject.value.length == 0 ){
			alert('글제목을 입력하세요');
			document.fr.subject.focus();
			return false;
		}
		if(document.fr.content.value.length == 0 ){
			alert('글내용을 입력하세요');
			document.fr.content.focus();
			return false;
		}
		
	}
</script>

</head>
<body>
<%
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null){
		pageNum = "1";
	}
	String id = (String)session.getAttribute("id");
	
 	String[] ids = request.getParameterValues("ids");
	//request.setAttribute("ids", ids);
	session.setAttribute("ids", ids);
	

%>
<div align="center">
<h1>회원에게 Email보내기(관리자)</h1>
<form action="send_email.jsp" method="post" name="fr" onsubmit="return check()" enctype="multipart/form-data">
<%
// for (String emailId : ids) {
	%>
<%-- 	<input type="hidden" name="ids" value="<%=emailId %>"> --%>
	<%
// }
%>
	<table border="1">
		<tr>
			<th>글쓴이</th>
			<td><input type="text" name="sender" value="<%=id%>"></td>
		</tr>
		<tr>
			<th>패스워드</th>
			<td><input type="password" name="password"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="subject"></td>
		</tr>
		<tr>
			<th>파일</th>
			<td><input type="file" name="fileName"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="13" cols="40" name="content"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="Email보내기">
				<input type="reset" value="다시쓰기">
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>