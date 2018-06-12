<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.Painting"%>
<%@page import="dao.PaintingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="../css/style.css">
<title>Insert title here</title>
<script src="../js/jquery-3.2.1.min.js"></script>
<style type="text/css">

</style>
</head>
<body>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>

<!-- 갤러리 -->
<%
	//DB객체 생성
	PaintingDao dao = PaintingDao.getInstance();
	
	// 우리가 원하는 페이지 글 가져오기
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
	
	// 검색 카테고리 , 검색어 파라미터 값 가져오기 
	String categori = request.getParameter("categori");
	String search = request.getParameter("search");
	
	// 원하는 페이지 글을 가져오는 메소드
	List<Painting> list = null;
	int totalRowCount = 0;
	if(categori.equals("title")){
		totalRowCount = dao.getPaintingCountByTitle(search);
	}else if(categori.equals("artist")){	
		totalRowCount = dao.getPaintingCountByArtist(search);
	}
	
	if(totalRowCount > 0){
		if(categori.equals("title")){
			list =dao.getPaintingsByTitle(startRow, endRow, search);
		}else if(categori.equals("artist")){
			list =dao.getPaintingsByArtist(startRow, endRow, search);
		}
	}
	
%>

<div id="table_search" align="center">
<form action="gallery_search.jsp">
<select name="categori" style="font-size: 18px;">
	<option value="title">작품명</option>
	<option value="artist">작가</option>
</select>
<input type="text" name="search" class="input_box" onfocus="this.select()" size="40" style="font-size: 18px;">
<input type="submit" value="search" class="btn" style="font-size: 18px;">
</form>
</div>

	<%
	if(list != null && list.size() > 0){
		for(Painting painting : list){
			%>
		<div style="width: 280px; height: 360px; float: left; margin: 20px; margin-bottom: 50px; background-color: #444444" >
			<a href="content.jsp?num=<%=painting.getNum()%>&pageNum=<%=pageNum%>">
			<img src="../upload/<%=painting.getFilename()%>" class="img" style="width: 100%; height: 90%; margin-bottom: 15px;">
			</a>
		<div style="width: 280px; background-color: #444444; color:  #A6A6A6;">
			<span style="margin-bottom: 30px; padding-bottom: 20px;">
			<b style="color:#F6F6F6;"> &lt <%=painting.getTitle()%> &gt </b> <br>
			- <%=painting.getArtist()%><br>
		</span>	
		</div>		
		</div>	
			<%
		}
	}else {
		%>검색결과 없음<% 
	}
	%>


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
		<a href="gallery.jsp?pageNum=<%=startPage - pageBlock%>"><img src="../images/pre.png" style="width: 20px; height: 20px;"></a>
		<%
		}
	
		// 1~10 페이지블록 범위 출력
		for(int i=startPage; i<=endPage; i++){
			%>
			<a href="gallery.jsp?pageNum=<%=i %>" style="text-decoration: none; font-size: 25px;">		
			<%=i %>
			</a>
			<% 
		}
		
		//[다음]
		if(endPage < pageCount){
			%>
			<a href="gallery.jsp?pageNum=<%=startPage + pageBlock%>"><img src="../images/next.png" style="width: 20px; height: 20px;"></a>
			<%
		}
	}
%>

</div>
<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>