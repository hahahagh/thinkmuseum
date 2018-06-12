<%@page import="domain.Email"%>
<%@page import="email.MultiPartEmailSender"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="domain.MemberVO"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션값 가져오기
	String adminId = (String)session.getAttribute("id");
	// 세션 값 없으면 login.jsp
	if(adminId == null && !adminId.equals("admin")){
		response.sendRedirect("../member/login.jsp");
		return;
	}
	

	request.setCharacterEncoding("utf-8"); 
	
/////////////////////////////////////////////////////////
	String[] ids = (String[])session.getAttribute("ids");
	for (String emailId : ids) {
		System.out.println(emailId);
	}
	
	MemberDao dao = MemberDao.getInstance();
	
	List<MemberVO> list = new ArrayList<>();
	for (String id : ids) {
	MemberVO member = dao.getMember(id);
	list.add(member);
	}
	System.out.println("--------------------------------");
/////////////////////////////////////////////////////////
	
	// 업로드
		// 외부 라이브러리 설치 : http://www.servlets.com
		// com.oreilly.servlet => cos - ...zip 파일 다운
		// WebContent -> Web-INF -> lib -> cos.jar
		
		// 업로드 기능 객체 생성 - MultipartRequest
		// 1. request
		// 2. 업로드 할 폴더의 물리적 경로
		//    WebContent => upload 폴더 만들기
		String realPath = application.getRealPath("/attachFile");
		System.out.println(realPath);
		// 3. 최대 파일 크기 지정
		int maxSize = 1024 * 1024 * 5; //5MB
		
		// 4. 파일명 한글처리 utf-8
		
		// 5. 파일명이 동일 할 경우 이름변경 DefaultFileRenamePolicy()
		
		// MultipartRequest객체를 생성하면 그 즉시 업로드가 수행 됨
		MultipartRequest multi = 
		new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
		
		
		// 폼 파라미터 값 저장 = > 이메일 객체에 저장
		Email email = new Email();
		email.setSender(multi.getParameter("sender"));
		email.setSubject(multi.getParameter("subject"));
		email.setContent(multi.getParameter("content"));
		email.setRecipient(list);
	
		// 파일이름 => 자바빈에 저장
		// 원래 파일이름 
		System.out.println("원래파일이름: "+ multi.getOriginalFileName("fileName"));
		// 시스템에 올린 파일이름
		System.out.println("시스템에 올린 파일이름: " + multi.getFilesystemName("fileName"));
		email.setFileName(multi.getFilesystemName("fileName"));
		
		// MultiPartEmailSender 클래스 객체 생성
		MultiPartEmailSender sender = new MultiPartEmailSender();
		// 이메일 보내기 메서드
		sender.sendEmail(email, realPath);
				
		// 이동 글 목록
		response.sendRedirect("../admin/member_list.jsp");



%>