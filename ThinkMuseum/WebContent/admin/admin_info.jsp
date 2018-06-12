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
	background-color: #E24C55;
	width: 500px;
	height: 50px;
}

#para p a {
	text-decoration: none;
	color: white;
}
</style>

</head>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<body>

<%
	String id = (String)session.getAttribute("id");
	if(id == null){
	response.sendRedirect("../member/login.jsp");
		return;
	}
	
%>


<div align="center">
<b style="font-size: 50px; color: #7E3D15;">&lt &nbsp 관리자 페이지 &nbsp &gt</b><br><br>

</div>
<div id="para" align="center">
<p><a href="../main/main.jsp">메인화면</a></p>
<p><a href="../member/update.jsp">회원정보 수정</a></p>

<%
	if(id.equals("admin")){
	%>
	<p><a href="../admin/register_painting.jsp">작품등록</a></p>
	<p><a href="../admin/member_list.jsp">회원목록</a></p>
	<p><a href="../chart/dataChart.jsp">데이터 차트</a></p>
	<%	
	}
%>

</div>


</body>
<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>	
</html>