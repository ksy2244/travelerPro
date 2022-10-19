package com.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.TravelServlet;

@WebServlet("/main/main.do")
public class MainServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		// 메인 화면
		if(uri.indexOf("main.do") != -1) {
			forward(req, resp, "/WEB-INF/views/main/main.jsp");
		}
		
		// -- ** 더보기 ** -- 
		// 자주 묻는 질문 FAQ
		
		/* 
		if(uri.indexOf("main.do") != -1) {
			forward(req, resp, "/WEB-INF/views/main/faq.jsp");
		}
		
		// 1:1 문의 
		if(uri.indexOf("main.do") != -1) {
			forward(req, resp, "/WEB-INF/views/main/memberq.jsp");
		}
		
		// 공지사항 
		if(uri.indexOf("main.do") != -1) {
			forward(req, resp, "/WEB-INF/views/main/notice.jsp");
		}
				
		// 약관 및 정책
		if(uri.indexOf("main.do") != -1) {
			forward(req, resp, "/WEB-INF/views/main/~~~.jsp"); // 아직 안 적음 
		}
				
		*/
		
		
		
		
	}
	
	
	

}
