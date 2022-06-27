<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	<!-- webapp > WEB-INF > views > hello.jsp 
			>> 이 안에다가 JSP 넣지말아야함. > 그럼 외부에서 접근할 수 있는 방법 x (404에러)
			이제부터 우린 JSP는 서블릿으로만 호출할 것. 서블릿이 JSP를 부를 땐 에러가 안남..?
			단독으로 JSP 부르는건 XXX
			-->
	<div class="container">
		<h1>Hello</h1>
		DB: <%= request.getAttribute("name") %>
		
		
	</div>
	
	<script>
	
	</script>

</body>
</html>









