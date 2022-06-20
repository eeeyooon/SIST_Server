package com.test.servlet; //06.20

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Ex04_Receive extends HttpServlet {
	
	//서블릿
	//1. 해당 서블릿 > get 요청 > doGet() 호출
	//2. 해당 서블릿 > post 요청 > doPost() 호출
	
	//*****
	//GET로 요청하면 무조건 > doGet()이 있어야하고
	//POST으로 요청하면 > doPOST()가 있어야함.
	
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//Ex04_Send에서 POST요청을 했으니 여기 doGet()을 doPost()로 변경
		
		//<form> -> 현재 서블릿에게 데이터를 전송 -> 우리는 그 데이터를 수신하려고 함.
		
		//<input type='text' name='name'>
		String name = req.getParameter("name");
		//첫번째 텍스트 값에서 입력한 값
		
		//<input type='text' name='age'>
		String age = req.getParameter("age");
		//두번째 텍스트 값에서 입력한 값
		
		// >> 이게 데이터를 수신하는 방법
		
		
		System.out.println(name);
		System.out.println(age);
		
		resp.setCharacterEncoding("UTF-8");
		
		PrintWriter writer = resp.getWriter();
		
		writer.println("<html>");
		writer.println("<head>");
		writer.println("<meta charset='UTF-8'>");
		writer.println("</head>");
		writer.println("<body>");
		writer.println("<h1>수신한 데이터</h1>");
		writer.println("<p>이름: " + name + "</p>");
		writer.println("<p>나이: " + age + "</p>");
		writer.println("</body>");
		writer.println("</html>");
		
		
		writer.close();
		
	}

}







