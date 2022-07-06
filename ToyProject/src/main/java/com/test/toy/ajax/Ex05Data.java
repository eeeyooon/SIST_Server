package com.test.toy.ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/ex05data.do")
public class Ex05Data extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Ex05Data.java
		
		String txt4 = req.getParameter("txt4");
		
		
		//피드백
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		PrintWriter writer = resp.getWriter();
		
		writer.print("{");
		writer.print("\"status\":\"1\",");
		writer.printf("\"value\":\"%s\"", txt4);
		writer.print("}");
		
		/*
		 	
		 	Echo Service > Ping Test
		 				
			{
				"status":"1",
				"value":"%s"
			}
		
		*/
		writer.close();

		
	}

}





















