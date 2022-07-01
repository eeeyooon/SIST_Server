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
			
			<h2>Board</h2>
			
			<form method="POST" action="/toy/board/editok.do" enctype="multipart/form-data">
			
			<table class="table table-bordered vertical">
				<tr>
					<th>제목</th>
					<td><input type="text" name="subject" class="form-control" required
						value="${dto.subject}"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" class="form-control" required>${dto.content}</textarea></td>
				</tr>
				<tr>
					<th>파일</th>
					<td>
						<input type="file" name="attach" class="form-control">
						
						<div style="margin: 7px 12px 3px 7px;">
						<c:if test="${not empty dto.orgfilename}">
						파일명: <span id="filename">${dto.orgfilename}</span><span onclick="delfile();" style="cursor: pointer;">&times;</span> 
						</c:if>
						
						<c:if test="${empty dto.orgfilename}">
						파일명: 파일 없음
						</c:if>
						</div>
						
					</td>
				</tr>
				
			</table>
			
			<!-- 
					location.href > 서버에 항상 페이지를 요청
					history.back() > 서버와 통신없이 클라이언트가 이전에 보고 있는 페이지를 그대로 복구해서 이동
					
					1. location.href
					<input type="button" value="돌아가기" class="btn btn-secondary"
					onclick="location.href='/toy/board/view.do?seq=${dto.seq}';"> 
					
					2. history.back()
					<input type="button" value="돌아가기" class="btn btn-secondary"
					onclick="history.back();"> 
					
					-> 이런 상황에서는 수정하기를 들어갔다가 돌아온다고 뷰가 달라질 가능성이 낮아서 history.back()써도 됨.
						매개 변수 연습하라고 href쓴 것
					
					-->
			
		
			<div class="btns">
				<input type="button" value="돌아가기" class="btn btn-secondary"
					onclick="history.back();">
				<button class="btn btn-primary">
					<i class="fas fa-pen"></i>
					수정하기
				</button>
			</div>
			
			<!-- view로 돌아가려면 에러뜸 > 왜냐, view는 seq를 받아야 들어갈 수 있는 애라서. (이런경우가 많음)
				 그래서 dto.seq도 같이 넘겨줘야함 -->
			
			<!-- 수정하기로 넘어갈때 수정할 글 번호도 넘어가야함. -->
			<input type="hidden" name="seq" value="${dto.seq}">
			
			
			<!-- 07/01 Edit.java > 이거 추가하고 editok.java -->
			<input type="hidden" name="isSearch" value="${isSearch}">
			<input type="hidden" name="column" value="${column}">
			<input type="hidden" name="word" value="${word}">
			
			<!-- 히든태그는 항상 소스보기로 잘 넘어갔는지 확인하기 -->
			
			<!-- 업로드한 파일 삭제하기 -->
			<input type="hidden" name="delfile" value="n">
			
			</form>
			
			
		</section>
	</main>
	
	<script>
		
		/* x 아이콘을 누르면 파일 이름에 취소선 그어짐. > 삭제 표시
		한번 더 누르면 취소선 사라짐.*/
		function delfile() {
			if($('#filename').css('text-decoration').indexOf('line-through') == -1) {
				//line-through가 발견되지 않으면
				$('#filename').css('text-decoration', 'line-through');
				$('input[name=delfile]').val('y');
					
					
				
			} else {
				//한번 더 클릭하면 취소선 없애기
				$('#filename').css('text-decoration', 'none');
				$('input[name=delfile]').val('n');
			}
		}
	
	</script>

</body>
</html>


















