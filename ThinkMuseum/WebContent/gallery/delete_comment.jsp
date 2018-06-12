<%@page import="dao.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	CommentDao commentDao = CommentDao.getInstance();
	commentDao.deleteComment(comment_num);
%>
<script>
	alert('댓글이 삭제되었습니다.');
	location.href='../gallery/content.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
</script>
<body>

</body>
</html>