<%@page import="domain.Painting"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Like"%>
<%@page import="dao.LikeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/style.css">
<title>Insert title here</title>
<style type="text/css">
.img {
 width: 100%;
 height: 85%;
 float: left;
 margin-bottom: 30px;
}
h1 {
	text-align: center;
}
</style>
</head>
<%
String id = (String)session.getAttribute("id");

LikeDao likedao = LikeDao.getInstance();


%>

<%
	//우리가 원하는 페이지 글 가져오기
	// 한페이지당 보여줄 그림 개수
	int pageSize = 15;
	// 클라이언트가 전송하는 페이지 번호를 기준으로
	// 가져올 글의 시작행번호와 종료행 번호를 계산 하면 됨
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum == null || strPageNum.equals("")){
		strPageNum = "1";
	}
	int pageNum = Integer.parseInt(strPageNum); //페이지 번호
	
	// 시작행번호 구하기 공식
	int startRow = (pageNum -1) * pageSize + 1;
	// 종료행번호 구하기 공식
	int endRow = pageNum * pageSize;
	
	// 원하는 페이지 글을 가져오는 메소드
	List<Painting> list = null;
	int totalRowCount = likedao.getPaintingCount(id);
	if(totalRowCount > 0){
		list = likedao.getLikePaintings(id);
	}
%>

<body>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<h1>관심작품 리스트</h1>
	<%
	if(list !=null && list.size() > 0){
		for(Painting painting : list){
			%>
		<div style="width: 280px; height: 400px; float: left; margin: 20px; margin-bottom: 50px;">
			<a href="../gallery/content.jsp?num=<%=painting.getNum()%>&pageNum=<%=pageNum%>">
			<img src="../upload/<%=painting.getFilename()%>" class="img"><br>
			</a>
			<span style="margin-bottom: 30px;">
			<b> &lt; <%=painting.getTitle()%> &gt; </b> <br>
			- <%=painting.getArtist()%>
			</span>	
			
		</div>	
			<%
			
		}
	}else {
		%>관심 작품 없음<% 
	}
	%>
	
	<!-- 페이징 처리 -->

<div class="next_page" style="margin-top: 30px; margin-bottom:30px; display: block;">
<%
	if(totalRowCount >0){
	// 페이지 블록 만들기
	// 전체글개수 가져오기 메소드 호출
	// 전체 페이지 블록 갯수 구하기
	// 글 개수가 50개이고 한페이지에 보여지는 글이 10개 => 50/10 = 5페이지
	// 글 개수가 52개이고 한페이지에 보여지는 글이 10개 => 52/10 = 몫5 + 나머지2 = 6페이지
	int pageCount = totalRowCount/pageSize + (totalRowCount%pageSize == 0 ? 0 : 1);
	
	// 한 화면에 보여 줄 페이지 블록 개수 설정
	int pageBlock = 3;
	
	// 화면에 보여줄 "페이지 블록 범위내의 시작번호" 구하기
	// 1~10 , 11~20 , 21~30
	// 1~10 => 1 	11~20 => 2	 21~30=>3
	int startPage = (pageNum/pageBlock - (pageNum%pageBlock == 0 ? 1:0)) * pageBlock + 1;
	// 화면에 보여줄 "페이지 블록 범위내의 끝번호" 구하기
	int endPage = startPage + pageBlock -1;
		if(endPage > pageCount) {
			endPage = pageCount;
		}
	
		// [이전]
		if(startPage > pageBlock){
		%>
		<a href="../gallery/gallery.jsp?pageNum=<%=startPage - pageBlock%>">Prev</a>
		<%
		}
	
		// 1~10 페이지블록 범위 출력
		for(int i=startPage; i<=endPage; i++){
			%>
			<a href="../gallery/gallery.jsp?pageNum=<%=i %>">		
			<%=i %>
			</a>
			<% 
		}
		
		//[다음]
		if(endPage < pageCount){
			%>
			<a href="../gallery/gallery.jsp?pageNum=<%=startPage + pageBlock%>">next</a>
			<%
		}
	}
%>

</div>
<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>	
</body>
</html>