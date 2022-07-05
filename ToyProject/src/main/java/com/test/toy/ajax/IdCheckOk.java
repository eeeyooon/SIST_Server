package com.test.toy.ajax;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax/idcheckok.do")
public class IdCheckOk extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//IdCheckOk.do
		//1. 데이터가져오기(id)
		//2. DB 작업 > DAO 위임 > select
		//3. 결과 + 피드백
		
		//1.
		String id = req.getParameter("id");
		
		//2.
		AjaxDAO dao = new AjaxDAO();
		
		int result = dao.checkid(id);
		
		//3.
		resp.sendRedirect("/toy/ajax/idcheck.do?result=" + result + "&id=" + id);

	}
}
