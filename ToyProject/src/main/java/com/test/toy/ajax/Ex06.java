package com.test.toy.ajax;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/ex06.do")
public class Ex06 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Ex06.java
		
		AjaxDAO dao = new AjaxDAO();
		
		ArrayList<String> blist = dao.listBuseo();
		
		req.setAttribute("blist", blist);
		
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/ajax/ex06.jsp");

		dispatcher.forward(req, resp);

	}
}
