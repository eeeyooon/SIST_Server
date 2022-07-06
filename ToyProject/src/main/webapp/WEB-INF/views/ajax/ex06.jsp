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
	
	.table th, .table td {
		text-align: center;
	}
	
	.table th:nth-child(1) { width: 80px; }
	.table th:nth-child(2) { width: 150px; }
	.table th:nth-child(3) { width: 150px; }
	.table th:nth-child(4) { width: auto; }
	.table th:nth-child(5) { width: 150px; }

</style>
</head>
<body>
	
	<main>
		<%@ include file="/WEB-INF/views/inc/header.jsp" %>
		<section>
		
			<h2>직원</h2>
			
			
			<div class="well well-sm">
				<c:forEach items="${blist}" var="buseo">
				<input type="button" value="${buseo}" class="btn btn-primary btnBuseo">
				</c:forEach>
			</div>
			
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>번호</th>
						<th>이름</th>
						<th>직위</th>
						<th>연락처</th>
						<th>거주지</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						
					</tr>
					<tr>
						<td colspan="5">직원이 없습니다.</td>
					</tr>
				</tbody>
			</table>
			
		</section>
	
	</main>

	<script>
	
		$('.btnBuseo').click(function() {
			
			//선택 버튼 처리하기
			$('.btnBuseo').removeClass('btn-success');
			$(this).addClass('btn-success');
			this.blur();
			//포커스가 잡혀서 버튼에 검정 테두리가 생김(다른곳을 클릭해야 사라짐) > 이게 거슬리니까 강제로 사라지게 하는 메소드
			
			
			//ajax > 명단 가져오기
			let buseo = $(this).val();
			
			//alert(buseo);
			
			$.ajax({
				
				type: 'GET',
				url: '/toy/ajax/ex06data.do',
				data: 'buseo=' + buseo,
				dataType: 'json',
				success: function(result) {
					
					//result > 해당 부서 직원 목록
					
					/*
						
						[
							{
								"num": "100l",
								"name": "홍길동",
								"jikwi": "부장",
								"tel": "011-2356-4528",
								"city": "제주"
							},
						]
					
					*/
					
					//[{"num": 1001,"name": "홍길동","jikwi": "부장","tel": "011-2356-4528","city": "제주"},{"num": 1022,"name": "이영숙","jikwi": "대리","tel": "017-5214-5282","city": "전남"},{"num": 1024,"name": "김말자","jikwi": "대리","tel": "011-5248-7789","city": "서울"}
					
					
					
					let temp = '';
					
					$(result).each(function(index, item) {
						
						//직원 1명 > JSON 객체 1개					
						temp += '<tr>';
						temp += '<td>' + item.num + '</td>';
						temp += '<td>' + item.name + '</td>';
						temp += '<td>' + item.jikwi + '</td>';
						temp += '<td>' + item.tel + '</td>';
						temp += '<td>' + item.city + '</td>';
						temp += '</tr>';
						
					
					});
					
					
					$('table tbody').html(''); // 기존 행 삭제
					$('table tbody').append(temp); //직원 행 추가
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
				
			});
			
		});
	
	</script>

</body>
</html>









