
<%@page import="dao.MemberDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	alert("가입완료");
	location.href = '../main/main.jsp';
</script>
<%
//한글처리
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="domain.MemberVO"/>  
<jsp:setProperty property="*" name="member"/>  
    
<%	


	//파라미터 값 가져오기
	
	String checkId = request.getParameter("checkId");
	String checkPassword = request.getParameter("checkPassword");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	member.setReg_date(reg_date);
	
	//DB접송용 Dao객체 생성
	MemberDao dao = MemberDao.getInstance();
	dao.insertMember(member);
	
%>