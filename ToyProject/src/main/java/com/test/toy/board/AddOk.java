package com.test.toy.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/addok.do")
public class AddOk extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//AddOk.java
		//1. 인코딩
		//2. 데이터 가져오기(subject, content)
		//3. DB 작업 > DAO 위임 > insert
		//4. 결과
		//5. JSP 호출하기
		
		HttpSession session = req.getSession();
		
		//1.
		req.setCharacterEncoding("UTF-8");
		
		//2.
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		
		
		//2.5 현재 새글 작성중인지? 답변글 작성중인지?
		String reply = req.getParameter("reply");
		//System.out.println("reply: " + (reply == "")); > true나옴 (빈문자열이 반환됨)
		
		
		int thread = -1;
		int depth = -1;
		
		
		//위치이동
		BoardDAO dao = new BoardDAO();
		
		
		if (reply.equals("")) {
			//새글
			//a. 현존하는 모든 게시물 중에서 가장 큰 thread 값을 찾아서, 그 값에 +1000을 한 값을 새글의 thread값으로 사용한다.
			
			thread = dao.getMaxThread() + 1000;
			
			//b. 새글의 depth는 항상 0을 넣는다.
			depth = 0;
			
			
		} else {
			//답변글
		}
		
		
		//3.
		BoardDTO dto = new BoardDTO();
		
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setId((String)session.getAttribute("auth"));
		
		//답변쓰기
		dto.setThread(thread);
		dto.setDepth(depth);
		
		
		//답변쓰기때 DAO위치 위로 이동
		
		
		int result = 0;
		
		
		if (session.getAttribute("auth") != null) {
		
			result = dao.add(dto);
		}
		
		
		//4.
		req.setAttribute("result", result);		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/addok.jsp");
		dispatcher.forward(req, resp);
	}

}


