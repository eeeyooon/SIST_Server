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
</head>
<body>

	<!-- ex17_reset.jsp -->
	<div class="container">
		
		<h1>세션 초기화하기</h1>
		<%
			
			//세션 자체를 처음 모습으로 초기화
			session.invalidate();	//모든 저장했던 데이터가 삭제
		
		%>
		<a href="ex17_session.jsp">시작 페이지</a>
		
		<!-- 
		
		Session ID:C9E776758E1351AC4689B42D9A7901B4
		Session Create Time: 2022-06-22 15:27:51
		Session Max Inactive Interval: 1800
		Session isNew: false
		Session Data: 100
		
		---초기화 후 --
		
		Session ID:FCFC941F95DF843F6ED58BA34976E85A
		Session Create Time: 2022-06-22 15:28:14
		Session Max Inactive Interval: 1800
		Session isNew: true
		Session Data: 데이터 없음
		
		아이디가 새로 바뀜
		
		 -->
		
		
	</div>
	
	<script>
	
	</script>

</body>
</html>