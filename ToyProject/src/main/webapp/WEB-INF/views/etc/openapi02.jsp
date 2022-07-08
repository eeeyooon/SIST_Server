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

	form {
		display: flex;
	}
	
	form input[name=query] {
		width: 300px;
		margin-right: 5px; 
	}
	
	
	.table th, .table td { text-align: center; }
	

</style>
</head>
<body>
	
	<main>
		<%@ include file="/WEB-INF/views/inc/header.jsp" %>
		<section>
			<h2>Naver Books</h2>
			
			<div class="well well-sm">
				<form>
					<input type="text" name="query" class="form-control" placeholder="검색어를 입력하세요." required>
					<input type="submit" value="검색하기" class="btn btn-primary">
				</form>
			</div>
			
			<hr>
			
			<table class="table table-bordered">
				<tr>
					<th>표지</th>
					<th>제목</th>
					<th>저자</th>
					<th>가격</th>
					<th>출판사</th>
					<th>출간일</th>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="6">검색 결과가 없습니다.</td>
				</tr>
			</table>				
				
		</section>
	
	</main>

	<script>
	
	</script>

</body>
</html>









