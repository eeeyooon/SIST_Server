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
	fieldset {
		margin: 30px 0;
	}
	
	fieldset input {
		margin: 5px;
	}
	
	#msg1, #msg2, #msg3 {
		margin: 15px;
	}
</style>
</head>
<body>

	<main>
		<%@ include file="/WEB-INF/views/inc/header.jsp" %>
		<section>
			
			<h2>데이터 포맷</h2>
			
			<fieldset>
				<legend>Text</legend>
				<input type="text" name="txt1" id="txt1" class="form-control">
				<input type="button" value="확인" id="btn1" class="btn btn-primary">
				<div id="msg1"></div>
			</fieldset>
			
			<fieldset>
				<legend>XML</legend>
				<input type="text" name="txt2" id="txt2" class="form-control">
				<input type="button" value="확인" id="btn2" class="btn btn-primary">
				<div id="msg2"></div>
			</fieldset>
			
			<fieldset>
				<legend>JSON</legend>
				<input type="text" name="txt3" id="txt3" class="form-control">
				<input type="button" value="확인" id="btn3" class="btn btn-primary">
				<div id="msg3"></div>
			</fieldset>
			
			
			
			<fieldset>
				<legend>Text + XML + JSON</legend>
				<input type="text" name="txt4" id="txt4" class="form-control">
				<input type="button" value="확인" id="btn4" class="btn btn-primary">
				<div id="msg4"></div>
			</fieldset>
			
			
			<fieldset>
				<legend>Text + XML + JSON</legend>
				
				<form id="form">
					<input type="text" name="subject" id="subject" class="form-control" placeholder="제목">
					<input type="text" name="content" id="content" class="form-control" placeholder="내용">
					<input type="text" name="id" id="id" class="form-control" value="hong">
				</form>
				
				<input type="button" value="쓰기" id="btn5" class="btn btn-primary">
				<div id="msg5"></div>
			</fieldset>
			
			<!--  
				"insert into tblBoard (seq, subject, content, id, regdate, readcount, thread, depth, filename, orgfilename) values (seqBoard.nextVal, ?, ?, ?, default, default, ?, ?, ?, ?)"
			-->
		</section>
	</main>
	
	<script>
	
		/*
		
			$.ajax({
				type: 'GET',	//요청 메소드 방식
				url: 'URL',		//응답 주소
				data: '',		//전송 데이터(줄때)
				dataType: '',	//응답 데이터 타입(받을때) > 'text', 'json', 'xml'
				success: fn,	//응답 콜백 함수(받을때)
				error: fn		//에러 처리 함수
			});		
		
		*/
		
		//서버 > (데이터:Text) > 클라이언트
		$('#btn1').click(function() {
			
			$.ajax({
				type: 'GET',
				url: '/toy/ajax/ex05text.do',
				dataType: 'text',
				success: function(result) {
					
					//이름
					//$('#msg1').text(result);
					
					//다중 데이터
					//게시판 제목입니다.,게시판 내용입니다.,홍길동,2022-07-06 09:27:48
					//let temp = result.split(',');
					
					//$('#msg1').append('<ul>');
					//$('#msg1').append('<li>' + temp[0] + '</li>');
					//$('#msg1').append('<li>' + temp[1] + '</li>');
					//$('#msg1').append('<li>' + temp[2] + '</li>');
					//$('#msg1').append('<li>' + temp[3] + '</li>');
					//$('#msg1').append('</ul>');
					
					
					//다중 데이터
					//게시판 제목입니다.,홍길동,2022-07-06 09:27:48
					//test,홍길동,2022-07-04 17:51:54
					//점심먹고 한바퀴 도는 중~,홍길동,2022-07-04 17:51:16
					
					let temp = result.split('\r\n');
					
					temp.forEach(function(item, index) {
						
						let temp2 = item.split(',');
						
						$('#msg1').append('<ul>');
						$('#msg1').append('<li>' + temp2[0] + '</li>');
						$('#msg1').append('<li>' + temp2[1] + '</li>');
						$('#msg1').append('<li>' + temp2[2] + '</li>');
						$('#msg1').append('</ul>');
						$('#msg1').append('<br>');
						
					});
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
			
		});
		
		
		
		//서버 > (데이터:XML) > 클라이언트
		$('#btn2').click(function() {
			
			$.ajax({
				type: 'GET',
				url: '/toy/ajax/ex05xml.do',
				dataType: 'xml',
				success: function(result) {
					
					//       > DOM document 객체
					//result > XML 문서 객체
					
					//<name>홍길동</name>
					//alert(result);
					
					//단일데이터
					//$('#msg2').text($(result).find("name").text());
					
					
					//다중 데이터
					//<item>
					//	<subject>게시판 제목입니다.</subject>
					//	<content>게시판 내용입니다.</content>
					//	<name>홍길동</name>
					//	<regdate>2022-07-06 09:27:48</regdate>
					//</item>
					
					
					//let subject = $(result).find('subject').text();
					//let content = $(result).find('content').text();
					//let name = $(result).find('name').text();
					//let regdate = $(result).find('regdate').text();
					
					//$('#msg2').append('<ul>');
					//$('#msg2').append('<li>' + subject + '</li>');
					//$('#msg2').append('<li>' + content + '</li>');
					//$('#msg2').append('<li>' + name + '</li>');
					//$('#msg2').append('<li>' + regdate + '</li>');
					//$('#msg2').append('</ul>');
					//$('#msg2').append('<br>');
					
					
					$(result).find('item').each(function(index, item) {
						
						//1회전 > item > <item> 태그
						let subject = $(item).find('subject').text();
						let name 	= $(item).find('name').text();
						let regdate = $(item).find('regdate').text();
						
						$('#msg2').append('<ul>');
						$('#msg2').append('<li>' + subject + '</li>');
						$('#msg2').append('<li>' + name + '</li>');
						$('#msg2').append('<li>' + regdate + '</li>');
						$('#msg2').append('</ul>');
						$('#msg2').append('<br>');
												
					});
					
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
			
		});
		
		
		
		//서버 > (데이터:JSON) > 클라이언트
		$('#btn3').click(function() {
			
			$.ajax({
				type: 'GET',
				url: '/toy/ajax/ex05json.do',
				dataType: 'json',
				success: function(result) {
					
					//단일 데이터
					//result = {"name": "홍길동"}
					
					//alert(result.name);
					//alert(result["name"]);
					
					//$('#msg3').text(result.name);
					
					
					//다중 데이터
					//{
					//	"subject": "게시판 제목입니다.",
					//	"content": "게시판 내용입니다.",
					//	"name": "홍길동",
					//	"regdate": "2022-07-06 09:27:48"
					//}
					
					//alert(result.subject);
					//alert(result.content);
					
					
					//$('#msg3').append('<ul>');
					//$('#msg3').append('<li>' + result.subject + '</li>');
					//$('#msg3').append('<li>' + result.content + '</li>');
					//$('#msg3').append('<li>' + result.name + '</li>');
					//$('#msg3').append('<li>' + result.regdate + '</li>');
					//$('#msg3').append('</ul>');
					//$('#msg3').append('<br>');
					
					
					$(result).each(function(index, item) {
						$('#msg3').append('<ul>');
						$('#msg3').append('<li>' + item.subject + '</li>');
						$('#msg3').append('<li>' + item.name + '</li>');
						$('#msg3').append('<li>' + item.regdate + '</li>');
						$('#msg3').append('</ul>');
						$('#msg3').append('<br>');
					});
					
					
					
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
			
		});
		
		
		
		
		//클라이언트 > (데이터) > 서버
		$('#btn4').click(function() {
			
			$.ajax({
				type: 'GET',
				url: '/toy/ajax/ex05data.do',
				data: 'txt4=' + $('#txt4').val(),
				dataType: 'json',
				success: function(result) {
					
					$('#msg4').append('<div>status: ' + result.status + '</div>');
					$('#msg4').append('<div>value: ' + result.value + '</div>');
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
				
			});
			
		});
		
		
		
		
		$('#btn5').click(function() {
			
			//alert('subject=' + $('#subject').val() + '&content=' + $('#content').val() + '&id=' + $('#id').val());
			
			//alert($('#form').serialize()); //직렬화 > 여러 형태의 데이터 구조를 한줄의 데이터 형태로 바꾸는 작업
						
			
			$.ajax({
				type: 'POST',
				url: '/toy/ajax/ex05board.do',
				//data: 'subject=' + $('#subject').val() + '&content=' + $('#content').val() + '&id=' + $('#id').val(),
				data: $('#form').serialize(),
				dataType: 'json',
				success: function(result) {
					
					$('#msg5').text(result.result == '1' ? '성공' : '실패');
					
				},
				error: function(a,b,c) {
					console.log(a,b,c);
				}
			});
			
		});
		
		
		
		
	
	</script>

</body>
</html>


















