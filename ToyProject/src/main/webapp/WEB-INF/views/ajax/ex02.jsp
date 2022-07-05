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
			
			
			<h4>기존 방식</h4>
			<div>
			<input type="text" id="txt1" value="${cnt}">
			<input type="button" value="확인" id="btn1"
				onclick="location.href='/toy/ajax/ex02data.do';">
			</div>
			<div>
				<input type="text">
			</div>
			
			<h4>Ajax 방식</h4>
			<div>
			<input type="text" id="txt2">
			<input type="button" value="확인" id="btn2"
				onclick="test();">
			</div>
			<div>
				<input type="text">
			</div>
			
			<h4>Ajax 방식</h4>
			<input type="button" value="확인" id="btn3"
				onclick="test2();">
			<span id="txt3"></span>
			
		</section>
	
	</main>

	<script>
	
		let ajax;
		
		function test() {
			
			//Ajax 통신을 지원하는 자바스크립트 객체
			ajax = new XMLHttpRequest();
			
			//alert(ajax);
			if (ajax != null) {
				
				//서버에게 데이터 요청
				ajax.onreadystatechange = m1;
				ajax.open('GET', '/toy/ajax/ex02data2.do'); //<form method action>
				ajax.send(); //<input type="submit">
				
			} else {
				alert('접속한 브라우저가 XMLHttpRequest를 지원하지 않습니다.');
			}
			
		}
		
		
		function m1() {
			
			if (ajax.readyState == 4 && ajax.status == 200) {
	
				//서버에게 요청한 뒤 돌려받은 데이터 > 오직 문자열로 인식함. 페이지 소스로 받아옴?)
				//<ajax는 태그들이나 코드들도 모두 데이터로 인식해서 출력해버리니까 필요한 데이터만 남겨놓으면 됨.
				//(ex02data2.jsp에 ${cnt}만 남김)
				$('#txt2').val(ajax.responseText);
				//text박스에 확인 누르면 자동으로 데이터(cnt)가 입력됨.
				
			}
			
		}
		
		
		function test2() {
			
			//Ajax 통신을 지원하는 자바스크립트 객체
			ajax = new XMLHttpRequest();
			
			//alert(ajax);
			if (ajax != null) {
				
				//서버에게 데이터 요청
				ajax.onreadystatechange = m2;
				
				//이 네개의 데이터를 주로 호출함.
				ajax.open('GET', '/toy/data.txt'); //<form method action>
				//ajax.open('GET', '/toy/data.xml');
				//ajax.open('GET', '/toy/data.json');
				//ajax.open('GET', '/toy/data.do');
				
				
				ajax.send(); //<input type="submit">
				
			} else {
				alert('접속한 브라우저가 XMLHttpRequest를 지원하지 않습니다.');
			}
			
		}
		
		
		//m2-> callback함수 (사건이 터져야 호출되는 함수)
		function m2() {
			
			
			console.log('ajax.readyState', ajax.readyState);
			console.log('ajax.status', ajax.status);
			
			
			if (ajax.readyState == 4 & ajax.status == 200) {
				
				console.log(ajax.responseText);
				//readystate값이 변하는 것도 함께 뜸.(1~4 > 진행이 되는 과정)
				
				//ajax.responseText
				//ajax.responseXML
				
				
				$('#txt3').text(ajax.responseText);
				
				
			}
			
			console.log('');
			
		}
	
	
	</script>

</body>
</html>









