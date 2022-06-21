<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery-1.12.4.js"></script>
<script src="js/jquery-ui.js"></script>
</head>
<body>
	<!-- ex10_form.jsp  06/21  -->
	
	<h1>컨트롤 입력 + 전송</h1>
	
	<form method="POST" action="ex10_ok.jsp">
	
	<table border width="600">
		<tr>
			<th width="100">텍스트 박스</th>
			<td width="500"><input type="text" name="txt1"></td>
		</tr>
		<tr>
			<th>암호 박스</th>
			<td><input type="password" name="txt2"></td>
		</tr>
		<tr>
			<th>다중 텍스트</th>
			<td><textarea name="txt3" cols="50" rows="5"></textarea></td>
		</tr>
		<tr>
			<th>체크 박스</th>
			<td>
				<input type="checkbox" name="cb1" value="dog">
				<input type="checkbox" name="cb2">
			</td>
		</tr>
		<tr>
			<th>체크 박스들</th>
			<td>
				<h4>취미를 선택하세요.</h4>
				<label><input type="checkbox" name="cb3" value="독서">독서</label>
				<label><input type="checkbox" name="cb4" value="운동">운동</label>
				<label><input type="checkbox" name="cb5" value="코딩">코딩</label>
			</td>
		</tr>
		<tr>
			<th>체크 박스들2</th>
			<td>
				<h4>취미를 선택하세요.</h4>
				<label><input type="checkbox" name="cb6" value="독서">독서</label>
				<label><input type="checkbox" name="cb7" value="운동">운동</label>
				<label><input type="checkbox" name="cb8" value="코딩">코딩</label>
			</td>
		</tr>
		<tr>
			<th>체크 박스들3</th>
			<td>
				<h4>취미를 선택하세요.</h4>
				<label><input type="checkbox" name="cb9" value="독서">독서</label>
				<label><input type="checkbox" name="cb9" value="운동">운동</label>
				<label><input type="checkbox" name="cb9" value="코딩">코딩</label>
			</td>
		</tr>
		<tr>
			<th>라디오 버튼</th>
			<td>
				<h4>성별을 선택하시오.</h4>
				<label><input type="radio" name ="rb" value="male">남자</label>
				<label><input type="radio" name ="rb" value="female">여자</label>
			</td>
		</tr>
		<tr>
			<th>셀렉트 박스</th>
			<td>
				<select name="sel1">
				<option value="1">사과</option>
				<option value="2">오렌지</option>
				<option value="3">바나나</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>셀렉트 박스2</th>
			<td>
				<select name="sel2" multiple>
				<option value="1">사과</option>
				<option value="2">오렌지</option>
				<option value="3">바나나</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>히든 태그</th>
			<td><input type="hidden" name="id" value="hong"></td>
		</tr>
		<tr>
			<th>그 외 나머지 모든 컨트롤</th>
			<td><input type="color" name="color"></td>
		</tr>
		<tr>
			<th>사용자 정의 컨트롤(JavaScript, jQuery 등..)</th>
			<td>
				<h1 id="title">드래그</h1>
			</td>
		</tr>
	</table>
	
	<br>
	
	<input type="submit" value="보내기">
	
	
	<!-- 보통 맨 밑에 히든 태그를 생성  -->
	
	<input type="hidden" name="left" id="left">
	<input type="hidden" name="top" id="top">
	<!-- 현재 value X > 밑에 좌표값을 value로 넘길예정  -->
	
	</form>
	
	
	<script>
		//제목의 드래그된 위치를 서버에 전송!!
		$('#title').draggable({
			stop: function(event, ui) {
				/* alert(ui.position.left);
				alert(ui.position.top); */
				// -> 이 값은 서버로 전송을 못함. 이때 히든 태그를 사용 히든태그로 좌표값 넘기기
				
				$('#left').val(ui.position.left);
				$('#top').val(ui.position.top);
			}
		});	
	
	</script>
	
	
	
	

</body>
</html>








