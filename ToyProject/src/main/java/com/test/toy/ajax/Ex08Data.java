package com.test.toy.ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/ex08data.do")
public class Ex08Data extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Ex08Data.java
		
		String id = req.getParameter("id");
		String x = req.getParameter("x");
		String y = req.getParameter("y");
		
		AjaxDAO dao = new AjaxDAO();
		
		DraggableDTO dto = new DraggableDTO();
		
		
		dto.setId(id);
		dto.setLeft(x);
		dto.setTop(y);
		
		int result = dao.updatePosition(dto);
		
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		PrintWriter writer = resp.getWriter();
		
		writer.printf("{ \"result\": %d }", result);
		
		
		writer.close();
		
		
	}
}










