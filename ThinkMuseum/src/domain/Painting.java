package domain;

import java.sql.Timestamp;
import java.util.List;

public class Painting {
	//멤버변수(필드)
		private Integer num;
		private String artist;
		private String title;
		private String content;
		private String fin_year;
		private String painting_size;
		private String filename;
		private Integer readcount;
		private Timestamp reg_date;
		private List<Comment> commentList;
		private Integer likecount;
		
		
		public Integer getLikecount() {
			return likecount;
		}
		public void setLikecount(Integer likecount) {
			this.likecount = likecount;
		}
		public List<Comment> getCommentList() {
			return commentList;
		}
		public void setCommentList(List<Comment> commentList) {
			this.commentList = commentList;
		}
		public Integer getNum() {
			return num;
		}
		public void setNum(Integer num) {
			this.num = num;
		}
		public String getArtist() {
			return artist;
		}
		public void setArtist(String artist) {
			this.artist = artist;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getFin_year() {
			return fin_year;
		}
		public void setFin_year(String fin_year) {
			this.fin_year = fin_year;
		}
		public String getPainting_size() {
			return painting_size;
		}
		public void setPainting_size(String painting_size) {
			this.painting_size = painting_size;
		}
		public String getFilename() {
			return filename;
		}
		public void setFilename(String filename) {
			this.filename = filename;
		}
		public Integer getReadcount() {
			return readcount;
		}
		public void setReadcount(Integer readcount) {
			this.readcount = readcount;
		}
		public Timestamp getReg_date() {
			return reg_date;
		}
		public void setReg_date(Timestamp reg_date) {
			this.reg_date = reg_date;
		}
		
		
}
