package com.test.mvc; //06.27

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Hello extends HttpServlet {
		
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//자바로 할일~ > 주로 비지니스 코드
		
		//Servlet > Servlet 호출
		//JSP > JSP 호출
		//Servlet > JSP 호출
		//JSP > Servlet 호출
		//= 모두 같은 행동(JSP는 Servlet이다! 겉만 다르지 내부적으로는 Servlet임)
		
		//JSP 호출하기
		//resp.sendRedirect("/jsp/mvc/hello.jsp");
				//맨 앞에 '/'는 루트
		
		//이거 이제 안씀 쓰지마~ > forward사용해
	
		//사용중이던 request, response를 다음 페이지에 전달 가능
		//pageContext.forward();
		
		
		//둘다 사용안하고 pageContext에 준하는 다른 방법을 사용
		
		//DB > "홍길동"
		String name = "홍길동";
		
		req.setAttribute("name", name);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/hello.jsp");
															//여기서 맨 앞 '/'는 webapp임.
		dispatcher.forward(req, resp); //JSP호출하기
	
	
	}
	
}
















