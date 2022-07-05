package com.test.toy.ajax;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/ex02data.do")
public class Ex02Data extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Ex02Data.java
		//1. DB 작업 > DAO 위임 > select
		//2 결과 + 반환
		
		//나중엔 JSP 안만들건데 처음엔 비교 위해 만들어서 사용
		
		AjaxDAO dao = new AjaxDAO();
		
		int cnt = dao.getCount();
			
		req.setAttribute("cnt", cnt);
		
		
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/ajax/ex02data.jsp");

		dispatcher.forward(req, resp);

	}
}
