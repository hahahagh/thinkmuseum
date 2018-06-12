<%@page import="domain.Comment"%>
<%@page import="dao.CommentDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//세션값 가져오기
	String id = (String)session.getAttribute("id");
	// 세션 값 없으면 login.jsp
	if(id == null){
		response.sendRedirect("../member/login.jsp");
		return;
	}
	

	request.setCharacterEncoding("utf-8"); 
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
%>
	// comment 객체생성
	<jsp:useBean id="comment" class="domain.Comment"/>
	<jsp:setProperty property="*" name="comment"/>
<%


	// reg_date, ip setter메서드로 값저장
	comment.setReg_date(new Timestamp(System.currentTimeMillis()));
	comment.setIp(request.getRemoteAddr());
	comment.setReadcount(0);
	
	
	// 게시판 Dao객체 생성
	CommentDao dao = CommentDao.getInstance();
	// 메서드 호출 insertBoard(boardBean)
	dao.registerComment(comment);
	// 이동 글목록 list.jsp
	response.sendRedirect("content.jsp?num="+num+"&pageNum="+pageNum);
	
%>