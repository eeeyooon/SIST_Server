<%@page import="com.test.jsp.Student"%>
<%@page import="java.util.HashMap"%>
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
<style>

</style>
</head>
<body>
	
	<!-- ex29_el.jsp -->
	<div class="container">
		
		<h1>EL</h1>
		
		<%
		
			//자바 데이터
			int a = 10;
		
			//pageContext.setAttribute("a", a);
		
			//내장 객체 데이터
			pageContext.setAttribute("b", 20);
			
			request.setAttribute("c", 30);
			
			session.setAttribute("d", 40);
			
		%>
		
		<h2>표현식</h2>
		<div>a: <%= a %></div>
		<div>b: <%= pageContext.getAttribute("b") %></div>
		
		<h2>EL</h2>
		<div>a: ${a}</div>
		<%-- <div>b: ${pageContext.getAttribute("b")}</div>
				>> 이것도 되지만 밑처럼 쉬운 방법이 있으니 굳이 사용 x --%>
		<div>b: ${b}</div>
		<div>c: ${c}</div>
		<div>d: ${d}</div>
		
		
		
		<div>b: <%= pageContext.getAttribute("b") %></div>		
		<div>b: ${b}</div>
		
		<hr>
		
		<h2>EL 기능들</h2>
		
		<h3>EL 연산</h3>
		
		<div>a + 10= <%= a + 10 %></div>
		<div>b + 10= <%= (int)pageContext.getAttribute("b") + 10 %></div>
		<!-- 내장객체데이터는 자료형이 오브젝트니까 연산 불가 >> 그래서 형변환 해야함-->
		<div>b + 10 = ${b} + 10</div>
		
		<!-- 형변환을 안해줬는데도 자동 형변환을 해줌 -->
		<div>b + 10 = ${b + 10}</div>
		<div>b + 10 = ${b - 10}</div>
		<div>b + 10 = ${b * 10}</div>
		<div>b + 10 = ${b / 10}</div>
		<div>b + 10 = ${b % 10}</div>
		<div>b mod 10 = ${b mod 10 }</div>
		
		<hr>
		
		<div>b &gt; 10 = ${d > 10}</div>
		<div>b &gt; 10 = ${d > 10}</div>
		
		<div>b &gt; 10 = ${d > 10}</div>
		<div>b &gt; 10 = ${d > 10}</div>
		
		<div>b == 10 = ${b == 10}</div>
		<div>b != 10 = ${b != 10}</div>
		
		<hr>
		
		<div>${true && false}</div>
		<div>${true || false}</div>
		<div>${!true}</div>
		
		<hr>
		
		<div>${b > 0 ? "양수" : "음수" }</div>
		
		<hr>
		
		<%-- <div>${"홍길동".equals("홍길동")}</div> --%>
		<div>${"홍길동" == "홍길동"}</div>
		
		<%
		
			HashMap<String,String> map = new HashMap<String, String>();
		
			map.put("name", "홍길동");
			map.put("age", "20");
			map.put("job", "학생");
			
			
			pageContext.setAttribute("map", map);
			//이렇게 해야 EL 사용 가능
			
		%>
		<h2>HashMap 출력 지원</h2>
		
		<div>이름: <%= map.get("name") %></div>
		<div>나이: <%= Integer.parseInt(map.get("age")) %></div>
		<div>직업: <%= map.get("job") %></div>
		
		<!-- EL은 내장 객체 안에 있는것만 사용 가능 -->
		<div>이름: ${map.get("name")}</div>
		<div>나이: ${map["age"]}</div>
		<div>직업: ${map.job}</div>
		<!-- 세가지 방법  -->
		
		<div>나이: ${map.age - 1}</div>
		<!-- 19 -->
		
		
		<%
		
			Student s = new Student();
			
			s.setName("홍길동");
			s.setKor(100);
			s.setEng(90);
			s.setMath(80);
			
			request.setAttribute("s", s);
		
		%>
		
		<h2>자바 객채 출력 지원</h2>
		
		<div>이름: <%= s.getName() %></div>
		<div>총점: <%= s.getKor() + s.getEng() + s.getMath() %></div>
		
		<div>이름: ${s.getName()}</div>
		<div>이름: ${s["name"]}</div>
		
		<div>이름: ${s.name}</div>
		<!-- 여기서 name은 Student.java의 name이 아니라 getName()임.
			 name > get + name > getName > getName() >> getName() 호출하는 것-->
		
		
		<div>총점: ${s.kor + s.eng + s.math}</div>
		
		<hr>
		
		<%
		
			Student s2 = null;
			
			pageContext.setAttribute("s2", s2);
			
		
		%>
		
		<div><%= s2 == null %></div>
		
		<div>${s2 == null}</div>
		<div>${empty s2}</div>
		
		<div>${s3 == null}</div>
		<div>${empty s3}</div>
		
		<hr>
		
		<%
		
			//pageContext.setAttribute("color", "tomato");
			//request.setAttribute("color", "gold");
			//session.setAttribute("color", "cornflowerblue");
			application.setAttribute("color", "yellowgreen");
		
		%>
		
		
		<h2>내장 객체의 우선 순위</h2>
		
		<div style="background-color:<%= pageContext.getAttribute("color") %>">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi voluptas aliquid incidunt aperiam at explicabo modi odio vel impedit ipsum debitis iusto labore ut qui dolores deleniti sunt veritatis culpa porro minus? Sint quaerat amet laborum aspernatur impedit at iure distinctio doloribus quis hic magni repellendus sapiente animi harum labore.</div>
		<br>
		<div style="background-color:${color}">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi voluptas aliquid incidunt aperiam at explicabo modi odio vel impedit ipsum debitis iusto labore ut qui dolores deleniti sunt veritatis culpa porro minus? Sint quaerat amet laborum aspernatur impedit at iure distinctio doloribus quis hic magni repellendus sapiente animi harum labore.</div>
		<br>
		
		
		
		
	</div>
	
	<script>
	
	</script>
	
	<br><br><br><br><br><br>
</body>
</html>







