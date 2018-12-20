<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>강의평가 웹 사이트</title>
		<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./bootstrap/css/custom.css">
    <!-- Bootstrap core CSS -->
    <link href="./bootstrap/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.5.0/css/all.css' integrity='sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU' crossorigin='anonymous'>
    <!-- Custom fonts for this template -->
    <link href="./bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
	

    <!-- Custom styles for this template -->
    <link href="./bootstrap/css/clean-blog.min.css" rel="stylesheet">
  </head>
  <body>
  <%
	request.setCharacterEncoding("UTF-8");
    String lectureDivide = "전체";
    String searchType = "최신순";
    String search = "";
    int pageNumber = 0;
    if(request.getParameter("lectureDivide") != null) {
    	lectureDivide = request.getParameter("lectureDivide");
    }
    if(request.getParameter("searchType") != null) {
    	searchType = request.getParameter("searchType");
    }
    if(request.getParameter("search") != null) {
    	search = request.getParameter("search");
    }
    if(request.getParameter("pageNumber") != null) {
    	try{
    		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    	} catch (Exception e) {
    		System.out.println("검색 페이지 번호 오류");
    	}
    }
    
  	String userID = null;
    if (session.getAttribute("userID") != null) {
    	userID = (String)session.getAttribute("userID");
    }
    if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
		script.close();
		return;
    }
  %>
     <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand" href="index.jsp" style="font-weight:100">강의평가사이트</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="index.jsp">메인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="evaluation.jsp">강의평가</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="post.html">강의평가결과</a>
            </li>
       		<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원관리</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					<%
						if (userID == null) {
					%>
						<a class="dropdown-item" href="login.jsp">로그인</a>
						<a class="dropdown-item" href="join.jsp">회원가입</a>
					<%
						} else {
					%>
						<a class="dropdown-item" href="logout.jsp">로그아웃</a>
					<%
						}
					%>
					</div>
				</li>
				</ul>
      	</div>
      </div>
    </nav>

    <!-- Page Header -->
    <header class="masthead" style="background-image: url('./bootstrap/img/post-bg.jpg')">
      <div class="overlay"></div>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <div class="page-heading">
              <h1>강의평가</h1>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <section class="container">
    	<div class="row">
    		<div class="col-lg-8">
				<form method="get" action="./evaluation.jsp" class="form-inline">
					<select name="lectureDivide" class="form-control mx-1 mt-2">
						<option value="전체">전체</option>
						<option value="전공"<% if(lectureDivide.equals("전공")) out.println("selected"); %>>전공</option>
						<option value="교양"<% if(lectureDivide.equals("교양")) out.println("selected"); %>>교양</option>
					</select>
					<select name="searchType" class="form-control mx-1 mt-2">
						<option value="최신순">최신순</option>
						<option value="추천순"<% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
					</select>
					<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
					<button type="submit" class="btn btn-outline-primary mx-1 mt-2">검색</button>
				</form>
			</div>
			<div class="col-lg-4 float-right">
					<a class="btn btn-danger mx-1 mt-2 float-right" data-toggle="modal" href="#registerModal">등록하기</a>
			</div>	
		</div>	
		
		<%
			ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
			evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
			if (evaluationList != null) {
				for (int i = 0; i < evaluationList.size(); i++) {
					if(i == 5) break;
					EvaluationDTO evaluation = evaluationList.get(i);
		%>
		
		<!-- card1 헤더 -->
		<div class="card bg-information mt-3">
			<div class="card-header">
				<div class="row">
					<div class="col-8 text-left"><%=evaluation.getLectureName()%>&nbsp;<small><%= evaluation.getProfessorName() %>교수 </small> 
					&nbsp;<small style="font-color:skyblue">(<%=evaluation.getLectureYear()%>년&nbsp;<%=evaluation.getSemesterDivide()%> <%=evaluation.getLectureDivide()%>) </small></div>
					<div class="col-4 text-right">종합 <span style="color: red;"><%= evaluation.getTotalScore() %></span>
					<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID() %>">  <i class='far fa-thumbs-up' style='font-size:24px'></i> </a><span style="color: red;"><%= evaluation.getLikeCount() %></span>
					</div>
				</div>
			</div>
		<!-- card1 바디 -->
		<div class="card-body">
			<h5 class="card-title">
				<%= evaluation.getEvaluationTitle() %>
			</h5>
			<p class="card-text"><%= evaluation.getEvaluationContent() %></p>
			<div class="row">
				<div class="col-12 text-right">
					재미도 <span style="color: blue;"><%= evaluation.getInterestScore() %></span>
					성취도 <span style="color: blue;"><%= evaluation.getAchievementScore() %></span>
					난이도 <span style="color: blue;"><%= evaluation.getDifficultyScore() %></span>
									</div>
			</div>
		</div>
	</div>
		<%
			}
			}
		%>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
		<%
			if(pageNumber <= 0) {
		%>
			<a class="page-link disabled">이전</a>
		<%
			} else {
		%>
			<a class="page-link" href="./evaluation.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=
			<%=URLEncoder.encode(searchType, "UTF-8") %>&search=<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=
			<%=pageNumber - 1 %>">이전</a>
		<%
			}
		%>
		</li>
		<li>
		<%
			if(evaluationList.size() < 6) {
		%>
			<a class="page-link disabled">다음</a>
		<%
			} else {
		%>
			<a class="page-link" href="./evaluation.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=
			<%=URLEncoder.encode(searchType, "UTF-8") %>&search=<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=
			<%=pageNumber + 1 %>">다음</a>
		<%
			}
		%>
		</li>
	</ul>
	<!-- 등록하기 modal -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./EvaluationRegistServlet" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label>
								<input type="text" name="lectureName" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label>
								<input type="text" name="professorName" class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수강 연도</label>
								<select name="lectureYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018" selected>2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023">2023</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>수강 학기</label>
								<select name="semesterDivide" class="form-control">
									<option value="1학기" selected>1학기</option>
									<option value="여름계절학기">여름계절학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울계절학기">겨울계절학기</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>강의 구분</label>
								<select name="lectureDivide" class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양">교양</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합</label>
								<select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>흥미도</label>
								<select name="interestScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>성취도</label>
								<select name="achievementScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>난이도</label>
								<select name="difficultyScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">등록</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
    
    

    <!-- Footer -->
    <footer>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <p class="copyright text-muted">Copyright &copy; Your Website 2018</p>
          </div>
        </div>
      </div>
    </footer>

   <!-- Bootstrap core JavaScript -->
    <script src="./bootstrap/vendor/bootstrap/js/jquery.min.js"></script>
    <script src="./bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Contact Form JavaScript -->
    <script src="./bootstrap/js/jqBootstrapValidation.js"></script>
    <script src="./bootstrap/js/contact_me.js"></script>

   <!-- Custom scripts for this template -->
    <script src="./bootstrap/js/clean-blog.min.js"></script>

  </body>

</html>
