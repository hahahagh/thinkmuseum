<%@page import="domain.MemberVO"%>
<%@page import="dao.MemberDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.DriverManager"%>
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
<style type="text/css">
#para p {
	text-decoration: none;
	font-size: 30px;
	text-align: center;
	background-color: #00D8FF;
	width: 500px;
	height: 50px;
}

#para p a {
	text-decoration: none;
	color: white;
}
</style>
</head>
<body>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<%
	String id = (String)session.getAttribute("id");
	if(id == null){
	response.sendRedirect("../member/login.jsp");
		return;
	}
	
	//DB객체 생성
	MemberDao dao = MemberDao.getInstance();
	
	MemberVO member = dao.getMember(id);
%>


<div align="center">
<b style="font-size: 50px; color: #001541;">회원정보 조회</b><br><br>
아이디 : <%=member.getId() %> <br>
패스워드 : <%=member.getPassword() %><br>
이름 : <%=member.getName() %> <br>
가입날짜 : <%=member.getReg_date() %> <br>
이메일 : <%=member.getEmail() %> <br>
전화번호 : <%=member.getTel() %> <br>
주소 : <%=member.getAddress() %> <br>
</div>
<div id="para" align="center">
<p><a href="../main/main.jsp">메인화면</a></p>
<p><a href="../member/update.jsp">회원정보 수정</a></p>
<p><a href="../member/delete.jsp">회원탈퇴</a></p>
<p><a href="../member/likeList.jsp">내 관심 작품</a></p>
</div>

<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>	
</body>
</html>