<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Painting"%>
<%@page import="java.util.List"%>
<%@page import="dao.PaintingDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	PaintingDao dao = PaintingDao.getInstance();
	JSONArray jsonArray = dao.getPaintingCountByArtist();
	System.out.println("jsonArray : " + jsonArray);
	out.print(jsonArray); // 클라이언트에  JSON배열 출력
%>