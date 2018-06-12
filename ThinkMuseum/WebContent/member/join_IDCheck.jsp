<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");

	MemberDao dao = MemberDao.getInstance();
	int rowCount = dao.idCheck(id);
	System.out.println(rowCount); // "1"
%>
<%=rowCount %>