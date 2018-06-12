package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.sun.prism.paint.Paint;

import domain.Comment;
import domain.Like;
import domain.Painting;

public class LikeDao {
	
	private static LikeDao instance = new LikeDao();
	
	private LikeDao() {}
	
	public static LikeDao getInstance() {
		return instance;
	}

	private Connection getConnection() throws Exception {

		/*
		 * String URL = "jdbc:oracle:thin:@127.0.0.1:1521:testDB"; String USER =
		 * "scott"; String PASSWORD = "1234";
		 * 
		 * //드라이버 로딩 Class.forName("oracle.jdbc.driver.OracleDriver"); //DB연결 con =
		 * DriverManager.getConnection(URL,USER,PASSWORD);
		 */
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/myoracle");
		Connection con = ds.getConnection();
		return con;
	} // getConnection		
	
	public void registerLike(int painting_num, String member_id) {
		Connection con = null;
		PreparedStatement psmt = null; 
		String sql ="";
		
		try {
			con = getConnection();
			sql = "insert into liketable(painting_num, member_id) values(?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, painting_num);
			psmt.setString(2, member_id);
			
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
		
	} // registerLike
	
	public List<Painting> getLikePaintings(String id){
		Connection con = null;
		PreparedStatement psmt = null; //select
		ResultSet rs = null;
		String sql = "";
		List<Painting> list = new ArrayList<>();
		
		try {
			con = getConnection();
			
			sql = "select * from painting p, liketable l where p.num = l.painting_num(+) and l.member_id = ? ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			
			//실행
			rs = psmt.executeQuery();
			while (rs.next()) {
				Painting painting = new Painting();
				//rs => 자바빈에 저장
				painting.setTitle(rs.getString("title"));
				painting.setArtist(rs.getString("artist"));
				painting.setContent(rs.getString("content"));
				painting.setReg_date(rs.getTimestamp("reg_date"));
				painting.setFilename(rs.getString("filename"));
				painting.setNum(rs.getInt("num"));
				painting.setReadcount(rs.getInt("readcount"));
				painting.setFin_year(rs.getString("fin_year"));
				painting.setPainting_size(rs.getString("painting_size"));

				
				//자바빈 => list에 추가
				list.add(painting);
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
		return list;
	} //getLikePaintings 
	
	/*public List<Like> getLike(String id) {
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String sql ="";
		List<Like> list = new ArrayList<>();
		
		
		try {
			con =getConnection();
			sql = "select * from liketable where id =?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			//실행
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				Like like = new Like();
				like.setMember_id(rs.getString("member_id"));
				like.setPainting_num(rs.getInt("painting_num"));
				
				list.add(like);
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
		
		return list;
	}*/
	
	public int getPaintingCount(String id) {
		Connection con = null;
		PreparedStatement psmt = null; //select
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con = getConnection();
			// sql 전체글개수 가져오기 select count(*)
			sql = "select count(*) from painting p, liketable l where p.num = l.painting_num(+) and l.member_id=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
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
	}
	
	public int isLikePainting(String id, int painting_num) {
		Connection con = null;
		PreparedStatement psmt = null; //select
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con =getConnection();
			sql = "select * from liketable where member_id =? and painting_num= ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, painting_num);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				count = 1;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
	} // isLikePainting
}
