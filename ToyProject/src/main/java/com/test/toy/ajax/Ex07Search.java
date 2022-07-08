package com.test.toy.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/ex07search.do")
public class Ex07Search extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//Ex07Search.java
		
		String gender = req.getParameter("gender");
		
		AjaxDAO dao = new AjaxDAO();
		
		ArrayList<AddressDTO> list = dao.searchAddress(gender);
		
		for (AddressDTO dto : list) {
			dto.setGender(dto.getGender().equals("m") ? "남자" : "여자");
		}
		
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		PrintWriter writer = resp.getWriter();
		
		String temp = "";
		
		temp += "[";
		
		for (AddressDTO dto : list) {
			temp += "{";
			temp += String.format("\"seq\": %s,", dto.getSeq());
			temp += String.format("\"name\": \"%s\",", dto.getName());
			temp += String.format("\"age\": %s,", dto.getAge());
			temp += String.format("\"gender\": \"%s\",", dto.getGender());
			temp += String.format("\"tel\": \"%s\",", dto.getTel());
			temp += String.format("\"address\": \"%s\"", dto.getAddress());
			temp += "},";
		}
		
		if (list.size() > 0) {
			temp = temp.substring(0, temp.length() - 1);
		}
		
		temp += "]";
		
		System.out.println(temp);
		
		writer.print(temp);
		
		writer.close();		
	}

}






















