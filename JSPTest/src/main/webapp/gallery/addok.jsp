<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.test.jsp.DBUtil"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	
	/* 
	파일 업로드를 해야해서 <form>에 enctype을 붙이면 request.getParameter() 동작 안하는거 주의
	*/
	
	//1.
	request.setCharacterEncoding("UTF-8");
	


	//2. 
	String filename = request.getParameter("filename");
	String subject = request.getParameter("attach");
	//String regdate = request.getParameter("regdate");
	
	
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
	
	
		String sql  = "insert into tblGallery (seq, filename, subject) values (seqGallery.nextval, ?, ?)";
		
		pstat = conn.prepareStatement(sql);
		
		pstat.setString(1, filename);
		pstat.setString(2, subject);
		//pstat.setString(3, regdate);

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
<title>Image Gallery</title>
<%@ include file="/gallery/inc/asset.jsp" %>
<style>
	.container {
		width: 810px;
		margin-bottom: 100px;
	}
	
	form {
		margin-top: 30px;
	}
	
	.container  .table {
		width: 750px;
		margin-left: auto;
		margin-right: auto;
	}	
	
</style>
</head>
<body>

	<!-- list.jsp -->
	<div class="container">
		<h1>Image Gallery <small>Add</small></h1>
				
		<form>
		<table class="table table-bordered">
			<tr>
				<th>제목</th>
				<td><input type="text" name="subject" required class="form-control"></td>
			</tr>
			<tr>
				<th>이미지</th>
				<td><input type="file" name="attach" required></td>
			</tr>
		</table>
		
		<div>
			<input type="button" value=" 돌아가기 "
				class="btn btn-secondary" onclick="location.href='list.jsp';">
				
			<input type="submit" value=" 이미지 업로드 "
				class="btn btn-success">
			
		</div>
		</form>
		
		
	</div>
	
	
	
	
	
</body>
</html>
