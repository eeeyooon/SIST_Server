<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.test.jsp.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//1. 데이터 가져오기(seq)
	//2. DB 작업 > 파일명 알아내기
	//3. 파일 삭제
	//4. DB 작업 > 레코드 삭제하기
	//5. 마무리(feedback)
	
	//1.
	String seq = request.getParameter("seq");
	
	
	int result = 0;
	
	try {
		
		//2.		
		Connection conn = null;
		PreparedStatement pstat = null;
		ResultSet rs = null;
		
		conn = DBUtil.open();
		
		
		String sql = "select filename from tblGallery where seq = ?";
		
		pstat = conn.prepareStatement(sql);

		pstat.setString(1, seq);
		
		rs = pstat.executeQuery();
		
		String filename = "";
		
		if (rs.next()) {
			filename = rs.getString("filename");
		}
		
		//3.
		String path = application.getRealPath("/gallery/images");
	
		
		File img = new File(path + "/" + filename);
		
		img.delete();
		
		
		//4. 
		sql = "delete from tblGallery where seq = ?";
		
		pstat = conn.prepareStatement(sql);

		pstat.setString(1, seq);
		
		result = pstat.executeUpdate();
		
	
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


	<script>
	
		<% if (result > 0) { %>
		
		location.href = 'list.jsp';
		
		<% } else { %>
		
		alert('삭제 실패;;');
		history.back();
		
		<% } %> 
	
	</script>

</body>
</html>
















