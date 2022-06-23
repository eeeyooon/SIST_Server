<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	//06.23
	//내장 객체 생명 주기 + 페이지 이동 시 데이터 전달하기
	
	//1. 지역 변수
	int a = 10;


	//3. pageContext 객체 
	pageContext.setAttribute("c", 30);
	//  pageContext c: null  >> 실패

	
	//4. request 객체
	request.setAttribute("d", 40);
	// request d: 40 >> 성공
	
	
	//5. session 객체
	session.setAttribute("e", 50);
	// session e: 50 >> 성공
	
	//6. application 객체
	application.setAttribute("f", 60);
	// application f: 60 >> 성공

	//response.sendRedirect("ex21_scope_2.jsp");
	//pageContext.forward("ex21_scope_2.jsp");
	
	//둘 중 뭘 쓰던간에 지역변수는 다른 페이지에선 살아있지 못함.
	//그나마 forward로 테스트
	//session, application은 response.sendRedirect로해서 성공(나머지는 다 실패)
	
	
	//생명주기
	//- pageContext < request < session < application
	//- (한 페이지)    (한 페이지~) (접속 중)  (사이트가 동작중)
	
	
	//http://localhost:8090/jsp/example/ex21_scope_1.jsp

%>
<%!
	//2. 멤버 변수
	int b = 20;
	
	//지역변수나 멤버변수 모두 다른 페이지에선 사용할 수 없음.

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
	
	<!-- ex21_scope_1.jsp  -->
	<div class="container">
		<h1>첫번째 페이지</h1>
		
		
		<a href="ex21_scope_2.jsp">두번째 페이지로 이동하기</a>
	</div>
	
	<script>
	
	</script>

</body>
</html>