package module;

import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

// HttpSessionBindingListener 인터페이스를 구현한 객체를
// session객체에 설정할때 이벤트가 발생하는 메소드를 구현
public class MySessionBindingListener implements HttpSessionBindingListener {
	
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		System.out.println("valueBound()");
		// session객체에 현재타입객체를 설정할때 호출됨
		HttpSession session = event.getSession();
		String id = (String) session.getAttribute("id");
		System.out.println("로그인 id = " + id + " \n");
		
		ServletContext application = session.getServletContext();
		
		Integer loginCount = (Integer) application.getAttribute("loginCount");
		loginCount++;
		application.setAttribute("loginCount", loginCount);
		
		Set<String> set = (Set) application.getAttribute("idsSet");
		set.add(id);
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		System.out.println("valueUnbound() \n");
		// session객체가 해제된 이후 호출됨
		// session객체의 값을 찾을 수 없음을 주의
		// session.removeAttribute("bindListener");로 제거했을때도 호출됨.
		
		HttpSession session = event.getSession();
		ServletContext application = session.getServletContext();
		Integer loginCount = (Integer) application.getAttribute("loginCount");
		loginCount--;
		if (loginCount < 0) {
			loginCount = 0;
		}
		application.setAttribute("loginCount", loginCount);
	}

}
