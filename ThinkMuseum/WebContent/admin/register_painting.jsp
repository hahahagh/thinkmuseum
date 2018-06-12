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
<style>
#register_table input {
	width: 300px;
	height: 30px;
	margin-bottom: 10px;
}
h1 {
	color: #FF5E00;
}
</style>


 <%
	//세션값 가져오기
	String id = (String)session.getAttribute("id");
	// 세션 값 없으면 login.jsp로 이동
	if(id == null || ! id.equals("admin")){
		response.sendRedirect("../member/login.jsp");
		return;
	}
 %>
 
</head>
<body>
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->

<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->

<!-- 왼쪽메뉴 -->

<!-- 게시판 -->


<h1 align="center">&lt 갤러리에 작품등록(관리자 권한) &gt</h1>
<div align="center" style="margin-bottom: 30px;">
<form action="registerPaintingPro.jsp" method="post" name="frm" enctype="multipart/form-data">
<table id="register_table">
<tr><th>작품명</th>
	<td><input type="text" name="title"></td><tr>
<tr><th>작가</th>
    <td><input type="text" name="artist"></td><tr>
<tr><th>크기</th>
    <td><input type="text" name="painting_size"></td><tr>
<tr><th>작품년도</th>
    <td><input type="text" name="fin_year"></td><tr>  
<tr><th>파일</th>
    <td><input type="file" name="filename"></td><tr>  
<tr><th>상세내용</th>
	<td><textarea rows="13" cols="60" name="content"></textarea><tr>
</tr>
</table>
<input type="submit" value="작품등록" class="btn">
<input type="reset" value="재작성" class="btn">
</form>
</div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</body>
</html>