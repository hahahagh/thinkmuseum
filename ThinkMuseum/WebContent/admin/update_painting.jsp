<%@page import="domain.Painting"%>
<%@page import="dao.PaintingDao"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="../css/style.css">


 <%
	//세션값 가져오기
	String id = (String)session.getAttribute("id");
	// 세션 값 없으면 login.jsp로 이동
	if(id == null || ! id.equals("admin")){
		response.sendRedirect("../member/login.jsp");
		return;
	}
	
	// int num , String pageNum
		int num = Integer.parseInt(request.getParameter("num").trim());
	 	String pageNum = request.getParameter("pageNum").trim();
	 
	// DB객체 생성
	PaintingDao dao = PaintingDao.getInstance();
	Painting painting = dao.getPainting(num);
 %>
 
</head>
<body>
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->


<div align="center">
<h1>갤러리 작품수정(관리자 권한)</h1>
<form action="updatePaintingPro.jsp?pageNum=<%=pageNum%>" method="post" name="frm" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">
<tr><th>작품명</th>
	<td><input type="text" name="title" value="<%=painting.getTitle()%>"></td><tr>
<tr><th>작가</th>
    <td><input type="text" name="artist" value="<%=painting.getArtist()%>"></td><tr>
<tr><th>크기</th>
    <td><input type="text" name="painting_size" value="<%=painting.getPainting_size()%>"></td><tr>
<tr><th>작품년도</th>
    <td><input type="text" name="fin_year" value="<%=painting.getFin_year()%>"></td><tr>  
<tr><th>파일</th>
    <td>
    <input type="file" name="filename" value="<%=painting.getFilename()%>">
    <input type="hidden" name="oldfilename" value="<%=painting.getFilename()%>">
    </td><tr>  
<tr><th>상세내용</th>
	<td><textarea rows="13" cols="60" name="content"><%=painting.getContent()%></textarea><tr>
</tr>
</table>

<div id="table_search">
<input type="submit" value="작품수정 완료" class="btn">
<input type="reset" value="재작성" class="btn">
<input type="button" value="갤러리" class="btn" onclick="location.href='gallery.jsp'">
</div>
</form>
</div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</body>
</html>