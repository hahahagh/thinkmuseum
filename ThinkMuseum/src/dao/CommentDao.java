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

import domain.Comment;
import domain.Painting;

public class CommentDao {
	private static CommentDao instance = new CommentDao();
	
	private CommentDao() {}
		
	public static CommentDao getInstance() {
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
	
	public void registerComment(Comment comment) {
		Connection con = null;
		PreparedStatement psmt = null; //select
		PreparedStatement psmt2 = null; //insert
		ResultSet rs = null;
		String sql = "";
		
		
		try {
			
			con = getConnection();
			
			// num 구하기 글이 없을 경우 1
			//			글이 있을 경우 최근 글번호(번호가 가장 큰 값)+1
			sql = "select max(comment_num) from comments ";
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			// 실행
			if(rs.next()) {
				int num = rs.getInt(1) + 1; //rs.getInt("max(num)")
				comment.setComment_num(num);;
			} else {
				comment.setComment_num(1);  // 글이 없는 경우 글번호를 1로
			}
			
			// 주글(일반글) 글번호 == re_ref 같도록
			comment.setRe_ref(comment.getComment_num());
			comment.setRe_lev(0); // 주글의 들여쓰기 레벨
			comment.setRe_seq(0); // 같은 그룹 글에서 순서
			
			// sql insert 
			sql = "insert into comments "
					+ "(comment_num,member_id,content,"
					+ "re_ref, re_lev, re_seq, "
					+ "readcount,reg_date,ip,painting_num)" 
					+ "values(?,?,?,?,?,?,?,?,?,?)";
			
			psmt2 = con.prepareStatement(sql);
			psmt2.setInt(1, comment.getComment_num());
			psmt2.setString(2, comment.getMember_id());
			psmt2.setString(3, comment.getContent());
			psmt2.setInt(4, comment.getRe_ref());
			psmt2.setInt(5, comment.getRe_lev());
			psmt2.setInt(6, comment.getRe_seq());
			psmt2.setInt(7, comment.getReadcount());
			psmt2.setTimestamp(8, comment.getReg_date());
			psmt2.setString(9, comment.getIp());
			psmt2.setInt(10,comment.getPainting_num() );
			
			psmt2.executeUpdate();
			
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
					psmt.close();
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
	} //registerPainting 끝
	
	public int getCommentCount(int painting_num) {
		Connection con = null;
		PreparedStatement psmt = null; //select
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con = getConnection();
			sql = "select count(*) from comments";
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
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
		System.out.println("getCommentCount 완료");
		return count;
	} // getCommentCount
	
	public Comment getComment(int num) {
		Connection con = null;
		PreparedStatement psmt = null; //select
		ResultSet rs = null;
		String sql = "";
		Comment comment = null;
		
		try {
			con = getConnection();
			sql = "select * from comments where comment_num = ?";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, num);
			rs = psmt.executeQuery();
			if(rs.next()) {
				comment = new Comment();
				// rs 결과를 comment 결과에 저장
				comment.setMember_id(rs.getString("member_id"));
				comment.setContent(rs.getString("content"));
				comment.setComment_num(rs.getInt("comment_num"));
				comment.setReadcount(rs.getInt("readcount"));
				comment.setReg_date(rs.getTimestamp("reg_date"));
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
		System.out.println("getComment 완료");
		return comment;
	}
	
	public List<Comment> getComments(int startRow, int endRow, int painting_num){
		Connection con = null;
		PreparedStatement psmt = null; //select
		ResultSet rs = null;
		String sql = "";
		List<Comment> list = new ArrayList<>();
		
		try {
			con = getConnection();
			
			StringBuilder sb = new StringBuilder();
			sb.append("select * ");
			sb.append("from (select rownum as rnum, a.* ");
			sb.append("from (select * from comments where painting_num = ? order by reg_date desc) a ");
			sb.append("where rownum <= ? ");
			sb.append(") a where rnum >= ? ");
			
			psmt = con.prepareStatement(sb.toString());
			psmt.setInt(1, painting_num);
			psmt.setInt(2, endRow);
			psmt.setInt(3, startRow);
			
			
			//실행
			rs = psmt.executeQuery();
			while (rs.next()) {
				Comment comment = new Comment();
				//rs => 자바빈에 저장
				comment.setMember_id(rs.getString("member_id"));
				comment.setContent(rs.getString("content"));
				comment.setReg_date(rs.getTimestamp("reg_date"));
				comment.setComment_num(rs.getInt("comment_num"));
				comment.setReadcount(rs.getInt("readcount"));
				
				//자바빈 => list에 추가
				list.add(comment);
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
		
	} // getComments(startRow, endRow, painting_num)
	
	public void deleteComment(int comment_num) {
		Connection con = null;
		PreparedStatement psmt = null;
		String sql = "";
		
		try {
			con = getConnection();
			sql = "delete from comments where comment_num =?";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, comment_num);
			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
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
	} // deletePainting(Painting)
}
