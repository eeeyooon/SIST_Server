package com.test.toy.board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/board/add.do")
public class Add extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		//Add.java
		//reply가 있으면 답변쓰기, 없으면 새글쓰기
		
		//새글쓰기 > add.do
		//답변쓰기	 > add.do?reply=1
		
		
		//add.do로 넘기면 > null이 반환됨.
		//add.do?reply= > ""(빈문자열) 반환 >> req.getParameter("reply");가 빈문자열로 받음.
		//add.do?reply=1 > 1이 반환

		String reply = req.getParameter("reply");
		String thread = req.getParameter("thread");
		String depth = req.getParameter("depth");
		
		
		//해시 태그 목록 가져오기(자동 완성)
		BoardDAO dao = new BoardDAO();
		
		ArrayList<String> taglist = dao.taglist();
		
		
		
		req.setAttribute("reply", reply);
		req.setAttribute("thread", thread);
		req.setAttribute("depth", depth);
		
		req.setAttribute("taglist", taglist);
		
		
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/add.jsp");

		dispatcher.forward(req, resp);

	}
}
