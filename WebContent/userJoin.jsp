<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>강의평가 웹 사이트</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
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
%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
		<button class="navbar-toggler" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">회원관리</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
					<%
						if(userID == null) {
					%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
					<%
						} else {
					%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
					<%
						}
					%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class="container mt-5" style="max-width: 560px;">
		<form method="post" action="./userRegisterAction.jsp">
		<h3 class="text-center mb-3">회원가입</h3>
			<div class="form-group input-group mb-3">
				<input id="userID" type="text" name="userID" placeholder="아이디" class="form-control">
				<div class="input-group-append">
					<span class="btn btn-default input-group-text" type="button" onclick="userIDCheck();">중복체크</span>
				</div>
			</div>
			<div class="form-group">
				<input type="password" name="userPassword" placeholder="비밀번호" class="form-control">
			</div>
			<div class="form-group">
				<input type="password" name="userPassword2" placeholder="비밀번호확인" class="form-control">
			</div>
			<div class="form-group">
				<input type="text" name="userName" placeholder="이름" class="form-control">
			</div>
			<div class="form-group">
				<input type="text" name="studentID" placeholder="학번" class="form-control">
			</div>
			<div class="form-group">
				<input type="email" name="userEmail" placeholder="이메일" class="form-control">
			</div>
			<div class="row">
				<div class="col-6" style="padding-right: 5px;"><button type="submit" class="btn btn-primary btn-block">가입</button></div>
				<div class="col-6" style="padding-left: 5px;"><button type="submit" class="btn btn-secondary btn-block ">취소</button></div>
			</div>
		</form>
		
	</section>

	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>