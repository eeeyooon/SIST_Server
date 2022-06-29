package com.test.toy.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/board/del.do")
public class Del extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//Del.java > 삭제할지 확인하기
		//1. 데이터 가져오기(seq)
		//2. JSP 호출하기
		
		String seq = req.getParameter("seq");
		
		//여기서 삭제할건 아니지만 delok에게 seq를 보내줘야하니까
		req.setAttribute("seq", seq);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/del.jsp");

		dispatcher.forward(req, resp);

	}
}

