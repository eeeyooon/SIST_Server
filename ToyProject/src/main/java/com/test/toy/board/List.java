package com.test.toy.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/list.do")
public class List extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//Get을 요청하면 이게 실행됨.
		doTemp(req, resp);

	}
	
	//검색할땐 GET을 쓸거라 사용 안해도됨.
//	@Override
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		//Post를 요청하면 이게 실행됨.
//		
//		doTemp(req, resp);
//
//	}


	private void doTemp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//List.java
		//1. DB작업 > DAO 위임 > select
		//2. 결과
		//3. JSP 호출하기 + 결과 전달하기
		
		//그냥 list를 부른건지, 검색을 통해 부른건지 구분을 해야함. 
		//그냥 목록: - list.do
		//검색으로 목록 호출 : - list.do  + (column + word)
		
		req.setCharacterEncoding("UTF-8");
		
		
		String column = req.getParameter("column");
		String word = req.getParameter("word");
		String isSearch = "n";
		
		if ((column == null || word == null)
				|| (column == "" || word == "")) {
			isSearch = "n";
		} else {
			isSearch = "y";
		}
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		map.put("column", column);
		map.put("word", word);
		map.put("isSearch", isSearch);
		
				
		
		HttpSession session = req.getSession();
		
		//1. + 2.
		BoardDAO dao = new BoardDAO();
		
		ArrayList<BoardDTO> list = dao.list(map);
		
		
		//2.5
		//- 출력 데이터의 가공 업무
		
		Calendar now = Calendar.getInstance();
		String strNow = String.format("%tF", now); //"2022-06-29"
		
		
		for (BoardDTO dto : list) {
			
			//시분초 자르기
			if (dto.getRegdate().startsWith(strNow)) {
				//오늘
				dto.setRegdate(dto.getRegdate().substring(11));
			} else {
				//어제 이전
				dto.setRegdate(dto.getRegdate().substring(0,10));
			}
			
			//제목이 길면 자르기
			if (dto.getSubject().length() > 37) {
				dto.setSubject(dto.getSubject().substring(0,37) + "..");
			}
			
			//태그 비활성화 (리스트의 제목에서)
			dto.setSubject(dto.getSubject().replace("<", "&lt;").replace(">", "&gt;"));
			
			
		}
		
		
		//2.7 새로고침 조회수 증가 방지
		session.setAttribute("read", "n");
		
		
		//3.
		
		req.setAttribute("list", list);
		
		req.setAttribute("map", map);
		//검색에 관련된 모든게 들어있는 해쉬맵 > 이걸 JSP에 전송 (
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/list.jsp");

		dispatcher.forward(req, resp);
	}
}
