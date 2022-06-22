<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/example/inc/asset.jsp" %>
</head>
<body>

	<div class="container">
	
	<h1>세션에 값 삭제하기</h1>
	<%
		session.removeAttribute("data");
	%>
	<a href="ex17_session.jsp">시작 페이지</a>
	
	
	</div>
	
	<script>
	
	</script>

</body>
</html>