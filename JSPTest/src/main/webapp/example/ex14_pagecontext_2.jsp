<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//06.22
	
	
	int num = (int)request.getAttribute("num");
	//int num = 100;
	
	System.out.println(request.getAttribute("num"));
	

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
	
	</div>
		<h1>2번 페이지</h1>
		<div>num: <%= num %></div>
	<script>
	
	</script>

</body>
</html>