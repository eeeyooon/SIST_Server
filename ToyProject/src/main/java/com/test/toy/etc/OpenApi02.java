package com.test.toy.etc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/etc/openapi02.do")
public class OpenApi02 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//OpenAPI02.java
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/etc/openapi02.jsp");

		dispatcher.forward(req, resp);

	}
}
