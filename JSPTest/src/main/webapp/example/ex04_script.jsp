<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
		
	//스크립틀릿은 맨 위나 맨 아래에 위치함. (어디든 출력 코드보다 위로)
	//주로 맨 위에 경우에 따라 맨아래
	
	int a = 10;
	int b = 20;
	int c = a + b;
		
%>
		
		
		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 06/21 -->
			
		<div>결과: <%= c %></div>

</body>
</html>