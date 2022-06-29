package com.test.toy.board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/view.do")
public class View extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//View.java
		//1. 데이터 가져오기(seq)
		//2. DB 작업 > DAO 위임 > select
		//3. 결과
		//4. JSP 호출하기 + 결과 전달하기
		
		HttpSession session = req.getSession();
		
		
		
		//1.
		String seq = req.getParameter("seq");
		
		
		//검색 정보
		String isSearch = req.getParameter("isSearch");
		String column = req.getParameter("column");
		String word = req.getParameter("word");
		
		
		
		//2. + 3.
		BoardDAO dao = new BoardDAO();
		
		
		//3.2 조회수 증가 (무분별한 증가x 새로고침해도 증가안되게. list에서 작업후 여기서 작업)
		
		if (session.getAttribute("read") == null || session.getAttribute("read").toString().equals("n")) {
			
			dao.updateReadcount(seq);
			session.setAttribute("read", "y");
		}
		
		//조회수 증가를 얘보다 밑에서 하면 내가 읽은 횟수는 포함이 안됨.
		BoardDTO dto = dao.get(seq);
		
		
		
		
		//3.5
		//- 출력 데이터 조작하기
		
		// 태그 비활성화
		//	- 내용
		dto.setContent(dto.getContent().replace("<", "&lt;").replace(">", "&gt;"));
		// 	- 제목
		dto.setSubject(dto.getSubject().replace("<", "&lt;").replace(">", "&gt;"));
		
		
		// 개행 인식하기 (엔터포함하기)
		// >> 얘가 비활성화보다 이후에 일어나야함. (안그러면 <br>태그가 적용이 안됨.)
		dto.setContent(dto.getContent().replace("\r\n", "<br>"));
		
		
		//- 검색어 표시하기
		if (isSearch.equals("y") && column.equals("content")) {
			
			//안녕하세요. 홍길동입니다.
			//안녕하세요. <span style="background-color: yellow; color: red;">홍길동</span>입니다.
			
			dto.setContent(dto.getContent().replace(word, "<span style=\"background-color: yellow; color: red;\">" + word + "</span>"));
			
			
			
		}
		
		
		
		
		//3.7 댓글 목록 가져오기
		ArrayList<CommentDTO> clist = dao.listComment(seq);
		
		
		
		
		
		
		
		//4.
		req.setAttribute("dto", dto);
		
		//view.jsp에도 Hashmap 내용을 줘야 함. (근데 해쉬맵은 안만들었으니까 하나씩 줘야함)
		
		req.setAttribute("isSearch", isSearch);
		req.setAttribute("column", column);
		req.setAttribute("word", word);
		
		
		//list > view.java > view.jsp까지 옴.
		
		req.setAttribute("clist", clist);
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/view.jsp");

		dispatcher.forward(req, resp);

	}
}

