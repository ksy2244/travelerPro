package com.attraction;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.TravelServlet;

@WebServlet("/attraction/*")
public class AttractionServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();
		
		if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		}  else if (uri.indexOf("content.do") != -1) {
			content(req, resp);
		}
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String areaCode = req.getParameter("areacode");
			String region = req.getParameter("region");
			String id = req.getParameter("contentid");
			String typeid = req.getParameter("contenttypeid");
			req.setAttribute("id", id);
			req.setAttribute("typeid", typeid);
			req.setAttribute("areacode", areaCode);
			req.setAttribute("region", region);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		forward(req, resp, "/WEB-INF/views/attraction/tourist.jsp");
	}
	protected void content(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
		String areaCode = req.getParameter("areacode");
		String region = req.getParameter("region");
		String id = req.getParameter("contentid");
		String typeid = req.getParameter("contenttypeid");
		
		req.setAttribute("id", id);
		req.setAttribute("typeid", typeid);
		req.setAttribute("areacode", areaCode);
		req.setAttribute("region", region);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
		forward(req, resp, "/WEB-INF/views/attraction/content.jsp");
	}
	
}