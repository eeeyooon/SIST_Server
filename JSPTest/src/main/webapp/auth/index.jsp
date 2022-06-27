<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/auth/inc/asset.jsp" %>
<style>

</style>
</head>
<body>
	<!-- index.jsp -->
	<div class="container">
		<h1>인증, 허가</h1>
			
			<!-- 
				
				- Register, Login, Logout
				- Signup, signin, signout
			
			 -->
		
		<% if (session.getAttribute("auth") == null) { %>
		<fieldset>
			<input type="button" value="로그인(Log in, Sign in)" 
			class="btn btn-primary" onclick="location.href='login.jsp';">
		</fieldset>
		
		<% } %>
		
		<% if (session.getAttribute("auth") != null) { %>
		<fieldset>
			<input type="button" value="로그아웃(Log out, Sing out)" 
			class="btn btn-primary" onclick="location.href='logout.jsp';">
			
			<hr>
			
			<div>
				<%= session.getAttribute("name") %> (<%= session.getAttribute("auth") %>) 
				<%= session.getAttribute("lv") %>
			</div>
			
			
		</fieldset>
		<% } %>
		
		
		<hr>
		
		<!-- 등급 > 허가 -->
		
		<!-- 1. 비눗칠 방식 (로그인한 사람만 버튼이 노출됨) -->
		<% if (session.getAttribute("auth") != null
				&& (int)session.getAttribute("lv") < 3) { %>
		<a href="member.jsp" class="btn btn-success">회원 전용 페이지</a>
		<% } %>
		
		<hr>
		
		<!-- 2. 노출 방식(로그인 안해도 버튼은 노출됨 -> 접근은 x) -->
		<% if (session.getAttribute("auth") == null
				|| (int)session.getAttribute("lv") == 3) { %>
		<a href="#!" class="btn btn-success" onclick="alert('회원만 접근이 가능합니다.');">회원 전용 페이지</a>
		<% } else { %>
		<a href="member.jsp" class="btn btn-success">회원 전용 페이지</a>
		<% } %>
		
		
		
		<hr>
		
		
		<% if (session.getAttribute("auth") == null
				|| (int)session.getAttribute("lv") != 1) { %>
		<a href="#!" class="btn btn-success" onclick="alert('관리자만 접근이 가능합니다.');">관리자 전용 페이지</a>
		<% } else { %>
		<a href="admin.jsp" class="btn btn-success">관리자 전용 페이지</a>
		<% } %>
		
		
		
		
	</div>
	
	<script>
	
	</script>

</body>
</html>


