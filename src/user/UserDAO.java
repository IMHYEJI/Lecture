package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {

	DataSource dataSource;
	
	public UserDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/Lecture");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 회원가입 */
	public int join(String userID, String userPassword, String userName, String userEmail) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL); // prepareStatement에서 해당 sql을 미리 컴파일한다.
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setString(4, userEmail);
			return pstmt.executeUpdate();   //쿼리 실행
		} catch (Exception e) {            // 예외가 발생하면 예외 상황을 처리한다.
			e.printStackTrace();
		} finally {                // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다. (순서중요)
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	/* 로그인 */
	public int login(String userID, String userPassword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM USER WHERE userID = ?"; //SELECT문의 경우 결과값을 받는 ResultSet객체를 이용
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); //질의에 성공하면 결과값을 rs에 담음, executeQuery()메서드 사용
			if (rs.next()) {
				if (rs.getString("userPassword").equals(userPassword)) {
					return 1; // 성공
				}
				return 2; // 비밀번호 틀림
			} else {
				return 0; // 해당사용자 존재하지 않음
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;	
	}
}
