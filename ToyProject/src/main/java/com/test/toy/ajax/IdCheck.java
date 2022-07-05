package com.test.toy.ajax;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/idcheck.do")
public class IdCheck extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Idcheck.java
		
		

		String id = req.getParameter("id");
		String result = req.getParameter("result");
		
		req.setAttribute("result", result);
		req.setAttribute("id", id);
		
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/ajax/idcheck.jsp");

		dispatcher.forward(req, resp);

	}
}
