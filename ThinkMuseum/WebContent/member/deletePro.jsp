
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
	response.sendRedirect("loginForm.jsp");
	return;
	}
	
	//패스워드 가져오기
	String password = request.getParameter("password");
	String deletechk = request.getParameter("deletechk");
	// 한글처리
	request.setCharacterEncoding("utf-8");
	
	//Dao 객체 생성
	MemberDao dao = MemberDao.getInstance();
	int check = dao.deleteMember(id, password, deletechk);
	System.out.println(deletechk);
	System.out.println(check);
	if(deletechk !=null){
		if(check == 1){
			//아이디 삭제하고 세션 죽이기
			session.invalidate();
			%>
			<script>
				alert('회원탈퇴 되었습니다.');
				location.href = '../member/login.jsp';
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
	}else {
		%>
		<script>
			alert('회원탈퇴에 동의해주세요');
			history.back();
		</script>	
		<%
	}
	
%>

