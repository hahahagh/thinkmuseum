<%@page import="dao.PaintingDao"%>
<%@page import="domain.Painting"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String realPath = application.getRealPath("/upload");
	int maxSize = 1024 * 1024 * 10;
	
	//업로드 수행
	MultipartRequest multi 
		= new MultipartRequest(request,realPath,maxSize,"UTF-8",new DefaultFileRenamePolicy());
	
	//Board 객체 생성
	Painting painting = new Painting();
	System.out.println("객체생성");
	//폼 정보를 Board 객체에 저장
	painting.setNum(Integer.parseInt(multi.getParameter("num")));
	painting.setArtist(multi.getParameter("artist"));
	painting.setTitle(multi.getParameter("title"));
	painting.setFin_year(multi.getParameter("fin_year"));
	painting.setFilename(multi.getParameter("file_name"));
	painting.setPainting_size(multi.getParameter("painting_size"));
	painting.setContent(multi.getParameter("content"));
	//파일
	if(multi.getFilesystemName("filename") != null){
		//새롭게 수정할 파일이 있음
		System.out.println("새롭게 수정할 파일이 있음");
		painting.setFilename(multi.getFilesystemName("filename"));
		// 이전 파일 삭제 작업
		String targetFile = multi.getParameter("oldfilename");
		
		File file= new File(realPath,targetFile);
		if(file.exists()){
			file.delete();
		}
		
	}else {
		//파일 수정은 안함. 기존 파일이름으로 업데이트 진행
		painting.setFilename(multi.getParameter("oldfilename"));
		System.out.println("파일 수정은 안함. 기존 파일이름으로 업데이트 진행");
	}
%>

<%
	//pageNum 파라미터 가져오기
	String pageNum = request.getParameter("pageNum");
	// DB객체 생성
	PaintingDao dao = PaintingDao.getInstance();
	// 메소드 호출 updateBoard(boardbean)
	dao.updatePainting(painting);
	System.out.println("update완료");
	System.out.println(pageNum);
	response.sendRedirect("../gallery/gallery.jsp?pageNum=" + pageNum);
	
	
	
%>