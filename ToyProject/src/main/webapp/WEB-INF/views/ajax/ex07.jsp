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
					<input type="button" value="남자" class="btn btn-primary" onclick="search('m');">
					<input type="button" value="여자" class="btn btn-danger" onclick="search('f');">
					<input type="button" value="모두" class="btn btn-info" onclick="search('a');">
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
					<c:forEach items="${list}" var="dto">
					<tr>
						<td>${dto.name}</td>
						<td>${dto.age}</td>
						<td>${dto.gender}</td>
						<td>${dto.tel}</td>
						<td>${dto.address}</td>
						<td><input type="button" value="삭제" class="btn btn-warning" onclick="del(${dto.seq});"></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<hr>
			
			<form id="addForm">
			<div>
				<input type="text" name="name" id="name" class="form-control" placeholder="이름">
				<input type="text" name="age" id="age" class="form-control" placeholder="나이">
				<select name="gender" id="gender" class="form-control">
					<option value="m">남자</option>
					<option value="f">여자</option>
				</select>
				<input type="text" name="tel" id="tel" class="form-control" placeholder="전화">
				<input type="text" name="address" id="address" class="form-control" placeholder="주소">
			</div>
			<div class="btns">
				<input type="button" value="등록하기" class="btn btn-primary" onclick="add();">
			</div>
			</form>
			
		</section>
	</main>
	
	<script>
	
		function add() {
			
			$.ajax({
				type: 'POST',
				url: '/toy/ajax/ex07add.do',
				data: $('#addForm').serialize(),
				dataType: 'json',
				success: function(result) {
					
					if (result.seq != "0") {
						
						let temp = '';
						
						temp += '<tr>';
						temp += '<td>' + $('#name').val() + '</td>';
						temp += '<td>' + $('#age').val() + '</td>';
						temp += '<td>' + $('#gender').val() + '</td>';
						temp += '<td>' + $('#tel').val() + '</td>';
						temp += '<td>' + $('#address').val() + '</td>';
						temp += '<td><input type="button" value="삭제" class="btn btn-warning" onclick="del(' + result.seq + ');"></td>';
						temp += '</tr>';
						
						$('table tbody').append(temp);
						
						$('#name').val('');
						$('#age').val('');
						$('#gender').val('m');
						$('#tel').val('');
						$('#address').val('');
						
					} else {
						alert('failed');
					}
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
				
			});
			
		}
		
		function del(seq) {
			
			let tr = $(event.target).parent().parent();
						
			$.ajax({
				type: 'GET',
				url: '/toy/ajax/ex07del.do',
				data: 'seq=' + seq,
				dataType: 'json',
				success: function(result) {
										
					if (result.result == '1') {
						
						tr.remove();
						
					} else {
						alert('failed');
					}
					
				}, 
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
			
		}
		
		
		function search(gender) {
			
			$.ajax({
				type: 'GET',
				url: '/toy/ajax/ex07search.do',
				data: 'gender=' + gender,
				dataType: 'json',
				success: function(result) {
					
					$('table tbody').html('');
					
					if (result.length > 0) {
					
						$(result).each(function(index, item) {
							
							let temp = '';
							
							temp += '<tr>';
							temp += '<td>' + item.name + '</td>';
							temp += '<td>' + item.age + '</td>';
							temp += '<td>' + item.gender + '</td>';
							temp += '<td>' + item.tel + '</td>';
							temp += '<td>' + item.address + '</td>';
							temp += '<td><input type="button" value="삭제" class="btn btn-warning" onclick="del(' + item.seq + ');"></td>';
							temp += '</tr>';
							
							$('table tbody').append(temp);
							
						});
					} else {
						$('table tbody').append('<tr><td colspan="6">데이터가 없습니다.</td></tr>');
					}
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
				
			});
			
		}
	
	</script>

</body>
</html>






















