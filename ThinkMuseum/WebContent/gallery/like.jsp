<%@page import="domain.MemberVO"%>
<%@page import="domain.Like"%>
<%@page import="dao.LikeDao"%>
<%@page import="domain.Painting"%>
<%@page import="dao.PaintingDao"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id == null){
	response.sendRedirect("../member/login.jsp");
		return;
	}
// num 값 받아오기
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
// dao 객체 생성
	MemberDao memberDao = MemberDao.getInstance();
	PaintingDao paintingDao = PaintingDao.getInstance();
	LikeDao likeDao = LikeDao.getInstance();
	// VO 객체생성
	MemberVO member = new MemberVO();
	member = memberDao.getMember(id);
	Painting painting = new Painting();
	painting = paintingDao.getPainting(num);
	int checkNum =likeDao.isLikePainting(id, num);
	System.out.println(checkNum);
	if(checkNum == 0){
		paintingDao.updateLikeCount(num);
		likeDao.registerLike(num, id);
	} else {
		
	}
	
	
	response.sendRedirect("../gallery/content.jsp?num="+num+"&pageNum="+pageNum);
%>
