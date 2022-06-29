<%@page import="com.test.jsp.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String seq = request.getParameter("seq");
	String complete = request.getParameter("complete");
	
	if (complete.equals("n")) {
		complete = "y";
	} else {
		complete = "n";
	}
	
	int result = 0;
	
	try {
		
		Connection conn = null;
		PreparedStatement stat = null;
		
		conn = DBUtil.open();
				
		String sql = "update tblTodo set complete = ? where seq = ?";
		
		stat = conn.prepareStatement(sql);
		
		stat.setString(1, complete);
		stat.setString(2, seq);
		
		result = stat.executeUpdate();
		
		
	} catch (Exception e) {
		System.out.println(e);
	}

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/todo/inc/asset.jsp" %>
<style>

</style>
</head>
<body>
	
	<script>
		<% if (result > 0) { %>
		
		location.href = 'list.jsp';
		
		<% } else { %>
		
		alert('수정 실패;;');
		history.back();
		
		<% } %> 
	</script>

</body>
</html>
















