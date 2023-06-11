package test.cafe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import test.cafe.dto.CafeDto;
import test.file.dto.FileDto;
import test.util.DbcpBean;

public class CafeDao {

	//singleton 형식으로 만들어보기
	private static CafeDao dao;
	//외부에서 객체 생성하지 못하도록 생성자를 private로
	private CafeDao() {}
	//자신의 참조값을 리턴해주는 메소드
	public static CafeDao getInstance() {
		if(dao==null) {
			dao = new CafeDao();
		}
		return dao;
	}
	
	//insert
	public boolean insert(CafeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = " INSERT INTO board_cafe "
					+ " (num, writer, title, content, viewcount, regdate) "
					+ " VALUES (board_cafe_seq.NEXTVAL, ?, ?, ?, 1, SYSDATE) ";
			pstmt = conn.prepareStatement(sql);
			//실행할 sql 문이 미완성이라면 여기서 완성
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			//sql 문을 수행하고 변화된(추가, 수정, 삭제된) row 의 갯수 리턴 받기
			rowCount = pstmt.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		//만일 변화된 row 의 갯수가 0 보다 크면 작업 성공
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//전체 목록을 얻어냄
	
	public List<CafeDto> getListAll(){
		List<CafeDto> list = new ArrayList<>();
		//필요한 객체의 참조값을 담을 지역변수 미리 만들기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//DbcpBean 객체를 이용해서 Connection 객체를 얻어온다(Connection Pool 에서 얻어오기)
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = " SELECT num, writer, title, viewcount, content, regdate "
					+ " FROM board_cafe "
					+ " ORDER BY num DESC ";
			pstmt = conn.prepareStatement(sql);
			//sql 문이 미완성이라면 여기서 완성

			//select 문 수행하고 결과값 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 에 담긴 내용 추출
			while (rs.next()) {
				CafeDto tmp = new CafeDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setTitle(rs.getString("title"));
				tmp.setViewCount(rs.getInt("viewcount"));
				tmp.setContent(rs.getString("content"));
				tmp.setRegdate(rs.getString("regdate"));
				list.add(tmp);
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close(); //Connection 이 Connection Pool 에 반납된다.
			} catch (Exception e) {
			}
		}
		return list;
	}
	public boolean update(CafeDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = " UPDATE board_cafe "
					+ " SET title = ?, content = ? "
					+ " WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			//실행할 sql 문이 미완성이라면 여기서 완성
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			//sql 문을 수행하고 변화된(추가, 수정, 삭제된) row 의 갯수 리턴 받기
			rowCount = pstmt.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		//만일 변화된 row 의 갯수가 0 보다 크면 작업 성공
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//파일 하나의 정보를 리턴해주는 메소드
	public CafeDto getData(int num) {
		CafeDto  dto = null;
		//필요한 객체의 참조값을 담을 지역변수 미리 만들기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//DbcpBean 객체를 이용해서 Connection 객체를 얻어온다(Connection Pool 에서 얻어오기)
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = " SELECT writer, title, viewcount, content"
					+ " FROM board_cafe "
					+ " WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			//sql 문이 미완성이라면 여기서 완성
			pstmt.setInt(1, num);
			//select 문 수행하고 결과값 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 에 담긴 내용 추출
			while (rs.next()) {
				dto = new CafeDto();
				dto.setNum(num);
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setViewCount(rs.getInt("viewcount"));
				dto.setContent(rs.getString("content"));
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close(); //Connection 이 Connection Pool 에 반납된다.
			} catch (Exception e) {
			}
		}
		return dto;
	}
	
	//삭제
	public boolean delete(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = " DELETE FROM board_cafe "
					+ " WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			//실행할 sql 문이 미완성이라면 여기서 완성
			pstmt.setInt(1, num);
			//sql 문을 수행하고 변화된(추가, 수정, 삭제된) row 의 갯수 리턴 받기
			rowCount = pstmt.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		//만일 변화된 row 의 갯수가 0 보다 크면 작업 성공
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//전체 글의 갯수를 리턴해주는 메소드
	public int getCount() {
		//글의 갯수를 담을 지역변수
		int count=0;
		//필요한 객체의 참조값을 담을 지역변수 미리 만들기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//DbcpBean 객체를 이용해서 Connection 객체를 얻어온다(Connection Pool 에서 얻어오기)
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = "SELECT MAX(ROWNUM) AS num FROM board_cafe";
			pstmt = conn.prepareStatement(sql);
			//sql 문이 미완성이라면 여기서 완성

			//select 문 수행하고 결과값 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 에 담긴 내용 추출
			while (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close(); //Connection 이 Connection Pool 에 반납된다.
			} catch (Exception e) {
			}
		}
		return count;
	}
	
	//페이지에 해당하는 목록을 리턴해주는 메소드
	public List<CafeDto> getList(CafeDto dto){
		List<CafeDto> list = new ArrayList<>();
		//필요한 객체의 참조값을 담을 지역변수 미리 만들기
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//DbcpBean 객체를 이용해서 Connection 객체를 얻어온다(Connection Pool 에서 얻어오기)
			conn = new DbcpBean().getConn();
			//실행할 sql 문
			String sql = " SELECT * "
					+ "	FROM "
					+ "		(SELECT result1.*, ROWNUM AS rnum "
					+ "		FROM "
					+ "			(SELECT num, writer, title, content, viewcount, regdate "
					+ "			FROM board_cafe "
					+ "			ORDER BY num DESC) result1)"
					+ "	WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			//sql 문이 미완성이라면 여기서 완성
			pstmt.setInt(1, dto.getStartNum());
			pstmt.setInt(2, dto.getEndNum());
			//select 문 수행하고 결과값 받아오기
			rs = pstmt.executeQuery();
			//반복문 돌면서 ResultSet 에 담긴 내용 추출
			while (rs.next()) {
				CafeDto tmp = new CafeDto();
				tmp.setNum(rs.getInt("num"));
				tmp.setWriter(rs.getString("writer"));
				tmp.setTitle(rs.getString("title"));
				tmp.setContent(rs.getString("content"));
				tmp.setViewCount(rs.getInt("viewcount"));
				tmp.setRegdate(rs.getString("regdate"));
				list.add(tmp);
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close(); //Connection 이 Connection Pool 에 반납된다.
			} catch (Exception e) {
			}
		}
		return list;
	}
	
	public boolean viewCount(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = " UPDATE board_cafe "
					+ " SET viewCount = viewCount+1 "
					+ " WHERE num = ? ";
			pstmt = conn.prepareStatement(sql);
			//실행할 sql 문이 미완성이라면 여기서 완성
			pstmt.setInt(1, num);
			//sql 문을 수행하고 변화된(추가, 수정, 삭제된) row 의 갯수 리턴 받기
			rowCount = pstmt.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		//만일 변화된 row 의 갯수가 0 보다 크면 작업 성공
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
}
