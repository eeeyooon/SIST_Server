<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//경로
String path = application.getRealPath("/gallery/images");

//업로드 파일의 최대 크기 지정(제한을 둬야함)
//- 바이트 단위
int size = 1024 * 1024 * 100; // 100MB

//변수선언 > 다운x 열기만 할거니까 filename만 필요함
String filename = "";		//하드디스크에 저장된 이름



try {
	
	MultipartRequest multi = new MultipartRequest(
									request, //원래의 request 객체
									path,    //업로드 위치
									size, 	 //최대 크기
									"UTF-8", //인코딩 지정
									new DefaultFileRenamePolicy() //파일명 관리 객체
								);
	

	//업로드한 이미지명 > DB 저장해야함. (file자체가 아니라 file이름을)
	filename = multi.getFilesystemName("attach");
	
	
} catch (Exception e) {
	System.out.println(e);
}

response.sendRedirect("list.jsp");



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
				
		<form method="POST" action="addok.jsp" enctype="multipart/form-data">
		
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
















