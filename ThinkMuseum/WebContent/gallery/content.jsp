<%@page import="dao.CommentDao"%>
<%@page import="java.util.List"%>
<%@page import="domain.Comment"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="domain.Painting"%>
<%@page import="dao.PaintingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/style.css">
<title>Insert title here</title>
<style type="text/css">
#admin_button input{
	margin-bottom: 30px;
	width: 200px;
	height: 60px;
}
</style>
<script src="../js/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function () {
	$('#replyImg').click(function () {
		$('#replyDiv').slideToggle();
	});
});

// 	function writeReply() {
// 		$('#comment_textbox').slideToggle();
// 		document.fr.comment.focus();
// 		$('#comment_button').show();
// 		$('#reply').slideToggle();
// 	}
	
</script>
</head>
<%
 	//num, pageNum가져오기
 	//쿼리스트링 형식 name = value
 	//getParameter()로 파라미터 가져올때 name 조차 없다면 null을 리턴함
 	//name은 있는데 값이 없을 때는 빈문자열("")이 리턴됨
 	//Integer num = request.getParameter("num");
 	
 	int num = Integer.parseInt(request.getParameter("num"));
 	String pageNum = request.getParameter("pageNum");
 
 	// DB객체 생성
 	PaintingDao dao = PaintingDao.getInstance();
 	CommentDao commentdao = CommentDao.getInstance();
 	Comment comment = new Comment();
 	// 조회수 1증가
 	dao.updateReadCount(num);
 	// 글내용 가져오기
 	Painting painting = dao.getPainting(num);
 	System.out.println("getPainting");
 	
 	// 날짜 형식 객체 준비
 	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
 	Timestamp timestamp = painting.getReg_date();
 	Date date = new Date(timestamp.getTime());
 	String strDate = sdf.format(date);
 	
 	// content 내용 줄바꿈 \r\n => <br>로 대체
 	String content ="";
 	if(painting.getContent() != null){
 		content = painting.getContent().replace("\r\n", "<br>");
 	}
 %>
 
 <%
	//세션값 가져오기
	String id = (String)session.getAttribute("id");
 	
	//우리가 원하는 페이지 글 가져오기
	// 한페이지당 보여줄 그림 개수
	int pageSize = 15;
	// 클라이언트가 전송하는 페이지 번호를 기준으로
	// 가져올 글의 시작행번호와 종료행 번호를 계산 하면 됨
	String strPageNum = request.getParameter("comment_pageNum");
	if (strPageNum == null || strPageNum.equals("")){
		strPageNum = "1";
	}
	int comment_pageNum = Integer.parseInt(strPageNum); //페이지 번호
	
	// 시작행번호 구하기 공식
	int startRow = (comment_pageNum -1) * pageSize + 1;
	// 종료행번호 구하기 공식
	int endRow = comment_pageNum * pageSize;
 	//원하는 댓글을 가져오는 메소드
 	List<Comment> list = null;
 	int totalRowCount = commentdao.getCommentCount(painting.getNum());
 		System.out.println("getCommentCount");
 	if(totalRowCount > 0){
 		list= commentdao.getComments(startRow, endRow, num);
 		System.out.println("getComments");
 	}
%>   



