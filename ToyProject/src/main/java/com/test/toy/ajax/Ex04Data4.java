package com.test.toy.ajax;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/ex04data4.do")
public class Ex04Data4 extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Ex04Data4.java
		
		String name1 = req.getParameter("name1");
		String name2 = req.getParameter("name2");
		
		System.out.println("GET: " + name1);
		System.out.println("GET: " + name2);
		
		
	}
}
