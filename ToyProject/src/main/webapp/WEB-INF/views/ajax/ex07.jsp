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

   .table th, .table td { text-align: center; }
   .table td:nth-child(5) { text-align: left; }
   .table th:nth-child(1) { width: 120px; }
   .table th:nth-child(2) { width: 80px; }
   .table th:nth-child(3) { width: 80px; }
   .table th:nth-child(4) { width: 160px; }
   .table th:nth-child(5) { width: auto; }
   .table th:nth-child(6) { width: 80px; }
   
   form input, form select { margin: 10px 0; }
   form input[type=text] { width: 120px; }
   form input[type=text]:nth-child(4) { width: 200px; }
   form input[type=text]:nth-child(5) { width: 400px; }
   form select.form-control { width: 120px; }
	

</style>
</head>
<body>
	
	<main>
		<%@ include file="/WEB-INF/views/inc/header.jsp" %>
		<section>
			
			<h2>
				주소록
				<small>
					<input type="button" value="남자" class="btn btn-primary">
					<input type="button" value="여자" class="btn btn-success">
					<input type="button" value="모두" class="btn btn-info">
				</small>
			</h2>
			
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>이름</th>
						<th>나이</th>
						<th>성별</th>
						<th>전화</th>
						<th>주소</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><input type="button" value="삭제" class="btn btn-danger"></td>
					</tr>
				</tbody>			
			</table>
			
			<hr>
			
			<form action="">
			<div>
				<input type="text" name="" id="" class="form-control" placeholder="이름">
				<input type="text" name="" id="" class="form-control" placeholder="나이">
				<select name="" id="" class="form-control">
					<option value="">남자</option>
					<option value="">여자</option>
				</select>
				<input type="text" name="" id="" class="form-control" placeholder="전화">
				<input type="text" name="" id="" class="form-control" placeholder="주소">			
			</div>
			<div class="btns">
				<input type="button" value="등록하기" class="btn btn-primary">
			</div>
			</form>
			
			
		</section>
	
	</main>

	<script>
	
	</script>

</body>
</html>









