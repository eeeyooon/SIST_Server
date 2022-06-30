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
		
		
		
		//페이징
		int nowPage = 0;			//현재 페이지 번호(= page)
		int begin = 0; 				//SQL 조건으로 걸 시작값
		int end = 0; 
		int pageSize = 10;			//한페이지 당 출력할 게시물 수
		
		
		int totalCount = 0;			//총 게시물 수
		int totalPage = 0;			//총 페이지수 = totalCount / 10
		
		//list.do  > 기존
		//list.do?page=1  > 이제부터
		//만약 페이지번호를 안넘기고 list.do만 하면 임의로 1페이지 처리
		
		String page = req.getParameter("page");
		
		if (page == null || page == "") nowPage = 1;
		else nowPage = Integer.parseInt(page);
		
		//nowPage > 현재 보게 될 페이지 번호
		//list.do?page=1 > where rnum between 1 and 10
		//list.do?page=2 > where rnum between 21 and 30
		//list.do?page=3 > where rnum between 31 and 40
		
		begin = ((nowPage - 1) * pageSize) + 1;
		end = begin + pageSize - 1;
		
		
		
		
		map.put("begin", begin + "");
		map.put("end", end + "");
		//자료형이 안맞으니까 문자열로 변환시키기
				
		
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
		
		
		//페이징
		//2.6 총 페이지 수 구하기
		//- 총 게시물 수 > 284
		//- 총 페이지 수 > 284 / 10 = 28.4 페이지 > 29페이지
		//검색 조건이 담긴 map도 같이 넘겨줘야 함.
		totalCount = dao.getTotalCount(map);
		totalPage = (int)Math.ceil((double)totalCount / pageSize);
		//Math.ceil은 double을 받으니까 둘 중 하나를 double로 > 최종적으로 int값이 필요하니까 int로 형변환
		
		
//		System.out.println(totalCount);
		
		
		String pagebar = "";
		
		int blockSize = 10;	//한번에 보여질 페이지 개수
		int n = 0;			//페이지 번호
		int loop = 0;		//루프
		
		pagebar = "";
		
		//list.do?page=1
		//1 2 3 4 5 6 7 8 9 10
		
		//list.do?page=3
		//1 2 3 4 5 6 7 8 9 10
		
		//list.do?page=11
		//11 12 13 14 15 16 17 18 19 20
		
		
		loop = 1;
		n = ((nowPage - 1) / blockSize) * blockSize + 1;
		
//		for (n = 1; n<=totalPage; n++) {
//		if (n == nowPage) {
//			pagebar += String.format(" <a href='#!' style='color:cornflowerblue;'>%d</a> "
//					, n
//					, n);
//		} else {
//			pagebar += String.format(" <a href='/toy/board/list.do?page=%d'>%d</a> "
//					, n
//					, n);
//		}
//	}
		
		
		/*
		 
			
			  <ul class="pagination">
			  
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			    
			  </ul>
			  
		 
 
		 */
		

		
		
		pagebar += "<ul class=\"pagination\">";
		
		
		
		//이전 10페이지 + 부트스트랩x
//		if (n == 1) {
//			pagebar += String.format(" <a href='#!'>[이전 %d페이지]</a> "
//					, blockSize);
//		} else {
//			pagebar += String.format(" <a href='/toy/board/list.do?page=%d'>[이전 %d페이지]</a> "
//					, n - 1
//					, blockSize);
//		}
		
		
		//부트스트랩 버전 (페이지수가 아니라 아이콘이니까 blockSize 지우기)
		//이전페이지
		if (n == 1) {
			pagebar += String.format("<li class=\"page-item\">\r\n"
					+ "			      <a class=\"page-link\" href=\"#!\" aria-label=\"Previous\">\r\n"
					+ "			        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>"
					);
		} else {
			pagebar += String.format("<li class=\"page-item\">\r\n"
					+ "			      <a class=\"page-link\" href=\"/toy/board/list.do?page=%d\" aria-label=\"Previous\">\r\n"
					+ "			        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>"
					, n - 1
					);
		}
		
		
		
		
		//부트스트랩 x 버전 (기본 페이지번호)
//		while (!(loop > blockSize || n > totalPage)) {
//			
//			if (n == nowPage) {
//				pagebar += String.format(" <a href='#!' style='color:cornflowerblue;'>%d</a> "
//						, n);
//			} else {
//				pagebar += String.format(" <a href='/toy/board/list.do?page=%d'>%d</a> "
//						, n
//						, n);
//			}
//			
//			loop++;
//			n++;
//			
//		}
		
		
		//기본 페이지번호
		//부트스트랩 버전 #만 있으면 스크롤 올라감. #!여야 안올라감
		//active붙여서 현재 페이지에 옵션주기
		while (!(loop > blockSize || n > totalPage)) {
			
			if (n == nowPage) {
				pagebar += String.format("<li class=\"page-item active\"><a class=\"page-link\" href=\"#!\">%d</a></li>"
						, n);
			} else {
				pagebar += String.format("<li class=\"page-item\"><a class=\"page-link\" href=\"/toy/board/list.do?page=%d\">%d</a></li>"
						, n
						, n);
			}
			
			loop++;
			n++;
			
		}
		
		
		//다음 10페이지
		
//		if (n > totalPage) {
//			pagebar += String.format(" <a href='#!'>[다음 %d페이지]</a> "
//					, blockSize);
//		} else {
//			pagebar += String.format(" <a href='/toy/board/list.do?page=%d'>[다음 %d페이지]</a> "
//					, n
//					, blockSize);
//			
//		}
		
		//여기 시점의 n은 마지막 페이지 수 보다 + 1 큼 (totalPage보다 크니까 while문이 끝난거임)
		
		
		//다음 10페이지
		//부트스트랩
		if (n > totalPage) {
			pagebar += String.format("<li class=\"page-item\">\r\n"
					+ "			      <a class=\"page-link\" href=\"#!\" aria-label=\"Next\">\r\n"
					+ "			        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>"
					);
		} else {
			pagebar += String.format("<li class=\"page-item\">\r\n"
					+ "			      <a class=\"page-link\" href=\"/toy/board/list.do?page=%d\" aria-label=\"Next\">\r\n"
					+ "			        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>"
					, n
					);
			
		}
		
		
		
		pagebar += "</ul>";
		
		
		
		//2.7 새로고침 조회수 증가 방지
		session.setAttribute("read", "n");
		
		
		//3.
		
		req.setAttribute("list", list);
		
		req.setAttribute("map", map);
		//검색에 관련된 모든게 들어있는 해쉬맵 > 이걸 JSP에 전송 (
		
		//페이징
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		
		req.setAttribute("nowPage", nowPage);
		
		
		//페이지 바
		req.setAttribute("pagebar", pagebar);
		
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/list.jsp");

		dispatcher.forward(req, resp);
	}
}







