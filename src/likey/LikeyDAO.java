package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class LikeyDAO {
	
DataSource dataSource;
	
	public LikeyDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/Lecture");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int like(String userID, String evaluationID, String userIP) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO LIKEY VALUES (?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, evaluationID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) 
					pstmt.close();
				if (conn != null) 
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 추천 중복 오류
	}
}
