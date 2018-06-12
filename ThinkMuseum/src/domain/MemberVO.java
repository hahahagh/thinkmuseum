package domain;

import java.sql.Timestamp;
import java.util.List;

public class MemberVO {
	private String id;
	private String password;
	private String name;
	private String email;
	private Integer tel;
	private String address;
	private Timestamp reg_date;
	private List<Painting> like_painting;
	
	public MemberVO() {}
	
	public MemberVO(String id, String password, String name) {
		this.id = id;
		this.password = password;
		this.name = name;
	}
	
	
	public List<Painting> getLike_painting() {
		return like_painting;
	}
	
	public void setLike_painting(List<Painting> like_painting) {
		this.like_painting = like_painting;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getTel() {
		return tel;
	}
	public void setTel(Integer tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", password=" + password + ", name=" + name + ", email=" + email + ", tel=" + tel
				+ ", address=" + address + ", reg_date=" + reg_date + ", like_painting=" + like_painting + "]";
	}


	
	
}
