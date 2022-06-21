<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	p {
		color: blue;
	}
</style>
</head>
<body>
	<!-- 06/20 -->
	<!-- http://localhost:8090/JSPTest/ex01.jsp -->
	<!-- 이렇게 보여도 HTML파일이 아니라 Java클래스임 -->
	<!-- 얘도 Java로 만든 Java프로그램임. 겉모습에 속으면 안됨 -->
	
	<h1>JSP 페이지</h1>
	<p>문단입니다.</p>
	
	<% 
	
	//여기는 자바 영역입니다.(= 자바 클래스 영역)
	Calendar now = Calendar.getInstance();
	
	
	
	%>
	
	<p>현재 날짜: <%= String.format("%tT", now) %></p>
	
	<%@ include file="inc/copyright.jsp" %>
	
</body>
</html>






