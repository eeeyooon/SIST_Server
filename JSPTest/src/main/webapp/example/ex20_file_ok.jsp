<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//06.23
	//경로
	String path = application.getRealPath("/example/images");
	
	//System.out.println(path);
	//C:\class\server\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPTest\example\images
	
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
		//filename = multi.getFilesystemName("attach");
		
		
	} catch (Exception e) {
		System.out.println(e);
	}
	
	response.sendRedirect("ex20_file_form.jsp");
	//업로드가 끝나면 처음 페이지로
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/example/inc/asset.jsp" %>
<style>

</style>
</head>
<body>

	<div class="container">
		이미지 업로드를 완료했습니다. 
	</div>
	
	<script>
	
	</script>

</body>
</html>