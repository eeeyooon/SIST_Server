<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//06.23

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/example/inc/asset.jsp" %>
<script src="/jsp/example/js/string.js"></script>
<style>
	td > div, div > div {
		margin-bottom: 10px;
	}
	
	div > div input, div > div span {
		float:left;
	}
	
	div > div span {
		cursor: pointer;
		font-size: 1.1em;
		/* font-size > 'X' 크기 조절 */
	}
	
	div > div::after {
		content: '';
		display: block;
		clear: both;
	}
	
	
</style>
</head>
<body>

	<div class="container">
	
		<h1>다중 파일 업로드</h1>
	
		<form method="POST" action="ex19_file_ok.jsp"
					enctype="multipart/form-data">
					
			
				<table class="table">
					<tr>
						<th>문자열</th>
						<td><input type="text" name="txt" value="홍길동"></td>
					</tr>
					<tr>
						<th>숫자</th>
						<td><input type="number" name="num" value="100"></td>
					</tr>
					<tr>
						<th>파일</th>
						<td>
							<div><input type="file" name="attach1"></div>
							<div id="filelist"></div>
							<hr>
							<input type="button" value="첨부 파일 추가하기" class="btn btn-secondary" id="btnfile">
						</td>
					</tr>
				</table>
				
				<div>
					<input type="submit" value="등록하기"
						class="btn btn-primary">
				</div>
			
			</form>
	
	
	</div>
	
	<script>
		
		let no = 2;
		
		$('#btnfile').click(function(){
			
			//let temp = '<div><input type="file" name="attach' + no + '"></div>';
			
			let temp = String.format('<div><input type="file" name="attach{0}"><span onclick="del();">&times;</span></div>', no);
			//String.js를 가져와서 이 방법 사용
			//&times > 곱하기(X) 기호
			
			$('#filelist').append(temp);
			
			no++;
			
		});
		
		//정적으로 이벤트를 걸면 this가 안먹음. (this가 윈도우를 반환함)
		function del() {
			//alert(this);
			//alert(event.target);
			//target은 거의 대부분 이벤트를 발생시킨 태그를 반환해줌
			
			$(event.target).parent().remove();
			
		}
	
	</script>

</body>
</html>




