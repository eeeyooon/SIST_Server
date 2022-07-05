package com.test.toy.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/ex04data.do")
public class Ex04Data extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Ex04Data.java
		
		try {
			
			//하던일을 5초간 멈춰라.
			Thread.sleep(5000);
			
		} catch (Exception e) {
			System.out.println("Ex04Data.doGet");
			e.printStackTrace();

		}
		
		Random rnd = new Random(); //DB data
		
		PrintWriter writer = resp.getWriter();
		
		writer.print(rnd.nextInt(100));
		
		writer.close();
		
		
		

	}
}
