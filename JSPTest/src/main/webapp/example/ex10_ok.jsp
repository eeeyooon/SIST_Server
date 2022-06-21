<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//한글 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//텍스트 박스
	//1. 입력하면 > 입력값 반환
	//2. 입력안하면 > ""(빈문자열) 반환
	String txt1 = request.getParameter("txt1");
	
	
	//암호 박스
	String txt2 = request.getParameter("txt2");
	
	//다중 텍스트
	String txt3 = request.getParameter("txt3");
	txt3 = txt3.replace("\r\n", "<br>");
	//공백도 그대로 전달해서 출력하기 위해
	
	
	//체크 박스
	//1. value 있을때(권장O)
	//	- 체크O > value 반환
	//	- 체크X > null 반환
	//2. value 없을때(권장X)
	//	- 체크O > "on" 반환
	//	- 체크X > null 반환
	
	String cb1 = request.getParameter("cb1");
	String cb2 = request.getParameter("cb2");
	
	//체크박스들
	String cb3 = request.getParameter("cb3");
	String cb4 = request.getParameter("cb4");
	String cb5 = request.getParameter("cb5");
	
	String temp = cb3 + "," + cb4 + "," + cb5;
	
	temp = "";
	
	for (int i=6; i<=8; i++) {
		
		temp += request.getParameter("cb" + i) + ",";
		
		
	}
	
	
	//체크박스들3
	//같은 name을 여러개 가져올때
	String[] cb9 = request.getParameterValues("cb9");
	//리턴값이 배열(여러개니까)
	
	
	
	//라디오 버튼
	String rb = request.getParameter("rb");
	
	//셀렉트 박스
	String sel1 = request.getParameter("sel1");
	
	//셀렉트박스 multiple
	String[] sel2 = request.getParameterValues("sel2");
	
	//히든 태그
	String id = request.getParameter("id");
	
	
	//그 외
	String color = request.getParameter("color");
	
	
	//히든 태그로 좌표 받기
	String left = request.getParameter("left");
	String top = request.getParameter("top");
	


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	<%-- body {
		background-color: <%= color %>
	} --%>
</style>
</head>
<body>
	<!-- ex10_ok.jsp 06/21 -->
	<h1>결과</h1>
	
	<h3>텍스트 박스</h3>
	<div><%= txt1 %></div>
	
	<hr>
	
	<h3>암호 박스</h3>
	<div><%= txt2 %></div>
	
	<hr>
	
	<h3>다중 텍스트</h3>
	<div><%= txt3 %></div>
	
	<hr>
	
	<h3>체크 박스</h3>
	<div><%= cb1 %>, <%= cb2 %> </div>
	
	<hr>
	
	<h3>체크 박스들2</h3>
	<div><%= temp%> </div>
	
	<hr>
	
	<h3>체크 박스들3</h3>
	<div><%= Arrays.toString(cb9) %> </div>
	
	<hr>
	
	<h3>라디오 버튼</h3>
	<div><%= rb %></div>
	
	<hr>
	
	<h3>셀렉트 박스</h3>
	<div><%= sel1 %></div>
	
	<hr>
	
	<h3>셀렉트 박스2</h3>
	<div><%= Arrays.toString(sel2) %></div>
	
	<hr>
	
	<h3>히든 태그</h3>
	<div><%= id %></div>
	
	<hr>
	
	<h3>색상</h3>
	<div><%= color %></div>
	
	<h3>좌표</h3>
	<div><%= left %>, <%= top %></div>
	
	
	
</body>
</html>

























