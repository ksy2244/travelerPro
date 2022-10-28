package com.more;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.TravelServlet;

@WebServlet("/more/*")
public class MoreServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
	
		if(uri.indexOf("service.do") != -1) {
			service(req, resp);
		} else if(uri.indexOf("privacy.do") != -1) {
			privacy(req, resp);
		} else if(uri.indexOf("e-commerce.do") != -1) {
			eCommerce(req, resp);
		} else if(uri.indexOf("e-commerceCaution.do") != -1) {
			caution(req, resp);
		} 
		
	}
	
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/more/service.jsp");
		return;
	}
	
	protected void privacy(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/more/privacy.jsp");
		return;
	}
	
	protected void eCommerce(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/more/eCommerce.jsp");
		return;
	}
	
	protected void caution(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/more/caution.jsp");
		return;
	}

}
