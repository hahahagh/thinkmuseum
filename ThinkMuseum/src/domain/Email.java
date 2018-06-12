package domain;

import java.util.List;

public class Email {
	private String sender;
	private List<MemberVO> recipient;
	private String fileName;
	private String subject;
	private String content;
	
	public List<MemberVO> getRecipient() {
		return recipient;
	}
	public void setRecipient(List<MemberVO> recipient) {
		this.recipient = recipient;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