<body>
<!-- header -->
<jsp:include page="../inc/top.jsp"/>
<!-- 관리자만 보이는 버튼 -->	
	
	<%
		if (id != null) {

			if (id.equals("admin")) {
				System.out.println("관리자 인증");
				
	%>
		<div align="center" id="admin_button">
		<input type="button" value="작품수정" id="button"
		onclick="location.href='../admin/update_painting.jsp?num=<%=painting.getNum()%>&pageNum=<%=pageNum%>'">
		<input type="button" value="작품삭제" id="button"
		onclick="location.href='../admin/delete_painting.jsp?num=<%=painting.getNum()%>&pageNum=<%=pageNum%>'">
		</div>
	<%
			}
			
		} 
	%>
	

	<div align="center">
		<img alt="vincent" src="../upload/<%=painting.getFilename() %>">
	</div><br><br>
	
	<div>
		<table align="center">
			<tr>
				<td width="350" style="font-size: 1.3em"><b>< <%=painting.getTitle() %> ></b></td>
				<td width="150"><b><%=painting.getArtist() %></b></td>	
			</tr>
			<tr>
				<td><%=painting.getFin_year() %>년 작</td>
				<td height="50">size: <%=painting.getPainting_size() %></td>
			</tr>
			<tr>
			<td colspan="2" style="width: 650px;">
				<%=content %>
			</td>
			<tr>
		</table>
	</div><br><br><br>
	
	<div align="center">
		<span>
		<%=painting.getLikecount()%>&nbsp&nbsp<b>Like</b> <img src="../images/like.png" width="20" height="20" 
		onclick="location.href='like.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"> 
		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		</span>
		<span id="replyImg">
		<b>Reply</b> <img src="../images/re1.jpg" width="20" height="20" class="reply_icon">
		</span>
		<br><br>
	</div>
	<!-- 리플달기 -->
	<div align="center" id="replyDiv" style="display: none;">
		<form action="register_comment.jsp?num=<%=num%>&pageNum=<%=pageNum%>" name="fr" method="post">
		<input type="hidden" name="member_id" value="<%=id%>">
		<input type="hidden" name="painting_num" value="<%=painting.getNum()%>">
		<textarea rows="4" cols="100" name="content" id="comment_textbox" ></textarea>
		<input type="submit" value="등록" id="comment_button" >
		</form>
	</div>
 	<!-- 댓글 뿌려지는 곳 -->
	<div>
	<table align="center">
		<%
		if(list.size() > 0){
			for(Comment co : list){
				Timestamp timestamp_comment = co.getReg_date();
				Date date_comment = new Date(timestamp_comment.getTime()); 
				%>
				<tr>
					<td width="560"><b><%=co.getMember_id()%></b></td>
					<td width="100"><%=sdf.format(date_comment) %></td>
				</tr>
				<tr>
					<td><%=co.getContent()%></td>
					<%
				if(id !=null){
							
					if(id.equals(co.getMember_id())){
						%>
						<td>
						<button onclick="location.href='../gallery/delete_comment.jsp?num=<%=num %>&pageNum=<%=pageNum %>&comment_num=<%=co.getComment_num()%>'">댓글삭제</button>
						<td>
						<%
					}
				}
					%>
				</tr>
				<tr>
					<td colspan="2">
					-----------------------------------------------------------------------------------------------------
					</td>
				</tr>
				<%
				
			}
		} else {
			%>
			<tr>
				<td colspan="2">댓글 없음</td>
			</tr>
			<% 
		}
		%>
	</table>
	
	</div> 
	<div align="center" style="margin: 30px;">
	<button onclick="location.href='../gallery/gallery.jsp?pageNum=<%=pageNum%>'" style="width: 100px; height: 30px; margin: 30px;">Gallery</button>
	</div>
<%-- <div class="next_page">
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
	int startPage = (comment_pageNum/pageBlock - (comment_pageNum%pageBlock == 0 ? 1:0)) * pageBlock + 1;
	// 화면에 보여줄 "페이지 블록 범위내의 끝번호" 구하기
	int endPage = startPage + pageBlock -1;
		if(endPage > pageCount) {
			endPage = pageCount;
		}
	
		// [이전]
		if(startPage > pageBlock){
		%>
		<a href="content.jsp?pageNum=<%=startPage - pageBlock%>">Prev</a>
		<%
		}
	
		// 1~10 페이지블록 범위 출력
		for(int i=startPage; i<=endPage; i++){
			%>
			<a href="gallery.jsp?pageNum=<%=i %>">		
			<%=i %>
			</a>
			<% 
		}
		
		//[다음]
		if(endPage < pageCount){
			%>
			<a href="gallery.jsp?pageNum=<%=startPage + pageBlock%>">next</a>
			<%
		}
	}
%>  

</div>--%>
	
	<!-- footer -->
<jsp:include page="../inc/bottom.jsp"/>		
</body>
</html>