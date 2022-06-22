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
	<!-- ex18_file_form.jsp -->
	<div class="container">
		
		<h1>파일 업로드</h1>
		
		<!-- 
		
			파일 업로드
			1. <form method="POST"> -> 꼭 POST 방식으로 보내기
			2. <form enctype="">
				a. application/x-www-form-urlencoded > "문자열을 전송하겠습니다"라는 뜻 (기본값임)
				b. multipart/form-data > 문자열 + 비문자열 동시 전송 = 텍스트 박스의 값과 첨부파일도 함께 전송하겠다 >> 필수로 넣어야함.		
		 
		 -->
		
		<!-- 첨부파일은 무조건 POST방식 GET은 xX -->
		<form method="POST" action="ex18_file_ok.jsp"
				enctype="multipart/form-data">
				
		
			<table class="table">
				<tr>
					<th>문자열</th>
					<td><input type="text" name="txt"></td>
				</tr>
				<tr>
					<th>숫자</th>
					<td><input type="number" name="num"></td>
				</tr>
				<tr>
					<th>파일</th>
					<td><input type="file" name="attach"></td>
				</tr>
			</table>
			
			<div>
				<input type="submit" value="등록하기"
					class="btn btn-primary">
			</div>
		
		</form>
		
	</div>
	
	<script>
	
	</script>

</body>
</html>