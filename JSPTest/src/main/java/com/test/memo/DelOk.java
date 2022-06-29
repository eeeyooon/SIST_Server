package com.test.memo;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/memo/delok.do")
public class DelOk extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//DelOk.java
		//1. 데이터 가져오기(seq, pw)
		//2. DB 작업 > DAO 위임 > delete
		//3. int result
		//4. JSP 호출하기 + 3번 전달하기
		
		//1.
		String seq = req.getParameter("seq");
		String pw = req.getParameter("pw");
		
		//2.
		DTO dto = new DTO();
		
		dto.setSeq(seq);
		dto.setPw(pw);
		
		
		DAO dao = new DAO();
		
		//3.
		int result = 0;
		
		if (dao.check(dto)) {
			result = dao.del(seq);
		}
		
		//4.
		req.setAttribute("result", result);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/memo/delok.jsp");
		dispatcher.forward(req, resp);
	}

}


















