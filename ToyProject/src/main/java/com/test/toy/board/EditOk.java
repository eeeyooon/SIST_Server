package com.test.toy.board;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/board/editok.do")
public class EditOk extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		//EditOk.java
		//1. 인코딩 (한글로 포스트가 넘어왔으니까)
		//2. 데이터 가져오기(subject, content, seq)
		//3. DB 작업 > DAO 위임 > update
		//4. 결과
		//5. JSP 호출하기

		HttpSession session = req.getSession();
		
		
		
		//1.
		req.setCharacterEncoding("UTF-8");
		
		
		//1.5 파일 업로드 수정
		//새로운 파일을 선택했을 때만! 
		//파일 추가 > (enctype추가하면서 ) >> req.getParameter 이제 동작 안함 ******
		
		String path = req.getRealPath("/files");
		int size = 1024 * 1024 * 100; //100MB
		
		
		//MultipartRequest로 다 고쳐줘야함.
		MultipartRequest multi = null;
		
		try {
			
			multi = new MultipartRequest(
											req,
											path,
											size,
											"UTF-8",
											new DefaultFileRenamePolicy()
										);
					
					
			
		} catch (Exception e) {
			System.out.println("AddOk.doPost");
			e.printStackTrace();

		}
		
		
		
		//2.
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String seq = multi.getParameter("seq");
		
		//07/01 eidt.jsp에서 가져오고 multi로 바꿔주기 (밑에 4번도 추가함)
		String isSearch = multi.getParameter("isSearch");
		String column = multi.getParameter("column");
		String word = multi.getParameter("word");
		
		
		//3.
		BoardDTO dto = new BoardDTO();
		
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setSeq(seq);
		
		BoardDAO dao = new BoardDAO();
		
		
		//07.01
		//3.5 첨부파일 처리
		//3.5.1 기존 파일 O > 새로운 파일로 교체하는 경우
			
			// 1) 기존 파일이 있는지 확인
			// 2) 기존 파일을 찾아서 지우기
		
		//새 파일
		String filename = multi.getFilesystemName("attach");
		String orgfilename = multi.getOriginalFileName("attach");
		
		//System.out.println("filename: " + (filename == null));
		
		//기존 파일
		BoardDTO tempdto = dao.get(seq);
		//DB 갔다오기 (기존 파일있는지와 기존파일의 이름 확인하러)
		
		if (tempdto.getFilename() != null && filename != null) {
			//기존파일이 있는지 , 새파일이 있는지
			
			//1. 기존 파일 삭제하고 새 파일로 교체하기
			//기존 파일 삭제
			File file = new File(path + "\\" + tempdto.getFilename());
			file.delete();
			
			//새파일로 교체
			dto.setFilename(filename);
			dto.setOrgfilename(orgfilename);
			
			//오브젝트로 만들었는데 매개변수를 추가안하면 null이 됨 ?
		
		} else if (filename == null && multi.getParameter("delfile").equals("y")) {
				
			//2. 기존 파일만 삭제하고, 새로운 파일을 추가 안했을 경우
			File file = new File(path + "\\" + tempdto.getFilename());
			file.delete();
				
			
			//3번 조건이 더 넓으니까 if문 순서 밑으로
		} else if (filename == null) {
			//3. 기존 파일의 유무와 상관없이 새로운 파일을 추가 안했을 경우
			//dto.setFilename(예전 파일명);
			//dto.setOrgfilename(예전 파일명);
			
			//예전 파일명 세팅해주기
			dto.setFilename(tempdto.getFilename());
			dto.setOrgfilename(tempdto.getOrgfilename());
			
		} else if (tempdto.getFilename() == null && filename != null) {
			//3. 기존 파일이 없는데 새로운 파일을 추가하는 경우
			dto.setFilename(filename);
			dto.setOrgfilename(orgfilename);
			
			
		} 
		
		
		
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
		
		//관리자(3)와 글쓴 본인(2)에겐 수정 권한 줌.
		//타인(4)과 익명 사용자(1)에겐 수정 권한 x
				
		
		
		//글쓴 본인과 관리자에게만 edit할 권한 줌
		if (temp == 2 || temp == 3) {
			result = dao.edit(dto);
		}
		
		
		//4.
		req.setAttribute("result", result);		
		req.setAttribute("seq", seq);
		//editok.jsp에서 돌아가기를 누르면 다시 view.do로 가야하는데, 이때 seq가 필요하니까 seq넘겨줌
		
		
		//07/01 추가
		req.setAttribute("isSearch", isSearch);
		req.setAttribute("column", column);
		req.setAttribute("word", word);
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/editok.jsp");

		dispatcher.forward(req, resp);

	}
}
