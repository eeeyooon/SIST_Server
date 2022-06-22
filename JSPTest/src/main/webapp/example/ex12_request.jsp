<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="inc/asset.jsp" %>
</head>
<body>
	<!-- ex12_request.jsp -->
	<!-- 06/22 -->
	
	<p>요청 URL: <%= request.getRequestURL() %></p>
	<p>요청 서버 도메인: <%= request.getServerName() %></p>
	
	<!-- ex12_request.jsp?name=홍길동&age=22 -->
	<p>요청 쿼리 문자열: <%= request.getQueryString() %></p>
	
	<p>클라이언트 주소: <%= request.getRemoteAddr() %></p>
	<p>요청 방식: <%= request.getMethod() %></p>
	<p>컨텍스트 경로: <%= request.getContextPath() %></p>
	<p><%= request.getHeader("host") %></p>
	
	
	
	<%
	
	//request.getHeader("헤더명")
	
	Enumeration<String> e = request.getHeaderNames();
	
	while (e.hasMoreElements()) {
		String name = e.nextElement();
		System.out.println(name);
	}
	
	
	%>

	
	<!-- 
	
	요청 URL: http://localhost:8090/JSPTest/example/ex12_request.jsp

	요청 서버 도메인: localhost -> http://127.0.0.1/
	
	요청 쿼리 문자열: null
	
	클라이언트 주소: 0:0:0:0:0:0:0:1
	
	요청 방식: GET
	
	컨텍스트 경로: /JSPTest  -> jsp로 변경
	
	request.getHeader("host") : 127.0.0.1:8090
	
	
	 -->
	

</body>
</html>