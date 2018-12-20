package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID"); 
		String userPassword = request.getParameter("userPassword");
		if(userID == null || userID.equals("") || userPassword == null ||  userPassword.equals("")){
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('모든 내용을 입력하세요.')");		
			script.println("history.back();");		
			script.println("</script>");
			script.close();
			return;
		}
		int result = new UserDAO().login(userID, userPassword);
		if(result == 1) {
			request.getSession().setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");	
			script.println("location.href = 'index.jsp';");		
			script.println("</script>");
			script.close();
			return;
		} else if(result == 2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀렸습니다.')");		
			script.println("history.back();");		
			script.println("</script>");
			script.close();
			return;
		} else if(result == 0 || result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");		
			script.println("history.back();");		
			script.println("</script>");
			script.close();
			return;
		} 
	}
}
