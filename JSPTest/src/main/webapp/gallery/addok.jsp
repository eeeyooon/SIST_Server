<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.test.jsp.DBUtil"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 파일(이미지) 업로드
	//2. 데이터 가져오기
	//3. DB 작업
	//	2.1 DB 연결
	//	2.2 SQL
	//	2.3 종료
	//4. 마무리(feedback)
	
	
	//1.
	String path = application.getRealPath("/gallery/images");

	int size = 1024 * 1024 * 100;
	
	String filename = "";
	String subject = "";
	int result = 0;
	
	try {
		
		MultipartRequest multi = new MultipartRequest(
											request,
											path,   
											size, 	 
											"UTF-8", 
											new DefaultFileRenamePolicy() 
										);

		//2. 
		filename = multi.getFilesystemName("attach");
		subject = multi.getParameter("subject");
		
		
		
		
		try {
			
			//3.			
			Connection conn = null;
			PreparedStatement stat = null;
			
			conn = DBUtil.open();
			
			//System.out.println(conn.isClosed()); //false
			
			String sql = "insert into tblGallery (seq, filename, subject, regdate) values (seqGallery.nextval, ?, ?, default)";
			
			stat = conn.prepareStatement(sql);
			
			stat.setString(1, filename);
			stat.setString(2, subject);
			
			result = stat.executeUpdate();
			
		
		} catch (Exception e) {
			System.out.println(e);
		}
		
	} catch (Exception e) {
		System.out.println(e);		
	}
	
		

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/gallery/inc/asset.jsp" %>
<style>

</style>
</head>
<body>

	<script>
		<% if (result > 0) { %>
		
		location.href = 'list.jsp';
		
		<% } else { %>
		
		alert('추가 실패;;');
		history.back();
		
		<% } %> 
	</script>

</body>
</html>
















