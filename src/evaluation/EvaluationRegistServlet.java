package evaluation;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EvaluationRegistServlet")
public class EvaluationRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String lectureName = request.getParameter("lectureName");
	    String professorName = request.getParameter("professorName");
	    int lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
	    String semesterDivide = request.getParameter("semesterDivide");
	    String lectureDivide = request.getParameter("lectureDivide");
	    String evaluationTitle = request.getParameter("evaluationTitle");
	    String evaluationContent = request.getParameter("evaluationContent");
	    String totalScore = request.getParameter("totalScore");
	    String interestScore = request.getParameter("interestScore");
	    String achievementScore = request.getParameter("achievementScore");
	    String difficultyScore = request.getParameter("difficultyScore");
	    
	    
	    if(lectureName == null || lectureName.equals("") || professorName == null ||  professorName.equals("") 
				|| lectureYear == 0 || semesterDivide == null || semesterDivide.equals("") || lectureDivide == null || lectureDivide.equals("") 
				|| evaluationTitle == null || evaluationTitle.equals("") || evaluationContent == null || evaluationContent.equals("")
				|| totalScore == null || totalScore.equals("") || interestScore == null || interestScore.equals("")
				|| achievementScore == null || achievementScore.equals("") || difficultyScore == null || difficultyScore.equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 내용을 입력하세요.')");		
			script.println("history.back();");		
			script.println("</script>");
			script.close();
			return;
		}
	    EvaluationDAO evaluationDAO = new EvaluationDAO();
	    int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName, lectureYear, semesterDivide, lectureDivide, 
	    		evaluationTitle, evaluationContent, totalScore, interestScore, achievementScore, difficultyScore, 0));
	    if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('강의평가 등록을 실패했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('강의평가를 등록하였습니다.');");
			script.println("location.href = 'evaluation.jsp';");
			script.println("</script>");
			script.close();
			return;
		}
	}

}
