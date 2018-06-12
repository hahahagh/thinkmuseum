package domain;

import java.sql.Timestamp;

public class Comment {
	private Integer comment_num;
	private Integer painting_num;
	private String member_id;
	private String content;
	private Integer re_ref;
	private Integer re_lev;
	private Integer re_seq;
	private Timestamp reg_date;
	private String ip;
	private Integer readcount;
	
	
	public Integer getComment_num() {
		return comment_num;
	}
	public void setComment_num(Integer comment_num) {
		this.comment_num = comment_num;
	}
	public Integer getPainting_num() {
		return painting_num;
	}
	public void setPainting_num(Integer painting_num) {
		this.painting_num = painting_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(Integer re_ref) {
		this.re_ref = re_ref;
	}
	public Integer getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(Integer re_lev) {
		this.re_lev = re_lev;
	}
	public Integer getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(Integer re_seq) {
		this.re_seq = re_seq;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Integer getReadcount() {
		return readcount;
	}
	public void setReadcount(Integer readcount) {
		this.readcount = readcount;
	}
	
	
	
}
