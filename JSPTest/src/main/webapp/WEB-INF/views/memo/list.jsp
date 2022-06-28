<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/memo/inc/asset.jsp" %>
<style>

</style>
</head>
<body>

	<!-- template.jsp > list.jsp -->
	<main>
		<%@ include file="/WEB-INF/views/memo/inc/header.jsp" %>
		<section>
			
			<c:forEach items="${list}" var="dto">
			<table class="table table-bordered item">
				<tr>
					<th>번호</th>
					<td>${dto.seq}</td>
					<th>이름</th>
					<td>${dto.name}</td>
					<th>날짜</th>
					<td>${dto.regdate}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="5">${dto.subject}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5">${dto.content}</td>
				</tr>
			</table>
			
			<div class="btns">
				<input type="button" value="수정하기" class="btn btn-primary"
					onclick="location.href='/jsp/memo/edit.do?seq=${dto.seq}';">
				<input type="button" value="삭제하기" class="btn btn-primary"
					onclick="location.href='/jsp/memo/del.do?seq=${dto.seq}';">
			</div>
			
			</c:forEach>
			
		</section>
	</main>
	
	<script>
		
	</script>

</body>
</html>

			<!-- 
			
			JSP는 건네준 값을 오직 출력만 함 !! 따로 가공 X (서블릿이 건네줄걸 적재적소에 출력하는 업무만 함.)
			
			 -->
			



