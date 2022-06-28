package com.test.memo; //06.28

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/memo/del.do")
public class Del extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//Del.java
		//1. 데이터 가져오기 (del.do?seq=5)
		//2. JSP 호출하기 + 데이터 전달하기
		
		
		//1.
		String seq = req.getParameter("seq");
		
		//2.
		req.setAttribute("seq", seq);
		
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/memo/del.jsp");

		dispatcher.forward(req, resp);

	}
}
