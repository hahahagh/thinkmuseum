<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//세션값 가져오기
	String id = (String)session.getAttribute("id");
	
%>    
<style>
.menu li a:hover {
	background-color: #212121;
}
</style>
<header>
	<div class="boxA" style="background-color: #747474;">
		<div class="box1">
			<div class="site">
				<h1 style="color:#F6F6F6; ">
					<a href="../main/main.jsp" style="color:#F6F6F6; ">생각의 미술관</a>
				</h1>
			</div>
		</div>
	
		<div class="box2">
			<nav class="menu">
				<ul>
					<li><a href="../main/main.jsp" style="color:#F6F6F6; ">홈</a></li>
					<li><a href="../gallery/gallery.jsp" style="color:#F6F6F6; ">작품</a></li>
						<% 
					if(id != null){
						
						if(id.equals("admin")){
						%>
						<li><a href="../admin/admin_info.jsp" style="color:#F6F6F6;"><b><%=id %>님</b></a></li>
						<%	
						}else {
						%>
						<li><a href="../member/info.jsp" style="color:#F6F6F6;"><b><%=id %>님</b></a></li>
						<%	
						}
						%>
						<li><a href="../member/logout.jsp" style="color:#F6F6F6;">로그아웃</a></li>
						<% 
					} else {
						%>
						<li><a href="../member/login.jsp" style="color:#F6F6F6;">로그인</a></li>
						<li><a href="../member/join.jsp" style="color:#F6F6F6;">회원가입</a></li>
						<% 
					}
					%>	
					
					
				</ul>
			</nav>
		</div>
	</div>
</header>
