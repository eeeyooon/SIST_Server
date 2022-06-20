package com.test.servlet; //06.20

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Ex04_Send extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		resp.setCharacterEncoding("UTF-8");
		
		PrintWriter writer = resp.getWriter();
		
		writer.println("<html>");
		writer.println("<head>");
		writer.println("<meta charset='UTF-8'>");
		writer.println("</head>");
		writer.println("<body>");
		writer.println("<h1>데이터 입력 + 서버 전송</h1>");
		writer.println("<form method='POST' action='/ServletTest/ex04receive.do'>");
		writer.println("이름: <input type='text' name='name'>");
		writer.println("<br>");
		writer.println("나이: <input type='text' name='age'>");
		writer.println("<br>");
		writer.println("<input type='submit' value='전송하기'>");
		writer.println("</form>");
		writer.println("</body>");
		writer.println("</html>");
		
		
		writer.close();
		
		
		//method를 'POST'로 바꾸자 405에러
		//> HTTP 메소드인 POST는 이 URL에 의해 지원되지 않습니다.
		
		//POST를 요청하면 doPost()가 호출되어야 하는데
		//Ex04_receive 클래스에 doPost()가 없어서 에러!
		
		
		
		
	}

}
