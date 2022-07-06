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

@WebServlet("/ajax/ex06data.do")
public class Ex06Data extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//Ex06Data.java
		
		String buseo = req.getParameter("buseo");
		
		AjaxDAO dao = new AjaxDAO();
		
		ArrayList<BuseoDTO> list = dao.listInsa(buseo);
		
		
		//ArrayList<BuseoDTO> -> JSON 변환
		
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		PrintWriter writer = resp.getWriter();
		
		String temp = "";
		
		temp += "[";
		
		for (BuseoDTO dto : list) {
			
			temp += "{";
			
			temp += String.format("\"num\": %s,", dto.getNum());
			temp += String.format("\"name\": \"%s\",", dto.getName());
			temp += String.format("\"jikwi\": \"%s\",", dto.getJikwi());
			temp += String.format("\"tel\": \"%s\",", dto.getTel());
			temp += String.format("\"city\": \"%s\"", dto.getCity());
			
			temp += "},";
		}
		
		
		temp = temp.substring(0, temp.length() -1); //마지막 ',' 제거
	
		temp += "]";
		
		
		writer.print(temp);
		
		writer.close();
		
		//http://localhost:8090/toy/ajax/ex06data.do?buseo=기획부
		//쿼리스트링 직접 넘겨주기
		
		
		//[{"num": 1001,"name": "홍길동","jikwi": "부장","tel": "011-2356-4528","city": "제주"},{"num": 1022,"name": "이영숙","jikwi": "대리","tel": "017-5214-5282","city": "전남"},{"num": 1024,"name": "김말자","jikwi": "대리","tel": "011-5248-7789","city": "서울"},{"num": 1031,"name": "지재환","jikwi": "부장","tel": "019-5552-7511","city": "서울"},{"num": 1034,"name": "이정석","jikwi": "사원","tel": "011-3697-7412","city": "경기"},{"num": 1052,"name": "권옥경","jikwi": "사원","tel": "010-3644-5577","city": "경기"},{"num": 1058,"name": "김신제","jikwi": "대리","tel": "010-2415-5444","city": "인천"}]
		
		
		//한명이 오브젝트고 여러명이니까 배열(?)
		
		/*
		 
		 [
		 	{ 
		 		"num": 1001,
		 		"name": "홍길동",
		 		"jikwi": "과장",
		 		"tel": "010-1234-5678",
		 		"city": "서울"
		 	},
		 	
		 	{
		 		"num": 1001,
		 		"name": "홍길동",
		 		"jikwi": "과장",
		 		"tel": "010-1234-5678",
		 		"city": "서울"
		 	},
		 	
		 	{
		 		"num": 1001,
		 		"name": "홍길동",
		 		"jikwi": "과장",
		 		"tel": "010-1234-5678",
		 		"city": "서울"
		 	}
		 	
		 ]
		 
		 
		 */
		
		
		
	}
}










