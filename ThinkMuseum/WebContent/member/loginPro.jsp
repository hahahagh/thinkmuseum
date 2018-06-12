<%@page import="module.MySessionBindingListener"%>
<%@page import="dao.MemberDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//폼 id password 가져오기
	String id = request.getParameter("id");	
	String password =request.getParameter("password");
	String keepLogin = request.getParameter("keepLogin");
	System.out.println("keepLogin: " + keepLogin);
	
	// DB 객체 생성
	MemberDao dao = MemberDao.getInstance();
	int check = dao.userCheck(id, password);
	
	// check == 1 : 로그인 인증 main.jsp이동
	// check == 0 : 패스워드 틀림 뒤로 이동	
	// check == -1: 아이디 없음 뒤로 이동
	
	 if(check == 1){
		//아이디 있음
			session.setAttribute("id",id);
			session.setAttribute("bindListener", new MySessionBindingListener());
			response.sendRedirect("../index.jsp?id=" + id + "&keepLogin=" + keepLogin);
	 } else if(check == 0) {
		 %>
			<script>
				alert('패스워드가  틀림');
				//location.href = 'loginForm.jsp';
				history.back(); // 브라우져 뒤로가기
			</script>
		 <%
	 } else if(check == -1){
		%>
		<script>
			alert('해당 아이디 없음');
			//location.href = 'loginForm.jsp';
			history.back(); // 브라우져 뒤로가기
		</script>
		<%
	 }
	 
	 
%>