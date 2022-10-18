package com.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.TravelServlet;

@WebServlet("/admin/*")
public class AdminServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		// 메인 화면
		String uri = req.getRequestURI();

		if(uri.indexOf("admin.do") != -1) {
			forward(req, resp, "/WEB-INF/views/admin/admin.jsp");
		} 
		
	}
	
	

}
