
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.test.jsp.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//1. 인코딩 처리
	//2. 데이터 가져오기
	//3. DB 작업 (DAO는 나중에, 일단 직접 처리)
	//	3.1 DB 연결
	//  3.2 SQL
	//	3.3 종료
	//4. 마무리 작업 (=feedback. 안내메세지 띄우기, 자동으로 리스트 돌아가기 등)
	
	//1.
	request.setCharacterEncoding("UTF-8");
	
	//2. 
	String name = request.getParameter("name");
	String age = request.getParameter("age");
	String gender = request.getParameter("gender");
	String tel = request.getParameter("tel");
	String address = request.getParameter("address");
	
	//추가로 seq 받기 (수정할때 필요)
	String seq = request.getParameter("seq");
	
	int result = 0;
	//try-catch문에 result를 선언하면 script if문에서 사용하지 못하니까 일단 여기서 먼저 선언
	
	try {
		//3.
		//DBUtil util = new DBUtil();
		
		//연결이 되는지 확인
		
		Connection conn = null;
		Statement stat = null;
		PreparedStatement pstat = null;
		
		conn = DBUtil.open();
		
		//System.out.println(conn.isClosed()); //false가 나와야 연결이 잘 된 것!
		
		//java.lang.ClassNotFoundException: oracle.jdbc.driver.OracleDriver
		// >> 이런 에러 뜨면 거의 100% jar 파일을 안가져온 것 > lib에 jar파일 추가
	
	
		String sql  = "update tblAddress set name = ?, age = ?, address = ?, gender = ?, tel = ? where seq = ?";
		
		pstat = conn.prepareStatement(sql);
		
		pstat.setString(1, name);
		pstat.setString(2, age);
		pstat.setString(3, address);
		pstat.setString(4, gender);
		pstat.setString(5, tel);
		
		//seq 추가
		pstat.setString(6, seq);
		
		
		result = pstat.executeUpdate();
		
		//4.
		if (result > 0) {
			//추가 성공
		} else {
			//추가 실패
		}
		
		// > 밑에 script에서 작업
	
	
	} catch (Exception e) {
		System.out.println(e);
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록</title>
<%@ include file="/address/inc/asset.jsp" %>
<style>

</style>
</head>
<body>
	
	<!-- template.jsp > addok.jsp > editok.jsp -->
	<main>
		<header>
			<%@ include file="inc/header.jsp"%>
		</header>
		<section>
			<div class="section content">
			
				<!-- 2. tag로 메세지 보여주는 방법(+페이지이동) -->
				
				<%-- <% if (result > 0) { %>
				<div>추가 성공!</div>
				<a href="list.jsp">목록 보기</a>
				
				<% } else { %>
				<div>추가 실패;</div>
				<a href="#!" onclick="history.back();">돌아가기</a>
				
				<% } %> --%>
				<!-- #을 붙이면 클릭해도 아무반응x함. 아무 링크로 이동 x. 뒤에 온클릭 땜에 이동 가능 -->
				
				
			</div>
		</section>
	</main>
	
	<script>
		
		/* 1. Script로 하는 방법 */
		<%-- <% if (result > 0) { %>
		alert('추가 성공!');
		location.href = 'list.jsp';
		
		<% } else { %>
		
		
		alert('추가 실패;;');
		history.back();
		
		<% } %> --%>
		
		
		
		/* 3. 요즘 자주 하는 방법 (성공 메세지 띄우지 않음) */
		<% if (result > 0) { %>
		location.href = 'list.jsp';
		
		<% } else { %>
		alert('수정 실패;');
		history.back();
		
		<% } %> 
		
	</script>

</body>
</html>




