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
<style>

</style>
</head>
<body>
	
	<!-- 
	
	 	***********JSP에서 브라우저 실행하지말고 서블릿에서 해 *************
	
	 -->
	<!-- hello.jsp -->
	<div class="container">
		<h1>Hello</h1>
		<%= request.getAttribute("name") %>
	</div>
	
	<script>
	
	</script>

</body>
</html>


