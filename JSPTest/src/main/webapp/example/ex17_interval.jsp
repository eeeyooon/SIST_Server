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
	<!-- ex17_interval.jsp -->
	<div class="container">
	
		<h1>세션 만료 시간 지정하기</h1>
		<%
			//(초) -기존 30분에서 만료시간을 30초로 바꾼것 
			//>> 30초가 지나면 Session Create Time도 바뀌고 SessionIsNew도 true, 데이터없음 (세션만료됨)
			// >>> 근데 잘 사용안함
			//		세션의 용도 : (웹서핑 중에서 발생하는) 개인 정보 보관, 장바구니(요즘엔 세션말고 DB에 함), 로그인 상태 보관
			// 사용자를 생각했을 땐 세션 만료시간이 긴게 좋지만, 서버관리차원에선 짧은게 좋음 > 그래서 그냥 건들지 않고 보통 30분 그대로)
			
			session.setMaxInactiveInterval(30);
		%>
		<a href="ex17_session.jsp">시작 페이지</a>
	
	
	</div>
	
	<script>
	
	</script>

</body>
</html>