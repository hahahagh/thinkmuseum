package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import domain.MemberVO;


public class MemberDao {
	//싱글턴 패턴
	private static MemberDao instance = new MemberDao();
	
	private MemberDao () {}
	
	public static MemberDao getInstance() {
		return instance;
	}



		//데이터 베이스를 연결해 주는 역할을 하는 메소드
		private Connection getConnection() throws Exception{
			Connection con = null;
			String URL = "jdbc:oracle:thin:@127.0.0.1:1521:testDB";
			String USER = "yh";
			String PASSWORD = "1234";
			
			//드라이버 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");
			 //DB연결
			con = DriverManager.getConnection(URL,USER,PASSWORD);
			
			
//			Context initContext = new InitialContext();
//			Context envContext  = (Context)initContext.lookup("java:/comp/env");
//			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
//			con = ds.getConnection();
			return con;
		} //getConnection
		
		public void insertMember(MemberVO bean) {
			Connection con = null;
			PreparedStatement psmt = null;
			String sql = "";
			
			try {
				con = getConnection();
				sql = "Insert into Member(id,password,name,email,tel,address,reg_date) values(?,?,?,?,?,?,?)";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, bean.getId());
				psmt.setString(2, bean.getPassword());
				psmt.setString(3, bean.getName());
				psmt.setString(4, bean.getEmail());
				psmt.setInt(5, bean.getTel());
				psmt.setString(6, bean.getAddress());
				psmt.setTimestamp(7, bean.getReg_date());
				
				psmt.executeQuery();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
			}
		} // insertMember 끝
		
		// 로그인  사용자 체크 메소드
		public int userCheck(String id, String password){
			Connection con = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			String sql = "";
			
			int check = -1;
			
			//아이디 불일치: -1
			//아이디 일치 & 패스워드 불일치:0
			//아이디 패스워드 모두 일치 : 1
			sql = "select password from member where id =?";
			 
			try {
				con = getConnection();
				psmt = con.prepareStatement(sql);
				psmt.setString(1, id);
				 //실행
				rs = psmt.executeQuery();
				
				//rs 데이터가 있으면 아이디 있음
				 // 패스워드 비교 같으면 로그인 인증(세션값 생성"id")
				 //	패스워드 다르면 "패스워드 틀림" 출력
				 //rs 데이터가 없으면 아이디 없음
				 if(rs.next()){
					//아이디 있음
					if(password.equals(rs.getString("password"))){
						check = 1;
					} else {
						check = 0;
					}
				 }else {
					check = -1;
				 }
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
			} //finally
			
			return check;
			
			
		}	//userCheck의 끝
		
		public MemberVO getMember(String id) {
			Connection con = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			MemberVO bean = null;
			String sql = "";
			
			try {
				con = getConnection();
				sql = "select * from member where id =?";
				
				psmt = con.prepareStatement(sql);
				psmt.setString(1, id);
				
				//실행
				rs = psmt.executeQuery();
				
				//rs => 변수에 저장
				if(rs.next()){ 
					bean = new MemberVO();
					bean.setId(rs.getString("id"));
					bean.setPassword(rs.getString("password"));
					bean.setName(rs.getString("name"));
					bean.setReg_date(rs.getTimestamp("reg_date"));
					bean.setEmail(rs.getString("email"));
					bean.setTel(rs.getInt("tel"));
					bean.setAddress(rs.getString("address"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
			}
			
			return bean;
		} // getMember의 끝
		
		public int updateMember(MemberVO bean) {
			Connection con = null;
			PreparedStatement psmt = null;
			PreparedStatement psmt2 = null;
			ResultSet rs = null;
			String sql = "";
			int check = 0;
			
			try {
				con = getConnection();
				sql = "select password from member where id =?";
				
				psmt = con.prepareStatement(sql);
				psmt.setString(1, bean.getId());
				//실행
				rs = psmt.executeQuery();
			//rs 데이터가 있으면 아이디가 있다
			//패스워드 비교 맞으면 update & main.jsp
			//패스워드 틀리면 "패스워드 틀림" & 뒤로 이동
		 	if(rs.next()){
				//아이디 있음
				if(bean.getPassword().equals(rs.getString("password"))){
					//업데이트 작업 수정후 이동
					sql = "update member set name=? , tel=?, address=?, email=? where id=?";
					psmt2 = con.prepareStatement(sql);
					psmt2.setString(1, bean.getName());
					psmt2.setInt(2, bean.getTel());
					psmt2.setString(3, bean.getAddress());
					psmt2.setString(4, bean.getEmail());
					psmt2.setString(5, bean.getId());
					//실행
					psmt2.executeUpdate();
					
					check = 1; //패스워드 일치해서 수정성공
					
				} else {
					check = 0;
				}
		 	}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt2 != null) {
					try {
						psmt2.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
			}
			
			return check;
		} //updateMember
		
		public int deleteMember(String id, String password, String deletechk) {
			Connection con = null;
			PreparedStatement psmt = null;
			PreparedStatement psmt2 = null;
			ResultSet rs = null;
			String sql = "";
			int check = 0;
			
			try {
				con = getConnection();
				sql = "select password from member where id =?";
				
				psmt = con.prepareStatement(sql);
				psmt.setString(1, id);
				//실행
				rs = psmt.executeQuery();
			//rs 데이터가 있으면 아이디가 있다
			//패스워드 비교 맞으면 update & main.jsp
			//패스워드 틀리면 "패스워드 틀림" & 뒤로 이동
		 	if(rs.next()){
				//아이디 있음
				if(password.equals(rs.getString("password"))){
					if(deletechk.equals("on")) {
						sql = "delete from member where id=?";
						psmt2 = con.prepareStatement(sql);
						psmt2.setString(1, id);
						
						//실행
						psmt2.executeUpdate();
						
						check = 1; // 패스워드 일치, 삭제성공
					} 
						
				}else {
					check =0;
				}
		 	}
		 	
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt2 != null) {
					try {
						psmt2.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
			}
			
			return check;
		} //deletemember
		
		public List<MemberVO> getMembers(int startRow, int endRow){
			Connection con = null;
			PreparedStatement psmt = null; //select
			ResultSet rs = null;
			String sql = "";
			List<MemberVO> list = new ArrayList<>();
			
			try {
				con = getConnection();
				
				StringBuilder sb = new StringBuilder();
				sb.append("select * ");
				sb.append("from (select rownum as rnum, a.* ");
				sb.append("from (select * from member order by reg_date desc) a ");
				sb.append("where rownum <= ? ");
				sb.append(") a where rnum >= ?");
				
				psmt = con.prepareStatement(sb.toString());
				psmt.setInt(1, endRow);
				psmt.setInt(2, startRow);
				
				//실행
				rs = psmt.executeQuery();
				while (rs.next()) {
					MemberVO bean = new MemberVO();
					//rs => 자바빈에 저장
					bean.setReg_date(rs.getTimestamp("reg_date"));
					bean.setId(rs.getString("id"));
					bean.setName(rs.getString("name"));
					bean.setPassword(rs.getString("password"));
					bean.setEmail(rs.getString("email"));
					bean.setAddress(rs.getString("address"));
					
					//자바빈 => list에 추가
					list.add(bean);
				}
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
			}
			
			return list;
			
		} //getMembers() 끝
		
		public int getMemberCount(){
			Connection con = null;
			PreparedStatement psmt = null; //select
			ResultSet rs = null;
			String sql = "";
			int count = 0;
			
			try {
				con = getConnection();
				// sql 전체글개수 가져오기 select count(*)
				sql = "select count(*) from member";
				psmt = con.prepareStatement(sql);
				//실행
				rs = psmt.executeQuery();
				// rs 데이터가 있으면 count에 저장
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				
			} catch (Exception e) {
				
				e.printStackTrace();
			} finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			return count;
			
		} // getMemberCount()
		
		//아이디 중복체크
		public int idCheck(String id) {
			Connection con = null;
			PreparedStatement psmt = null; //select용
			ResultSet rs = null;
			String sql = "";
			int rowCount = 0;
			
			try {
				con = getConnection();
				sql = "select count(*) from member where id=?";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, id);
				rs = psmt.executeQuery();
				if(rs.next()) {
					rowCount = rs.getInt(1);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
			
			return rowCount;
		} //idCheck()
		
		public void registerLikePainting(MemberVO member, int num) {
			Connection con = null;
			PreparedStatement psmt = null;
			String sql ="";
			
			try {
				con = getConnection();
				sql = "update member set like_painting_num =? where id =?";
				psmt.setInt(1, num);
				psmt.setString(2, member.getId());
				psmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(psmt != null) {
					try {
						psmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}	
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		} // registerLikePainting
		
		//-----------------------테스트클래스용 메서드---------------------------------
		public void add(MemberVO member) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			
			try {
				// 드라이버 로딩. DB연결
				con = getConnection();
				sql = "INSERT INTO member (id,password,name) VALUES (?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPassword());
				pstmt.setString(3, member.getName());
				// 실행
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {}
				}
			}
		}
		
		// MEMBER 테이블의 모든 레코드를 삭제
		public void deleteAll() {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			
			try {
				// 드라이버 로딩. DB연결
				con = getConnection();
				sql = "DELETE FROM member ";
				pstmt = con.prepareStatement(sql);
				// 실행
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {}
				}
			}
		}
		// member 테이블의 전체 레코드갯수 가져오기
		public int getCount() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			int count = 0;
			
			try {
				con = getConnection();
				
				sql = "select count(*) from member";
				pstmt = con.prepareStatement(sql);
				// 실행
				rs = pstmt.executeQuery();
				// rs => 변수저장
				if (rs.next()) {
					count = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {}
				}
			}
			return count;
		}
}
