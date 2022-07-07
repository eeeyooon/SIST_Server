<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Toy Project</title>
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<script src="/toy/asset/js/jquery-ui.js"></script>
<style>

</style>
</head>
<body>
	
	<main>
		<%@ include file="/WEB-INF/views/inc/header.jsp" %>
		<section>
		
			<h2>jQuery + Ajax</h2>
			
			<img src="/toy/asset/images/catty01.png" id="cat01" class="drag">
			<img src="/toy/asset/images/catty02.png" id="cat02" class="drag">
			<img src="/toy/asset/images/catty03.png" id="cat03" class="drag">
			
			
		</section>
	
	</main>

	<script>
		
	$('.drag').draggable({
		
		stop : function(event, ui) {
			//알아내야 하는 정보
			//1. 클릭한 고양이가 누구냐?
			//2. 드래그한 다음에 놓았을 때의 좌표
					
			let id = this.id;
			let x = ui.position.left;
			let y = ui.position.top;
			
			//alert(id + ',' + x + ',' + y);
			
			$.ajax({
				
				type: 'POST',
				url: '/toy/ajax/ex08data.do',
				data: 'id=' + id + '&x=' + x + '&y=' + y,
				dataType: 'json',
				success: function(result) {
					
					if (result.result == "1") {
						//null
					} else {
						alert('failed');
					}
					
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
				
			});
			
			
		}
		
	});
	
	
	
	//고양이를 찾아서 넘어온 좌표에 옮기기
	//고양이 3마리를 모두 arraylist에 넣었으니까 루프 돌려서 꺼내기
	
	
	<c:forEach items="${list}" var="dto">
	$('#${dto.id}').css({
		left: '${dto.left}px',
		top: '${dto.top}px'
	});
	</c:forEach>
	

		
	
	
	</script>

</body>
</html>









