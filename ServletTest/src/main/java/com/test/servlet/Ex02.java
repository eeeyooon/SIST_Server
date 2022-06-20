package com.test.servlet; //06.20

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 1. 서블릿 클래스 선언
	a. javax.servlet.Servlet 인터페이스를 구현한다. > 고비용, 복잡함
	a. javax.servlet.http.HttpServlet 클래스를 상속받는다. > 저비용, 간편함 > 선택
 */

public class Ex02 extends HttpServlet {
	
	//2. doGet/doPost 메소드 선언
	//		a. 매개변수 작성
	// 			1. java.servlet.http.HttpServletRequest
	//			2. java.servlet.http.HttpServeletResponse
	public void doGet(HttpServletRequest request, HttpServletResponse response)
									throws IOException, ServletException {
		
		//한글 깨짐 방지하기 > UTF-8 설정하기
		response.setCharacterEncoding("UTF-8");
		
		//3. 동적 HTML 페이지 작성 구현
		PrintWriter writer = response.getWriter();
		
		writer.println("<html>");
		writer.println("<head>");
		writer.println("<meta charset='UTF-8'>");
		writer.println("</head>");
		writer.println("<body>");
		writer.println("<h1>서블릿</h1>");
		writer.println("<p>서블릿으로 만든 동적 웹페이지입니다.</p>");
		writer.println("</body>");
		writer.println("</html>");
		
		writer.close(); //이 작업을 안하면 페이지가 안만들어짐.
		
		//4. 브라우저가 자바 파일(서블릿, 알바생)을 호출한다.
		//- http://localhost:8090/ServletTest/servlet/com.test.servlet.Ex02
		//- http://localhost:8090/ServletTest (여기까진 무조건 들어가야함)
		//	web.xml 수정후 밑에 링크로 사용 (ex02.do를 부르면 com.test.servlet.Ex02로 이동)
		//- http://localhost:8090/ServletTest/ex02.do
		
		//이클립스 기능
		//- 서블릿에서 Ctrl + F11을 누르면 이클립스가 해당 서블릿에 매핑되어 있는 가상 주소를 대신 브라우저를 통해서 호출해줌.
		// 원래는 서버 재시작한다음에 우리가 직접 브라우저를 열고, url을 입력해야함. -> 일종의 서비스 제공
		// 근데 갑자기 안되는 버그가 있기도 함 (가상 주소 말고 저 서블릿 그대로 호출되는 버그) -> 해결방법x 기다리면 돌아옴.
		
	}	

}
