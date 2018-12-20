<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
%>
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

    <!-- Custom fonts for this template -->
    <link href="./bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
	

    <!-- Custom styles for this template -->
    <link href="./bootstrap/css/clean-blog.min.css" rel="stylesheet">

  </head>

  <body>

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
    <header class="masthead" style="background-image: url('./bootstrap/img/contact-bg.jpg')">
      <div class="overlay"></div>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <div class="page-heading">
              <h1>회원가입</h1>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <div class="container">
      <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
          <!-- Contact Form - Enter your email address on line 19 of the mail/contact_me.php file to make this form work. -->
          <!-- WARNING: Some web hosts do not allow emails to be sent through forms to common mail hosts like Gmail or Yahoo. It's recommended that you use a private domain email address! -->
          <!-- To use the contact form, your site must be on a live web host with PHP! The form will not work locally! -->
          <form method="post" action="./UserJoinServlet">
            <div class="control-group">
              <div class="form-group floating-label-form-group controls">
                <label>학번</label>
                <input id="userID" type="text" class="form-control" placeholder="학번" name="userID" required data-validation-required-message="Please enter your userID.">
                <p class="help-block text-danger"></p>
              </div>
            </div>
             <div class="control-group">
              <div class="form-group col-xs-12 floating-label-form-group controls">
                <label>비밀번호</label>
                <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" required data-validation-required-message="Please enter your password.">
                <p class="help-block text-danger"></p>
              </div>
            </div>
             <div class="control-group">
              <div class="form-group col-xs-12 floating-label-form-group controls">
                <label>비밀번호 확인</label>
                <input type="password" class="form-control" placeholder="비밀번호 확인" name="userPassword2" required data-validation-required-message="Please enter your password again.">
                <p class="help-block text-danger"></p>
              </div>
            </div>
            <div class="control-group">
              <div class="form-group floating-label-form-group controls">
                <label>이름</label>
                <input type="text" class="form-control" placeholder="이름" name="userName" required data-validation-required-message="Please enter your name.">
                <p class="help-block text-danger"></p>
              </div>
            </div>
            <div class="control-group">
              <div class="form-group floating-label-form-group controls">
                <label>이메일</label>
                <input type="email" class="form-control" placeholder="이메일" name="userEmail" required data-validation-required-message="Please enter your email address.">
                <p class="help-block text-danger"></p>
              </div>
            </div>
            <br>
            <div id="success"></div>
            <div class="row">
           	 	<div class="col-3" style="padding-right: 5px;"></div>
				<div class="col-6" style="padding-right: 5px;"><button type="submit" class="btn btn-primary btn-block">가입</button></div>
				<div class="col-3" style="padding-right: 5px;"></div>
			</div>
          </form>
        </div>
      </div>
    </div>

    <hr>

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
