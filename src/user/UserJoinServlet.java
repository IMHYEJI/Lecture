package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserJoinServlet")
public class UserJoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID"); //Form태그로 전송받은 파라미터를 변수에 저장
		String userPassword = request.getParameter("userPassword");
		String userPassword2 = request.getParameter("userPassword2");
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		if(userID == null || userID.equals("") || userPassword == null ||  userPassword.equals("") 
				|| userPassword2 == null || userPassword2.equals("") || userName == null || userName.equals("") 
				|| userEmail == null || userEmail.equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 내용을 입력하세요.')");		
			script.println("history.back();");		
			script.println("</script>");
			script.close();
			return;
		}
		if(! userPassword.equals(userPassword2)) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 다시 확인하세요.')");		
			script.println("history.back();");		
			script.println("</script>");
			script.close();
			return;
		}
		int result = new UserDAO().join(userID, userPassword, userName, userEmail); //입력상 오류가 없을 시 UAO의 join 실행
		if(result == 1) {
			request.getSession().setAttribute("userID", userID); //회원가입 성공시 로그인을 위한 id 세션값 저장
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입에 성공했습니다.')");		
			script.println("location.href = 'index.jsp';");		
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");		
			script.println("history.back();");		
			script.println("</script>");
			script.close();
			return;
		}
	}
}
