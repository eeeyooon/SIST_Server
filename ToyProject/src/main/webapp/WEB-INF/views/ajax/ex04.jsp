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
			<h2>Ajax</h2>
			
			<h4>비동기 통신</h4>
			<input type="button" value="확인" class="btn btn-primary" id="btn1">
			<span id="msg1"></span>
						
			<h4>동기 통신</h4>
			<input type="button" value="확인" class="btn btn-primary" id="btn2">
			<span id="msg2"></span>
			
			<hr>
			
			<h4>통신 패턴 3가지</h4>
			
			<input type="button" value="1. 서버로부터 데이터 가져오기" class="btn btn-primary" id="bnt3">
			<input type="button" value="2. 서버에서 데이터 보내기" class="btn btn-primary" id="bnt4">
			<input type="button" value="3. 서버에게 데이터 보내기 + 서버로부터 데이터 가져오기" class="btn btn-primary" id="bnt5">
			
			<h4>jQuery Ajax</h4>
			
			<div id="msg3"></div>
			
			<input type="button" value="데이터 가져오기" class="btn btn-primary" id="btn6">
			
			
			
			
			
		</section>
	
	</main>

	<script>
		
		let ajax;
		
		$('#btn1').click(function() {
			
			ajax = new XMLHttpRequest();
			ajax.onreadystatechange = m1;
			ajax.open('GET', '/toy/ajax/ex04data.do', true); //true = 비동기 통신을 해라
			ajax.send();
			
		});
		
		function m1() {
			if (ajax.readyState == 4 && ajax.status == 200) {
				$('#msg1').text(ajax.responseText);
			}
		}
		
		$('#btn2').click(function() {
			
			ajax = new XMLHttpRequest();
			ajax.onreadystatechange = m2;
			ajax.open('GET', '/toy/ajax/ex04data.do', false); //false = 동기통신. 보통 안적으면 true임
			ajax.send();
				
		});

		function m2() {
			if (ajax.readyState == 4 && ajax.status == 200) {
				$('#msg2').text(ajax.responseText);
			}
		}
		
		
		//Thread, Socket 더 공부하기> 자바의 정석
		
		
		
		$('#btn3').click(function() {
			//데이터 가져오기
			
			ajax = new XMLHttpRequest();
			ajax.open('GET', '/toy/ajax/ex04data3.do');
			ajax.onreadystatechange = function () { //데이터 수신을 위해서(***)
				if (ajax.readyState == 4 && ajax.status == 200) {
					
				}
			};
			
			ajax.send();
			
		});
		
		$('#btn4').click(function() {
			//데이터 보내기(GET, POST)
			
			ajax = new XMLHttpRequest();
			ajax.open('POST', '/toy/ajax/ex04data4.do'); //데이터 전송(GET)
			ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoder");
			ajax.send('name=bbb'); //데이터 전송(POST)
			
		)};
	
		$('#btn5').click(function() {
			//데이터 보내고 가져오기
			
			ajax = new XMLHttpRequest();
			ajax.open('GET', '/toy/ajax/ex04data5.do?name=hong'); //데이터 보내고
			ajax.onreadystatechange = function() { //데이터 수신을 위해서 ***
				if (ajax.readyState == 4 && ajax.status == 200 {
					alert(ajax.responseText);
				});
			}
			
			ajax.send(); //데이터 전송(POST)
			
			
		)};
		
		
		$('#btn6').click(function(){
			
			//jQuery Ajax
			//api.jquery.com/category/ajax/
			
			//$(선택자).ajax();
			
			
		/* 	
				//get방식
				
				$.ajax({
				
				type: 'GET', //ajax.open('GET') - 요청 메소드 방식
				url: '/toy/ajax/ex04data3.do', //ajax.open('GET', 'URL') - 요청주소
				
				success: function(result) { //onreadystatechange > 응답할때만 씀
					
					//result == ajax.responseText
					alert(result);
				},
				error: function(a,b,c) { //에러가 발생하면 호출
					console.log(a,b,c);
				}
				
			}); */
			
				
				//post 방식
				$.ajax({
				
				type: 'POST', //ajax.open('GET') - 요청 메소드 방식
				url: '/toy/ajax/ex04data4.do', //ajax.open('GET', 'URL') - 요청주소
				
				//success는 응답할때만 사용. 여기선 사용 x (대신 보낼때 사용) -> 보낼땐 data로
				data: 'name1=hong&name2=lee'; //여기엔 무조건 QueryString 담아야함. > key=value형태로
				
				error: function(a,b,c) { //에러가 발생하면 호출
					console.log(a,b,c);
				}
				
			});
			
			
			//위 두개를 합치면 주고 받는 것. (data - 주고, success - 받는 것)
			
			
		});
		
		
		
		
		
	</script>

</body>
</html>




















