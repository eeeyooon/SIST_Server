<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//06.23
	//파일 업로드 처리
	
	//인코딩
	request.setCharacterEncoding("UTF-8");
	
	//경로
	String path = application.getRealPath("/example/files");
	
	
	//업로드 파일의 최대 크기 지정(제한을 둬야함)
	//- 바이트 단위
	int size = 1024 * 1024 * 100; // 100MB
		
		
	//변수선언
	String txt = "";			//문자열
	String num = "";			//숫자
	
	
	//다중 파일이니까 컬렉션으로 (배열보다 다루기 편하니까)	
	ArrayList<String> filename = new ArrayList<String>();
	ArrayList<String> orgfilename = new ArrayList<String>();
	
	
	try {
		
		MultipartRequest multi = new MultipartRequest(
				request, //원래의 request 객체
				path,    //업로드 위치
				size, 	 //최대 크기
				"UTF-8", //인코딩 지정
				new DefaultFileRenamePolicy() //파일명 관리 객체(파일 중복을 피해줌-> 뒤에 인덱스 붙임)
			);
		
		//전송 데이터 가져오기
		txt = multi.getParameter("txt");
		num = multi.getParameter("num");
		
		//첨부파일들
		//<input type="file" name="attach1">
		//<input type="file" name="attach2">
		//<input type="file" name="attach3">
		
		Enumeration e = multi.getFileNames();
		
		
		while (e.hasMoreElements()) {
			String file = (String)e.nextElement();
			//System.out.println(file);
			
			//하드에 저장된 이름(중복방지처리까지 됨)
			filename.add(multi.getFilesystemName(file));
			
			//사용자가 올린 이름(원본 이름)
			orgfilename.add(multi.getOriginalFileName(file));
		}
		
		
		System.out.println(filename);
		System.out.println(orgfilename);
		
		
	} catch (Exception e) {
		System.out.println(e);
	}
	
	//C:\class\server\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPTest\example\files
	
	
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
		<h1>결과</h1>
		
		<div>문자열: <%= txt %></div>
		<div>숫자: <%= num %></div>
		<div>첨부파일: <%= filename.size() %>개</div>
		<ul>
			<% for (int i=0; i<filename.size(); i++) { %>
			<li><a href="download.jsp?filename=<%= filename.get(i) %>&orgfilename=<%= orgfilename.get(i) %>"><%= orgfilename.get(i) %></a></li>
			<% } %>
		</ul>
	</div>
	
	<script>
	
	</script>

</body>
</html>