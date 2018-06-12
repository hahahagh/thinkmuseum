<%@page import="domain.MemberVO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	//DB객체 생성
	MemberDao dao = MemberDao.getInstance();
	
	// 우리가 원하는 페이지 멤버리스트 가져오기
	// 한페이지당 보여줄 회원 명수
	int pageSize = 5;
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
	List<MemberVO> list = null;
	int totalRowCount = dao.getMemberCount();
	if(totalRowCount > 0){
		list = dao.getMembers(startRow, endRow);
	}
	
%>
<h1>회원목록</h1>
<body>
<table border="1">
<tr>
	<td>번호</td>
	<td>아이디</td>
	<td>이름</td>
	<td>이메일</td>
	<td>가입날짜</td>
</tr>

<%
	if(list.size() > 0){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		%>
		
		<%
		for (MemberVO member: list){
				Timestamp timestamp = member.getReg_date();
				Date date = new Date(timestamp.getTime()); 
			%>
				<tr>
					<td></td>
					<td><a href="../member/member_info.jsp?id=<%=member.getId() %>&pageNum=<%=pageNum%>"><%=member.getId() %></a></td>
					<td width="250" class="left">
						<%=member.getName() %>
					</td>
					<td><%=member.getEmail() %></td>
					<td><%=sdf.format(date) %></td>
				</tr>
			
			<% 
		}

	} else {
		%>
			<tr>
				<td colspan="6">게시판 글 없음</td>
			</tr>
		<% 
	}
%>	
</table>
<input type="button" value="홈으로" onclick="location.href='../main/main.jsp'">
</body>
</html>