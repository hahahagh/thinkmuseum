package module;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class MySessionListener implements HttpSessionListener {
	
	private static int accessCount; // 접속한 사용자수

	public static int getAccessCount() {
		return accessCount;
	}

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		System.out.println("sessionCreated()");
		// 세션이 최초로 생성됐을때.(웹프로그램에 접속했을때)
		HttpSession session = event.getSession();
		session.setMaxInactiveInterval(60); // 초단위
		
		System.out.println(session.getId() + " 세션생성");
		
		accessCount++;
		System.out.println("접속자수: " + accessCount + "\n");
		
		// 애플리케이션 영역객체 가져오기
		ServletContext application = session.getServletContext();
		Integer loginCount = (Integer) application.getAttribute("loginCount");
		if (loginCount == null) {
			application.setAttribute("loginCount", 0);
		}
		
		// 로그인 아이디 저장할 컬렉션 객체 준비
		Set<String> set = (Set) application.getAttribute("idsSet");
		if (set == null) {
			application.setAttribute("idsSet", new HashSet<String>());
		}
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		System.out.println("sessionDestroyed()");
		// 세션이 제거되기 직전에(sesssion객체가 살아있음)
		// sessionDestroyed() 호출 이후 session이 제거됨.
		HttpSession session = event.getSession();
		
		System.out.println(session.getId() + " 세션소멸");
		
		accessCount--;
		if (accessCount < 0) {
			accessCount = 0;
		}
		System.out.println("접속자수: " + accessCount);
		
		long interval = System.currentTimeMillis() - session.getCreationTime();
		interval = interval / 1000 / 60; // 밀리초를 분 단위로 변환
		System.out.println("머문시간: " + interval + "분");
		
		String id = (String) session.getAttribute("id");
		System.out.println("id = " + id + "\n");
		
		ServletContext application = session.getServletContext();
		Set<String> set = (Set) application.getAttribute("idsSet");
		set.remove(id);
	}

}





