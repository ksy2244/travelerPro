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
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if (uri.indexOf("map.do") != -1) {
			map(req, resp); 
		} else if (uri.indexOf("surroundcompany.do") != -1) {
			surroundcompany(req, resp);
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
		String mapx = req.getParameter("mapx");
		String mapy = req.getParameter("mapy");
		
		System.out.println(mapx);
		System.out.println(mapy);
		req.setAttribute("id", id);
		req.setAttribute("typeid", typeid);
		req.setAttribute("areacode", areaCode);
		req.setAttribute("region", region);
		req.setAttribute("mapx", mapx);
		req.setAttribute("mapy", mapy);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
		forward(req, resp, "/WEB-INF/views/attraction/content.jsp");
	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	protected void map(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			String address = req.getParameter("address");
			String title = req.getParameter("title");
			
			System.out.println(address);
			System.out.println(title);
			req.setAttribute("address", address);
			req.setAttribute("title", title);
		} catch (Exception e) {
			e.printStackTrace();
		}
		forward(req, resp, "/WEB-INF/views/attraction/map.jsp");
	}
	protected void surroundcompany(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
}