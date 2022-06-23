<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//06.23

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

	<!-- ex21_scope_2.jsp  -->
	<div class="container">
		<h1>두번째 페이지</h1>
		
		<%-- <p>1. 지역 변수 a: <%= a %></p> --%>
		
		<%-- <p>2. 멤버 변수 b: <%= b %></p> --%>
		
		<p>3. pageContext c: <%= pageContext.getAttribute("c") %></p>
		<!-- 3. pageContext c: null  >> 실패 -->
		
		<p>4. request d: <%= request.getAttribute("d") %></p>
		<!-- 4. request d: 40  >> 성공 -->
		
		<p>5. session e: <%= session.getAttribute("e") %></p>
		<!-- 5. session e: 50 -->
		
		<p>6. application f: <%= application.getAttribute("f") %></p>
		<!-- 6. application f: 60 -->
		
	
		<!-- <a href="ex21_scope_3.jsp">세번째 페이지로 이동하기</a> -->
	
	</div>
	
	<script>
	
	</script>

</body>
</html>