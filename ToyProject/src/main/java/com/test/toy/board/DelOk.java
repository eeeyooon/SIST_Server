package com.test.toy.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/delok.do")
public class DelOk extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//DelOk.java
		//1. 데이터 가져오기(seq)
		//2. DB 작업 > DAO 위임 > seq
		//3. 결과
		//4. JSP 호출하기
		
		
		HttpSession session = req.getSession();
		
		//1.
		String seq = req.getParameter("seq");
		
		//2. + 3.
		BoardDAO dao = new BoardDAO();
		
		
		//url로 접근해도 수정,삭제 못하게 (본인글 아니면)
		int temp = 0;
		
		if (session.getAttribute("auth") == null) {
			//세션을 뒤졌을때 인증티켓이 없으면
			temp = 1; //익명 사용자
		} else if (session.getAttribute("auth") != null) { 
			//인증티켓이 있으면 실명사용자
			//temp = 1; //실명 사용자
			
			if (session.getAttribute("auth").equals(dao.get(seq).getId())) {
				temp = 2; //글쓴 본인(***)
			} else {
				
				if (session.getAttribute("auth").toString().equals("admin")) {
					temp = 3; //관리자(***)
				} else {
					temp = 4; //타인
				}
				
			}
			
		}
				
		
		int result = 0;
		
		//글쓴 본인과 관리자에게만 del할 권한 줌
		if (temp == 2 || temp == 3) {
			
			
			//댓글 삭제
			dao.delCommentAll(seq);
			
			
			//원글 삭제
			result = dao.del(seq);
			
		}
		
		
		
		
		//4.
		req.setAttribute("result", result);		

		
		
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/delok.jsp");

		dispatcher.forward(req, resp);

	}
}

