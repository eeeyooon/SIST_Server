<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!-- inc > ex21_sub.jsp -->

<div>
	<h1>조각 페이지</h1>
	
	조각 페이지 영역
	
	<%-- <div>1. 지역 변수 a: <%= a %></div>
	<p>2. 멤버 변수 b: <%= b %></p> --%>
	<!-- 위에 두개 작동은 잘되는데 빨간줄뜨니까 주석처리 -->
	<p>3. pageContext c: <%= pageContext.getAttribute("c") %></p>		
	<p>4. request d: <%= request.getAttribute("d") %></p>
	
</div>