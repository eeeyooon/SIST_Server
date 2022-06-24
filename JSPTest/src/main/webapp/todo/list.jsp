<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Todo</title>
<%@ include file="/todo/inc/asset.jsp" %>
<style>

</style>
</head>
<body>

	<main>
		<h1>Todo <small>List</small></h1>
		
		<table class="table table-bordered list">
			<tr>
				<th>★</th>
				<th>할일</th>
				<th>날짜</th>
			</tr>
			<tr>
				<td>A</td>
				<td>수업 복습하기</td>
				<td>2022-06-24 12:12:20</td>
			</tr>
			<tr class="complete">
				<td>C</td>
				<td>마트 장보기</td>
				<td>2022-06-24 12:12:20</td>
			</tr>
			<tr>
				<td>C</td>
				<td>방청소하기</td>
				<td>2022-06-24 12:12:20</td>
			</tr>
		</table>
		
		<div class="btns">
			<input type="button" value="등록하기"
				class="btn btn-warning" onclick="location.href='add.jsp';">
		</div>
	</main>
	
	<script>
		
	</script>

</body>
</html>
















