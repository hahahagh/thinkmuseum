<%@page import="dao.MemberDao"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	if(id == null){
	response.sendRedirect("../member/loginForm.jsp");
	}
	
	// 한글처리
	request.setCharacterEncoding("utf-8");
%>	

<jsp:useBean id="member" class="domain.MemberVO"/>
<jsp:setProperty property="*" name="member"/>
	
<%	
	MemberDao dao = MemberDao.getInstance();
	int check = dao.updateMember(member);
	
	if(check == 1){
		%>
		<script>
			alert('수정성공');
			location.href = '../main/main.jsp';
		</script>	
		<%
	} else {
		%>
		<script>
			alert('패스워드 틀림');
			history.back();
		</script>	
		<%
	}
	
%>