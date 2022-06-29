<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Toy Project</title>
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<style>

</style>
</head>
<body>

	<main>
		<%@ include file="/WEB-INF/views/inc/header.jsp" %>
		<section>
			
			<h2>Board</h2>
			
			<form method="POST" action="/toy/board/editok.do">
			
			<table class="table table-bordered vertical">
				<tr>
					<th>제목</th>
					<td><input type="text" name="subject" class="form-control" required
						value="${dto.subject}"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" class="form-control" required>${dto.content}</textarea></td>
				</tr>
			</table>
			
			<div class="btns">
				<input type="button" value="돌아가기" class="btn btn-secondary"
					onclick="location.href='/toy/board/view.do?seq=${dto.seq}';">
				<button class="btn btn-primary">
					<i class="fas fa-pen"></i>
					수정하기
				</button>
			</div>
			
			<!-- view로 돌아가려면 에러뜸 > 왜냐, view는 seq를 받아야 들어갈 수 있는 애라서. (이런경우가 많음)
				 그래서 dto.seq도 같이 넘겨줘야함 -->
			
			<!-- 수정하기로 넘어갈때 수정할 글 번호도 넘어가야함. -->
			<input type="hidden" name="seq" value="${dto.seq}">
			
			<!-- 히든태그는 항상 소스보기로 잘 넘어갔는지 확인하기 -->
			
			</form>
			
			
		</section>
	</main>
	
	<script>
		
	</script>

</body>
</html>


















