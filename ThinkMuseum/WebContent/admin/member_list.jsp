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
<link type="text/css" rel="stylesheet" href="../css/style.css">
<title>Insert title here</title>

<script type="text/javascript">
	function winopen() {
		//id란이 공백이면 '아이디를 입력하세요' 포커스 주기
		if(document.frm.ids.value == null){
			alert('메일을 보낼 회원을 선택하세요');
			document.frm.ids.focus();
			return;
		}
		//창열기 join_IDCheck.jsp width = 400, height = 200
		var userid = document.frm.id.value; 
		window.open('send_emailForm.jsp?','','width = 500, height = 600');
		
		document.frm.submit();
	
	}
</script> 
</head>
<%
	//DB객체 생성
	MemberDao dao = MemberDao.getInstance();
	
	// 우리가 원하는 페이지 멤버리스트 가져오기
	// 한페이지당 보여줄 회원 명수
	int pageSize = 10;
	System.out.println(pageSize);
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


<body>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<div align="center" style="margin: 30px;">
<h1>회원목록</h1>
<form action="send_emailForm.jsp" method="post" name="frm">
<table border="1" style="margin-bottom: 30px;">
<tr>
	<td>선택</td>
	<td>아이디</td>
	<td>이름</td>
	<td>이메일</td>
	<td>가입날짜</td>
</tr>

<%
	if(list != null && list.size() > 0){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		%>
		
		<%
		for (MemberVO member: list){
				Timestamp timestamp = member.getReg_date();
				Date date = new Date(timestamp.getTime()); 
				
			%>
				<tr>
					<td><input type="checkbox" name="ids" value="<%=member.getId() %>"></td>
					<td><a href="../admin/member_info.jsp?id=<%=member.getId() %>&pageNum=<%=pageNum%>"><%=member.getId() %></a></td>
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
				<td colspan="4">회원 없음</td>
			</tr>
		<% 
	}
%>	
</table>
<input type="submit" value="메일보내기">
<!-- <input type="button" value="Email보내기" class="" onclick="winopen()"> -->
</form>
</div>

<div class="next_page" align="center" style="margin-top: 30px; margin-bottom: 15px;">
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
		<a href="member_list.jsp?pageNum=<%=startPage - pageBlock%>"><img src="../images/pre.png" style="width: 20px; height: 20px;"></a>
		<%
		}
		
		// 1~10 페이지블록 범위 출력
		for(int i=startPage; i<=endPage; i++){
			%>
			
			<a href="member_list.jsp?pageNum=<%=i %>" style="text-decoration: none; font-size: 25px;">		
			<%=i %>
			</a>
			
			<% 
		}
		
		//[다음]
		if(endPage < pageCount){
			%>
			<a href="member_list.jsp?pageNum=<%=startPage + pageBlock%>"><img src="../images/next.png" style="width: 20px; height: 20px;"></a>
			<%
		}
	}
%>

</div>
<div align="center">
</div>

<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>
</body>
</html>