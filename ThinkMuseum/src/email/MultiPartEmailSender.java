package email;

import java.util.List;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.MultiPartEmail;

import domain.Email;
import domain.MemberVO;

public class MultiPartEmailSender {

	public void sendEmail(Email e, String attachPath) {
		long beginTime = System.currentTimeMillis();
		// 첨부파일 생성을 위한 EmailAttachment 객체 생성
		EmailAttachment attch= new EmailAttachment();
//		String path = "D:/SpringFrameWork/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/test01/attachFile/";
		attch.setPath(attachPath + "\\" + e.getFileName());
//		String path = attch.getPath();
		attch.setDescription(e.getFileName());
		attch.setName("");
		// MultiPartEmail 객체생성
		MultiPartEmail email = new MultiPartEmail();
		// SMTP 서버 연결설정
		email.setHostName("smtp.daum.net");
		email.setSmtpPort(465);
		email.setAuthentication("adpyhing", "pyhing123*");
		
//		email.setSSL(true);
//		email.setTLS(true);
		email.setSSLOnConnect(true);
		email.setStartTLSEnabled(true);
		
		String rt = "fail";
		
		try {
			//보내는 사람
			email.setFrom("adpyhing@daum.net", "Admin", "utf-8");
			
			List<MemberVO> list = e.getRecipient();
			for (MemberVO member : list) {
				// 받는 사람 설정
				email.addTo(member.getEmail(), member.getName(), "utf-8");
			}
			
			// 제목설정
			email.setSubject(e.getSubject());
			// 본문설정
			email.setMsg(e.getContent());
			// 파일 첨부
			email.attach(attch);
			//메일전송
			rt = email.send();
		} catch (EmailException ee) {
			ee.printStackTrace();
		}finally {
			long execTime = System.currentTimeMillis() - beginTime;
			System.out.println("execTime: "+ execTime);
			System.out.println("rt : " + rt);
		}
		
		
		
		
	}

}
