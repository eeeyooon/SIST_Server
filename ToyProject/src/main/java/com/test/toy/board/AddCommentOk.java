package com.test.toy.board; //06.29

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/AddCommentOk.do")
public class AddCommentOk extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//AddCommentOk.java
		//1. 인코딩
		//2. 데이터 가져오기
		//3. DB 작업 > DAO 위임 > insert
		//4. 결과
		//5. 피드백
		
		HttpSession session = req.getSession();
		//아이디 가져오기 위해 세션 생성
		
		//1.
		req.setCharacterEncoding("UTF-8");
		
		//2.
		String content = req.getParameter("content");
		String pseq = req.getParameter("pseq");
		
		//댓글을 쓸때 검색이 풀리는 것 해결위해 > 데이터 개수도 늘림. (히든태그로 값넘겨주면서)
		String isSearch= req.getParameter("isSearch");
		String column = req.getParameter("column");
		String word = req.getParameter("word");
		
		
		//3.
		
		CommentDTO dto = new CommentDTO();
		
		dto.setContent(content);
		dto.setPseq(pseq);
		dto.setId((String)session.getAttribute("auth"));
		
		//세션에서 아이디 가져오기
		
		BoardDAO dao = new BoardDAO();
		
		int result = dao.addComment(dto);
		
		req.setAttribute("result", result);
		req.setAttribute("isSearch", isSearch);
		req.setAttribute("column", column);
		req.setAttribute("word", word);
		req.setAttribute("pseq", pseq);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/addcommentok.jsp");

		dispatcher.forward(req, resp);

		
		
//		if (result == 1) {
//			
//			//데이터를 여러개 넘겨줬기 때문에 여기서도 보내야함
//			resp.sendRedirect(String.format("/toy/board/view.do?seq=%s&isSearch=%s&column=%s&word=%s", pseq, isSearch, column, word));
//			
//		} else {
//			
//			//JSP가 없으니까 여기서
//			PrintWriter writer = resp.getWriter();
//			
//			writer.println("<html>");
//			writer.println("<body>");
//			writer.println("<script>");
//			writer.println("alert('failed');");
//			writer.println("history.back();");
//			writer.println("</script>");
//			writer.println("</body>");
//			writer.println("</html>");
//			
//			writer.close();
//			
//			
//		}
//		
//		//JSP를 안만들었으니까 RequestDispatcher 필요없음.
		
		// 문제가 생겨서 그냥 원래 JSP만들기했던것처럼 하기로
		
		

		
	}
}
