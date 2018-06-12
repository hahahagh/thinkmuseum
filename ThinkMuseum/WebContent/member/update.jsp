<%@page import="domain.MemberVO"%>
<%@page import="dao.MemberDao"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/style.css">
<title>Insert title here</title>
<style>
# frm table{
	margin-top: 100px;
}

#frm table input{
 height: 30px;
 width: 300px;
 margin-bottom: 10px;
 margin-left: 10px;
}

#frm table td input {
	text-align: center;
	margin-left: 10px;
}
</style>

</head>
<%
	String id = (String)session.getAttribute("id");
	if(id == null){
	response.sendRedirect("loginForm.jsp");
		return;
	}
	
	MemberDao dao = MemberDao.getInstance();
	MemberVO member = dao.getMember(id);
	
%>

<body>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>

<div align="center" style="margin-top: 30px">
<b style="font-size: 50px;">회원정보 수정</b><br><br>
<form action="updatePro.jsp" method="post" id="frm">
	<table align="center">
	<tr>
		<td>아이디 : </td>
		<td><input type="text" name="id" value="<%=member.getId() %>" readonly><br></td>
	</tr>
	<tr>
		<td>패스워드 : </td>
		<td><input type="password" name="password"><br></td>
	</tr>
	<tr>
		<td>이름 : </td>
		<td><input type="text" name="name" value="<%=member.getName()%>"><br></td>
	</tr>
	<tr>
		<td>이메일 : </td>
		<td><input type="email" name="email" value="<%=member.getEmail()%>"><br></td>
	</tr>
	<tr>
		<td>전화번호 : </td>
		<td><input type="text" name="tel" value="<%=member.getTel()%>"><br></td>
	</tr>
	<tr>
		<td>주소 : </td>
		<td><input type="text" name="address" value="<%=member.getAddress()%>"><br></td>
	</tr>
	</table>
<div align="center">
<input type="submit" value="수정하기" style="margin-bottom: 30px; width: 100px; height: 30px;">
</div>
</form>
</div>

<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>	
</body>
</html>