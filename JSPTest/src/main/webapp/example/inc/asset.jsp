<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- inc > asset.jsp -->

<!-- 

	06/21
	
	
	물리 경로(실제 서버의 상태)
	- webapp > ex01.jsp
	
	
	외부 환경 > 경로(다른 사람(브라우저)가 보는 상태
	http://localhost:8090/JSPTest/ex01.jsp
	
	
	JSP 페이지 + HTML 태그 > 자원 경로(URL)
	1. 상대 경로
	2. 절대 경로
		- '/' > 'http://localhost:8090'
		- '/JSPTest' > webapp
		
		06/22 /JSPTest를 /jsp로 변경
		
		request.getContextPath() -> 이걸 사용하면 변경을 해도 알아서 변경된 컨텍스트 이름을 가져옴.
	
 -->


<!--  
<link rel="stylesheet" href="../css/bootstrap.css" />
-->

<link rel="stylesheet" href="<%= request.getContextPath() %>/example/css/bootstrap.css" />
<script src="<%= request.getContextPath() %>/example/js/jquery-1.12.4.js"></script>
<script src="<%= request.getContextPath() %>/example/js/bootstrap.js"></script>












