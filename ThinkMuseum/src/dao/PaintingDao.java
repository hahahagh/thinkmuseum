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

import org.json.simple.JSONArray;

import domain.Painting;

public class PaintingDao {
	
	private static PaintingDao instance = new PaintingDao();
	
	private PaintingDao() {}
		
	public static PaintingDao getInstance() {
		return instance;
	}



	// 데이터 베이스를 연결해 주는 역할을 하는 메소드
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
	
	public void registerPainting(Painting painting) {
		Connection con = null;
		PreparedStatement psmt = null; //select
		PreparedStatement psmt2 = null; //insert
		ResultSet rs = null;
		String sql = "";
		
		
		try {
			
			con = getConnection();
			
			// num 구하기 글이 없을 경우 1
			//			글이 있을 경우 최근 글번호(번호가 가장 큰 값)+1
			sql = "select max(num) from painting ";
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			// 실행
			if(rs.next()) {
				int num = rs.getInt(1) + 1; //rs.getInt("max(num)")
				painting.setNum(num);
			} else {
				painting.setNum(1);  // 글이 없는 경우 글번호를 1로
			}
			
			// sql insert 
			sql = "insert into painting "
					+ "(num,artist,title,painting_size,fin_year,content,"
					+ "filename,readcount,reg_date)" 
					+ "values(?,?,?,?,?,?,?,?,?)";
			
			psmt2 = con.prepareStatement(sql);
			psmt2.setInt(1, painting.getNum());
			psmt2.setString(2, painting.getArtist());
			psmt2.setString(3, painting.getTitle());
			psmt2.setString(4, painting.getPainting_size());
			psmt2.setString(5, painting.getFin_year());
			psmt2.setString(6, painting.getContent());
			psmt2.setString(7, painting.getFilename());
			psmt2.setInt(8, painting.getReadcount());
			psmt2.setTimestamp(9, painting.getReg_date());
			
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
	
	public void updateReadCount(int num) {
		Connection con = null;
		PreparedStatement psmt = null; //select
		String sql = "";
		
		try {
			con = getConnection();
			//sql update num에 해당하는 readcount1증가하게 수정
			sql ="update painting set readcount = readcount +1 where num = ?";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, num);
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
		
		
	} // updateReadCount()
	
	public void updateLikeCount(int num) {
		Connection con = null;
		PreparedStatement psmt = null; 
		String sql = "";
		
		try {
			con = getConnection();
			//sql update num에 해당하는 readcount1증가하게 수정
			sql ="update painting set likecount = likecount +1 where num = ?";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, num);
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
	} // updateLikeCount 끝
	
	//선택한 글 1개 가져오기
			public Painting getPainting(int num) {
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				Painting bean = null;
				
				try {
					con = getConnection();
					//sql num에 해당하는 글 정보 가져오기
					sql = "select * from painting where num =?";
					psmt = con.prepareStatement(sql);
					psmt.setInt(1, num);
					//실행
					rs = psmt.executeQuery();
					// rs결과 => 자바빈 객체에 저장
					if(rs.next()) {
						//자바빈 객체생성
						bean = new Painting();
						// rs결과를 자바빈에 저장
						bean.setContent(rs.getString("content"));
						bean.setReg_date(rs.getTimestamp("reg_date"));
						bean.setFilename(rs.getString("filename"));
						bean.setArtist(rs.getString("artist"));
						bean.setNum(rs.getInt("num"));
						bean.setFin_year(rs.getString("fin_year"));
						bean.setPainting_size(rs.getString("painting_size"));
						bean.setReadcount(rs.getInt("readcount"));
						bean.setTitle(rs.getString("title"));
						bean.setLikecount(rs.getInt("likecount"));
					}
					
					
					
				} catch (Exception e) {
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
				return bean;
			} // getPainting
			
			public JSONArray getLikeCountByTitle(){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				JSONArray jsonArray = new JSONArray();
				
				JSONArray recordArr = new JSONArray();
				recordArr.add("작품명");
				recordArr.add("좋아요");
				
				jsonArray.add(recordArr);
				
				try {
					con = getConnection();
					
					sql= "select likecount, title from painting where likecount > 3";
					
					psmt = con.prepareStatement(sql);
					
					//실행
					rs = psmt.executeQuery();
					while (rs.next()) {
						recordArr = new JSONArray();
						
						recordArr.add(rs.getString("title"));
						recordArr.add(rs.getInt("likecount"));
						
						//자바빈 => list에 추가
						jsonArray.add(recordArr);
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
				
				return jsonArray;
				
			} // getLikeCountByTitle()
			
			
			
			//전체 그림 개수 가져오는 메소드
			public int getPaintingCount(){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				int count = 0;
				
				try {
					con = getConnection();
					// sql 전체글개수 가져오기 select count(*)
					sql = "select count(*) from painting";
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
				
			} // getPaintingCount()
			
			//작품명 검색으로 전체 그림 개수 가져오는 메소드
			public int getPaintingCountByTitle(String search){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				int count = 0;
				System.out.println(search);
				try {
					con = getConnection();
					// sql 전체글개수 가져오기 select count(*)
					sql = "select count(*) from painting where title like ?";
					psmt = con.prepareStatement(sql);
					psmt.setString(1, "%"+search+"%");
					//실행
					rs = psmt.executeQuery();
					// rs 데이터가 있으면 count에 저장
					if(rs.next()) {
						count = rs.getInt(1);
						System.out.println("카운트: "+count);
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
				
			} // getPaintingCount(title)
			
			//작가명 검색으로 전체 그림 개수 가져오는 메소드
			public int getPaintingCountByArtist(String search){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				int count = 0;
				
				try {
					con = getConnection();
					// sql 전체글개수 가져오기 select count(*)
					sql = "select count(*) from painting where artist like ?";
					psmt = con.prepareStatement(sql);
					psmt.setString(1, "%"+search+"%");
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
				
			} // getPaintingCount(artist)
			
			//작가별 그림 개수 가져오는 메소드(group by)
			public JSONArray getPaintingCountByArtist(){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				
				JSONArray jsonArray = new JSONArray();
				
				JSONArray recordArr = new JSONArray();
				recordArr.add("작가명");
				recordArr.add("작품 수");
				
				jsonArray.add(recordArr);
				
				try {
					con = getConnection();
					
					sql= "select artist, count(*) cnt from painting group by artist order by artist";
					
					psmt = con.prepareStatement(sql);
					
					
					//실행
					rs = psmt.executeQuery();
					while (rs.next()) {
						recordArr = new JSONArray();
						
						recordArr.add(rs.getString("artist"));
						recordArr.add(rs.getInt("cnt"));
						//자바빈 => list에 추가
						jsonArray.add(recordArr);			
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
				
				return jsonArray;
			} // getPaintingCount()
			
			public List<Painting> getPaintings(){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				List<Painting> list = new ArrayList<>();
				
				try {
					con = getConnection();
					
					sql= "select * from painting";
					
					psmt = con.prepareStatement(sql);
					
					
					//실행
					rs = psmt.executeQuery();
					while (rs.next()) {
						Painting bean = new Painting();
						//rs => 자바빈에 저장
						bean.setContent(rs.getString("content"));
						bean.setReg_date(rs.getTimestamp("reg_date"));
						bean.setFilename(rs.getString("filename"));
						bean.setNum(rs.getInt("num"));
						bean.setReadcount(rs.getInt("readcount"));
						bean.setArtist(rs.getString("artist"));
						bean.setFin_year(rs.getString("fin_year"));
						bean.setPainting_size(rs.getString("painting_size"));
						bean.setTitle(rs.getString("title"));
						bean.setLikecount(rs.getInt("likecount"));
						//자바빈 => list에 추가
						list.add(bean);
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
				
			} // getPaintings
			
			public List<Painting> getPaintings(int startRow, int endRow){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				List<Painting> list = new ArrayList<>();
				
				try {
					con = getConnection();
					
					StringBuilder sb = new StringBuilder();
					sb.append("select * ");
					sb.append("from (select rownum as rnum, a.* ");
					sb.append("from (select * from painting order by reg_date desc) a ");
					sb.append("where rownum <= ? ");
					sb.append(") a where rnum >= ? ");
					
					psmt = con.prepareStatement(sb.toString());
					psmt.setInt(1, endRow);
					psmt.setInt(2, startRow);
					
					
					//실행
					rs = psmt.executeQuery();
					while (rs.next()) {
						Painting bean = new Painting();
						//rs => 자바빈에 저장
						bean.setContent(rs.getString("content"));
						bean.setReg_date(rs.getTimestamp("reg_date"));
						bean.setFilename(rs.getString("filename"));
						bean.setNum(rs.getInt("num"));
						bean.setReadcount(rs.getInt("readcount"));
						bean.setArtist(rs.getString("artist"));
						bean.setFin_year(rs.getString("fin_year"));
						bean.setPainting_size(rs.getString("painting_size"));
						bean.setTitle(rs.getString("title"));
						
						//자바빈 => list에 추가
						list.add(bean);
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
				
			} // getPaintings(startrow, endrow)
			
			public List<Painting> getPaintingsByTitle(int startRow, int endRow, String search){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				List<Painting> list = new ArrayList<>();
				
				try {
					con = getConnection();
					
					StringBuilder sb = new StringBuilder();
					sb.append("select * ");
					sb.append("from (select rownum as rnum, a.* ");
					sb.append("from (select * from painting where title like ?) a ");
					sb.append("where rownum <= ? ");
					sb.append(") a where rnum >= ? ");
					
					psmt = con.prepareStatement(sb.toString());
					psmt.setString(1, "%"+search+"%");
					psmt.setInt(2, endRow);
					psmt.setInt(3, startRow);
					
					
					//실행
					rs = psmt.executeQuery();
					while (rs.next()) {
						Painting bean = new Painting();
						//rs => 자바빈에 저장
						bean.setContent(rs.getString("content"));
						bean.setReg_date(rs.getTimestamp("reg_date"));
						bean.setFilename(rs.getString("filename"));
						bean.setNum(rs.getInt("num"));
						bean.setReadcount(rs.getInt("readcount"));
						bean.setArtist(rs.getString("artist"));
						bean.setFin_year(rs.getString("fin_year"));
						bean.setPainting_size(rs.getString("painting_size"));
						bean.setTitle(rs.getString("title"));
						
						//자바빈 => list에 추가
						list.add(bean);
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
				
			} // getPaintings(title)
			
			public List<Painting> getPaintingsByArtist(int startRow, int endRow, String search){
				Connection con = null;
				PreparedStatement psmt = null; //select
				ResultSet rs = null;
				String sql = "";
				List<Painting> list = new ArrayList<>();
				
				try {
					con = getConnection();
					
					StringBuilder sb = new StringBuilder();
					sb.append("select * ");
					sb.append("from (select rownum as rnum, a.* ");
					sb.append("from (select * from painting where artist like ?) a ");
					sb.append("where rownum <= ? ");
					sb.append(") a where rnum >= ? ");
					
					psmt = con.prepareStatement(sb.toString());
					psmt.setString(1, "%"+search+"%");
					psmt.setInt(2, endRow);
					psmt.setInt(3, startRow);
					
					
					//실행
					rs = psmt.executeQuery();
					while (rs.next()) {
						Painting bean = new Painting();
						//rs => 자바빈에 저장
						bean.setContent(rs.getString("content"));
						bean.setReg_date(rs.getTimestamp("reg_date"));
						bean.setFilename(rs.getString("filename"));
						bean.setNum(rs.getInt("num"));
						bean.setReadcount(rs.getInt("readcount"));
						bean.setArtist(rs.getString("artist"));
						bean.setFin_year(rs.getString("fin_year"));
						bean.setPainting_size(rs.getString("painting_size"));
						bean.setTitle(rs.getString("title"));
						
						//자바빈 => list에 추가
						list.add(bean);
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
				
			} // getPaintings(artist)
			
			
			public void updatePainting(Painting painting) {
				Connection con = null;
				PreparedStatement psmt = null;
				String sql ="";
				int check = 0;
				
				try {
					con = getConnection();
					sql = "update painting set title=?, artist =?, content=?, fin_year=?, filename=?,"
							+ "painting_size=? where num=? ";
					psmt = con.prepareStatement(sql);
					psmt.setString(1, painting.getTitle());
					psmt.setString(2, painting.getArtist());
					psmt.setString(3, painting.getContent());
					psmt.setString(4, painting.getFin_year());
					psmt.setString(5, painting.getFilename());
					psmt.setString(6, painting.getPainting_size());
					psmt.setInt(7, painting.getNum());
					
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
			} // updatePainting(painting)
			
			public void deletePainting(int num) {
				Connection con = null;
				PreparedStatement psmt = null;
				String sql = "";
				
				try {
					con = getConnection();
					sql = "delete from painting where num =?";
					psmt = con.prepareStatement(sql);
					psmt.setInt(1, num);
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
