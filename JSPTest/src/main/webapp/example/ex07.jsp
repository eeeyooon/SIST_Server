<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	//JDBC > select > 결과셋 > 화면 출력

	ArrayList<String> list = new ArrayList<String>();
	
	list.add("홍길동");
	list.add("아무개");
	list.add("하하하");
	list.add("호호호");
	list.add("후후후");
	
	
	ArrayList<String> color = new ArrayList<String>();
	color.add("tomato");
	color.add("gold");
	color.add("lightblue");
	color.add("salmon");
	color.add("yellowgreen");

%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	.item {
		border: 1px solid #AAA;
		border-radius: 5px;
		padding: 15px;
		width: 450px;
		margin-bottom: 10px;
	}

</style>
</head>
<body>
	<!-- 06/21 -->
	
	<h1>Member</h1>
	
	<% for(int i=0; i<list.size(); i++) { %>
	
	<div class="item" style="background-color: <%= color.get(i) %>">
		<h2><%=list.get(i)%></h2>
		<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quasi ut ipsam odit ea tenetur temporibus nihil earum sequi aliquid reprehenderit dolorem quis eum atque magni cum molestias aliquam animi dolorum ab ipsa voluptates veniam possimus maxime assumenda nemo labore tempora corporis dignissimos dolore aspernatur delectus laboriosam hic maiores voluptate non!</p>
		<input type="button" value="자세히보기" class="btn" onclick="info('<%= list.get(i) %>');">	
	</div>
	
	<% } %>
	
	<script>
	
		function info(name) {
			alert('회원:' + name);
			//alert(``) > 이제 역따옴표 사용 x
			
		}
	</script>
	
	
	
	
	<!-- 
		
		Rendering
		SSR > Server Side Rending
		CSR > Client Client Rending 
				- 최근에 와서는 JavaScript로도 랜더링이 가능
	
	
	 -->
	
	
	
	
</body>
</html>