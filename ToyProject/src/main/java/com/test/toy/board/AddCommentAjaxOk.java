package com.test.toy.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/addcommentajaxok.do")
public class AddCommentAjaxOk extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//AddCommentAjaxOk.java
		//1. 인코딩
		//2. 데이터 가져오기
		//3. DB 작업 > DAO 위임 > insert
		//4. 결과
		//5. 피드백
		
		HttpSession session = req.getSession();
		
		//1.
		req.setCharacterEncoding("UTF-8");
		
		//2.
		String content = req.getParameter("content");
		String pseq = req.getParameter("pseq");
		
		//3. + 4.
		CommentDTO dto = new CommentDTO();
		
		dto.setContent(content);
		dto.setPseq(pseq);
		dto.setId((String)session.getAttribute("auth"));
				
		
		BoardDAO dao = new BoardDAO();
		
		int result = dao.addComment(dto);
		
		
		//방금 쓴 댓글 가져오기
		CommentDTO temp = dao.getComment();
		
		
		//5.
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json");
		
		PrintWriter writer = resp.getWriter();
		
		//writer.printf("{ \"result\": %d }", result);
		
		
		writer.print("{");
		writer.printf("\"result\" : %d,",			result);
		writer.printf("\"seq\" : %s,",				temp.getSeq());
		writer.printf("\"id\" : \"%s\",",			temp.getId());
		writer.printf("\"name\" : \"%s\",",         temp.getName());
		writer.printf("\"regdate\" : \"%s\",",		temp.getRegdate());
		writer.printf("\"pseq\" : %s",				temp.getPseq());
		writer.print("}");
		
		writer.close();
		
		/*
		
			{ "result": %d }
			
			
			//방금 작성한 새로운 댓글의 내용을 반환해야함.
			
			 {
			 	"result" : %d,
			 	"seq" : %s,
			 	"id" : "%s",
			 	"name" : "%s",
			 	"regdate" : "%s",
			 	"pseq" : %s
			 }
			
		
		*/
	}

}





















