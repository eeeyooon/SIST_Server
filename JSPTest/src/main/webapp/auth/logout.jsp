<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	//1. 인증 티켓 삭제하기
	// - 로그아웃 != 세션 초기화
	
	session.removeAttribute("auth"); //로그아웃
	
	//로그아웃하면 계정 정보도 사라지게
	
	session.removeAttribute("name");
	session.removeAttribute("lv");
	
	//session.invalidate(); //세션 초기화
	//로그인 말고 세션을 다른 곳에 쓸 확률이 있으니 초기화 보단 삭제를 주로
	// 만약 절대로 로그인 말고는 아예 세션을 안쓴다면 삭제로..
	
	

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
	<!-- logout.jsp -->
	<div class="container">
	
	</div>
	
	<script>
		location.href='index.jsp';
	</script>

</body>
</html>


