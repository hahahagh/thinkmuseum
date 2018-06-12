
<%@page import="dao.PaintingDao"%>
<%@page import="domain.Painting"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
	//세션값 가져오기
	String id = (String)session.getAttribute("id");
	// 세션 값 없으면 login.jsp로 이동
	if(id == null || ! id.equals("admin")){
		response.sendRedirect("../member/login.jsp");
		return;
	}

	// 업로드
	// 외부 라이브러리 설치 : http://www.servlets.com
	// com.oreilly.servlet => cos - ...zip 파일 다운
	// WebContent -> Web-INF -> lib -> cos.jar
	
	// 업로드 기능 객체 생성 - MultipartRequest
	// 1. request
	// 2. 업로드 할 폴더의 물리적 경로
	//    WebContent => upload 폴더 만들기
	String realPath = application.getRealPath("/upload");
	System.out.println(realPath);
	// 3. 최대 파일 크기 지정
	int maxSize = 1024 * 1024 * 5; //5MB
	
	// 4. 파일명 한글처리 utf-8
	
	// 5. 파일명이 동일 할 경우 이름변경 DefaultFileRenamePolicy()
	
	// MultipartRequest객체를 생성하면 그 즉시 업로드가 수행 됨
	MultipartRequest multi = 
	new MultipartRequest(request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	
	// 자바빈 객체 생성
	Painting painting = new Painting();
	// 폼 파라미터 값 저장 = > 자바빈에 저장
	painting.setArtist(multi.getParameter("artist"));
	painting.setTitle(multi.getParameter("title"));
	painting.setContent(multi.getParameter("content"));
	painting.setFin_year(multi.getParameter("fin_year"));
	painting.setPainting_size(multi.getParameter("painting_size"));
	// 파일이름 => 자바빈에 저장
	// 원래 파일이름 
	System.out.println("원래파일이름: "+ multi.getOriginalFileName("filename"));
	// 시스템에 올린 파일이름
	System.out.println("시스템에 올린 파일이름: " + multi.getFilesystemName("filename"));
	painting.setFilename(multi.getFilesystemName("filename"));
	
	//reg_date, ip setter메서드로 값저장
	painting.setReg_date(new Timestamp(System.currentTimeMillis()));
	painting.setReadcount(0);
	
	//Db 객체 생성
	PaintingDao dao = PaintingDao.getInstance();
	//메소드 호출
	dao.registerPainting(painting);
	// 이동 글 목록
	response.sendRedirect("../gallery/gallery.jsp");
			

	
%>