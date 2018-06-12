<%@page import="domain.Painting"%>
<%@page import="dao.PaintingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	PaintingDao dao = PaintingDao.getInstance();
	Painting painting = new Painting();
	painting = dao.getPainting(num);
	dao.deletePainting(num);
%>
<script>
	alert('<%=painting.getTitle()%>이 삭제되었습니다.');
	location.href='../gallery/gallery.jsp?pageNum=<%=pageNum%>';
</script>

</head>
<h1>작품삭제 페이지(관리자권한)</h1>
<body>

</body>
</html>