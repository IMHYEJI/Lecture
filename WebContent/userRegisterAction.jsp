<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	String userPassword = null;
	String userPassword2 = null;
	String userName = null;
	String studentID = null;
	String userEmail = null;
	
	if(request.getParameter("userID") != null) {
		userID = request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	if(request.getParameter("userPassword2") != null) {
		userPassword2 = request.getParameter("userPassword2");
	}
	if(request.getParameter("userName") != null) {
		userName = request.getParameter("userName");
	}
	if(request.getParameter("studentID") != null) {
		studentID = request.getParameter("studentID");
	}
	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}
	
	if(userID == null || userID.equals("") || userPassword == null ||  userPassword.equals("") 
			|| userPassword2 == null || userPassword2.equals("") || userName == null || userName.equals("") 
			|| studentID == null || studentID.equals("") || userEmail == null || userEmail.equals("") ){
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
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userID, userPassword, userName, studentID, userEmail, SHA256.getSHA256(userEmail), false));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendAction.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>