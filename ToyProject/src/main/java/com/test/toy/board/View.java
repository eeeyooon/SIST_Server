package com.test.toy.board;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.GpsDirectory;

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
		
		//좋아요,싫어요로 get메소드 수정하면서 여기도 수정
		
		BoardDTO tempdto = new BoardDTO();
		tempdto.setSeq(seq);
		tempdto.setId((String)session.getAttribute("auth"));
		
		//아직 요청만 했지 담진 않음 -> DAO에서 옮겨담기
		BoardDTO dto = dao.get(tempdto);
		
		
		
		
		//3.5
		//- 출력 데이터 조작하기
		
		// 태그 비활성화
		// 	- 제목
		dto.setSubject(dto.getSubject().replace("<", "&lt;").replace(">", "&gt;"));
		//	- 내용
		dto.setContent(dto.getContent().replace("<", "&lt;").replace(">", "&gt;"));
		
		
		// 개행 인식하기 (엔터포함하기)
		// >> 얘가 비활성화보다 이후에 일어나야함. (안그러면 <br>태그가 적용이 안됨.)
		dto.setContent(dto.getContent().replace("\r\n", "<br>"));
		
		//isSearch != null && column != null && 
		//이걸 밑에 if문에 추가하거나 jsp에서 돌아가기 링크를 history.back()으로 수정하면
		//돌아가기를 눌렀을때 에러 x
		
		//- 검색어 표시하기
		if (isSearch != null && column != null && isSearch.equals("y") && column.equals("content")) {
			
			//안녕하세요. 홍길동입니다.
			//안녕하세요. <span style="background-color:yellow;color:red;">홍길동</span>입니다.
			
			dto.setContent(dto.getContent().replace(word, "<span style=\"background-color:yellow;color:red;\">" + word + "</span>"));
			
		}
		
		
		//07.01 
		//- 첨부 파일이 이미지일 때 내용과 함께 화면에 출력하기 // + "\r\n"
		
		if (dto.getFilename() != null
				&& (dto.getFilename().toLowerCase().endsWith(".jpg")
				|| dto.getFilename().toLowerCase().endsWith(".png")
				|| dto.getFilename().toLowerCase().endsWith(".gif")
				|| dto.getFilename().toLowerCase().endsWith(".jpeg"))) {
			
			//이미지 정보 획득 (이미지 크기, 이미지 저장 시간, 화소 등등)
			BufferedImage img =  ImageIO.read(new File(req.getRealPath("files") + "\\" + dto.getFilename()));
			
			//보통 gps 정보가져올때 사용
//			System.out.println(img.getWidth());
//			System.out.println(img.getHeight());
			
			String temp = "";
			
			if (img.getWidth() > 630) {
				temp = "style='width: 630px;";
			}
			
			
			
			dto.setContent(dto.getContent()
					
				//2번 방법으로 하니까 큰 사진에선 돌아가기 메뉴 안보이고, 게시글 정보 안보여서 1번 방법으로 진행함.
					//1. 이미지 크기 조절방법(깜빡임현상 없앨때) > view.jsp 스크립트에서 show사용
					+ String.format("<div style='margin-top: 15px;'><img src='/toy/files/%s' id='imgAttach' style='display:none;'></div>"
														, dto.getFilename()));
					
					//2. 이미지 크기조절방법(깜빡임현상 없앨때) > 서블릿에서 모두 해결
					//+ String.format("<div style='margin-top: 15px;'><img src='/toy/files/%s' id='imgAttach' %s></div>"
							//, dto.getFilename(), temp));
			
			
			//07/04 추가
			//사진의 GPS 정보 (코드 몰라도돼 알필요없음)
			File file = new File(req.getRealPath("files") + "\\" + dto.getFilename());
            
            String pdsLat = ""; //위도와 경도를 담을 변수
            String pdsLon = "";
            
            try {
	            Metadata metadata = ImageMetadataReader.readMetadata(file);
	            //모든 속성 정보가 들어있는 데이터
	            
	            GpsDirectory gpsDirectory = metadata.getFirstDirectoryOfType(GpsDirectory.class);
	            //그 데이터 중에서 GPS 정보만 따로 뽑아옴.
	            
            // 위도,경도 호출
            if (gpsDirectory.containsTag(GpsDirectory.TAG_LATITUDE)
                  && gpsDirectory.containsTag(GpsDirectory.TAG_LONGITUDE)) {
            	//GPS가 없을수도 있으니까 한번 더 확인
            	
               pdsLat = String.valueOf(gpsDirectory.getGeoLocation().getLatitude());
               pdsLon = String.valueOf(gpsDirectory.getGeoLocation().getLongitude());
               //위,경도 얻어오기
               
              
      
               if (pdsLat != null && pdsLon != null) {
                  req.setAttribute("lat", pdsLat);
                  req.setAttribute("lng", pdsLon);
               }
      
      
            }
            
            } catch(Exception e) {
            	System.out.println(e);
            }
			
			
			
		}//if (이미지?)
		
		
		
		
		
		
		
		
		//3.7 댓글 목록 가져오기
		ArrayList<CommentDTO> clist = dao.listComment(seq);
		
		//가공 작업 - 엔터 포함 + 나중에 댓글 수정 권한 확인, 태그 적용 못하게 하기 *****
		for (CommentDTO cdto : clist) {
			cdto.setContent(cdto.getContent().replace("\r\n", "<br>"));
		}
		
		
		
		
		
		
		
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

