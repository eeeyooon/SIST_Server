<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
	

	//<form enctype="multipart/form-data">를 사용하면 인코딩 방식이 바뀌면서
	//- request.getParameter() > 동작 불능
	//- request.getParameterValues() > 동작 불능
	//	>> 이 둘만 동작을 안함.
	//- cos.jar > MultipartRequest를 대신 사용함. > 인코딩이 바뀌어도 어떻게 해야할지 처리가 이미 되어있음. (****)
	
	//MultipartRequest
	//1. request > Wrapping Class > request 역할을 그대로 구현
	//2. 파일 업로드 처리 구현
	
	//업로드될 파일들이 위치할 폴더의 (로컬)경로: webapp > example > files
	
	//String path = "C:\\class\\server\\JSPTest\\src\\main\\webapp\\example\\files";
	//소스폴더
	
	
	String path = application.getRealPath("/example/files");
	//local 경로로 바꿔주는 메소드
	
	System.out.println(path);
	//C:\class\server\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPTest\example\files
	
	// >> 아파치 톰캣이 실제 서버를 운영하기 위해서 원본 소스를 복사해놓은 실제 운영 디렉토리(***)
	// 운영 폴더는 스스로 변화를 주고 

	//업로드 파일의 최대 크기 지정(제한을 둬야함)
	//- 바이트 단위
	int size = 1024 * 1024 * 100; // 100MB
	
	
	//변수선언
	String txt = "";			//문자열
	String num = "";			//숫자
	String filename = "";		//첨부파일명
	String orgfilename = "";	//첨부파일명
	
	
	try {
		
		//request > MultipartRequest
		//com.oreilly.servlet.MultipartRequest
		
		//MultipartRequest 객체를 만드는 순간 이미 첨부파일은 files 폴더에 업로드가 완료되어 있음.
		MultipartRequest multi = new MultipartRequest(
									request, //원래의 request 객체
									path,    //업로드 위치
									size, 	 //최대 크기
									"UTF-8", //인코딩 지정
									new DefaultFileRenamePolicy() //파일명 관리 객체(파일 중복을 피해줌-> 뒤에 인덱스 붙임)
								);
		
		//전송 데이터 가져오기
		//txt = request.getParamter("txt"); > 동작 안함
		
		txt = multi.getParameter("txt");
		num = multi.getParameter("num");
		
		//파일 정보 가져오기
		filename    = multi.getFilesystemName("attach"); 	//하드 디스크에 저장된 진짜 이름
		orgfilename = multi.getOriginalFileName("attach");  //사용자가 올린 원본 이름
		
	} catch(Exception e) {
		System.out.println(e);
	}
	
	
	

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
	
	<!-- ex18_file_ok.jsp -->
	<div class="container">
		<h1>결과</h1>
		
		<div class="well">
			<strong>문자열</strong>
			<%= txt %>
		</div>
		
		<div class="well">
			<strong>숫자</strong>
			<%= num %>
		</div>
		<div class="well">
			<strong>파일</strong>
			<%= filename %>, <%= orgfilename %>
		</div>
		
		<h2>파일 다운로드 </h2>
		
		<!--  <div><a href="/jsp/example/files/<%= filename %>"><%= filename %></a></div>
			브라우저는 자신이 해석할 수 있는건 그냥 파일 열어버림 -> txt나 이미지. / zip파일은 못열어서 그대로 넘겨서 다운로드하게함
        -->
		
		<div><a href="/jsp/example/files/<%= filename %>" download><%= filename %></a></div>
		
		<!--
		 해결방법(어떤 파일이든 열지말고 다운받을 수 있게) > download 붙이기 >> 니가 해석할 수 있는 파일이라도 무조건 다운로드해라
		 단, 일반 링크에는 붙이면 안됨!! 첨부파일 다운로드할때만 쓰는 속성임
		-->
		
		<div><a href="download.jsp?filename=<%= filename %>&orgfilename=<%= orgfilename%>"><%= orgfilename %></a></div>
		<!-- 
			파일이 뭐든 무조건 다운로드하게하고, 중복파일이 있든 없든 무조건 원본 이름 그대로 저장할 수 있도록 설정한 jsp파일임.
		 -->
		
	</div>
	
	<script>
	
	</script>

</body>
</html>