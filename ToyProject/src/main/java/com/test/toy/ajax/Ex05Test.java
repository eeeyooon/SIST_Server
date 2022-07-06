package com.test.toy.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.toy.board.BoardDAO;
import com.test.toy.board.BoardDTO;

@WebServlet("/ajax/ex05test.do")
public class Ex05Test extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//Ex05Text.java
		
		
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.get("333");
		
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("begin", "1");
		map.put("end", "3");
		map.put("isSearch", "n");
		ArrayList<BoardDTO> list = dao.list(map);
		
		
		//System.out.println(list);
		
		//Text 반환
		
		//-인코딩
		resp.setCharacterEncoding("UTF-8");
		//이것만 하면 깨짐. HTML에 meta태그에 인코딩없어서 > 근데 우린 txt로 받을거니까 순수 TEXT로 받을 수 있게 해야함.
		resp.setContentType("text/plain");
		//순수 텍스트 파일로 인식할 수 있게 설정하는 메소드 (순수 텍스트는 위의 인코딩만 넣으면 한글로 나옴. HTML은 따로 추가해야하고)
		
		PrintWriter writer = resp.getWriter();
		
		//writer.print(dto.getName());
		
		//CSV
		//writer.printf("%s,%s,%s,%s", dto.getSubject(), dto.getContent(), dto.getName(), dto.getRegdate());
		
		//제목,이름,날짜
		//제목,이름,날짜
		//제목,이름,날짜
		
		for (BoardDTO item : list) {
			writer.printf("%s,%s,%s\r\n"
							, item.getSubject()
							, item.getName()
							, item.getRegdate());
		}
		
		writer.close();
		
		

	}
}
