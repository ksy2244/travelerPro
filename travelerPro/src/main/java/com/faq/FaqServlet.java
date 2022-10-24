package com.faq;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.TravelServlet;


@WebServlet("/faq/*")
public class FaqServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
	
		if (uri.indexOf("tab.do") != -1) {
			tab(req, resp);
		} else if (uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("listContent.do") != -1) {
			content(req, resp);
		} else if (uri.indexOf("write.do") != -1) {
			writeForm(req, resp);
		} else if (uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		} 
	}
	
	protected void tab(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/faq/tab.jsp");
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		List<FaqDTO> listAll = null;
		try {
			int categoryNum = Integer.parseInt(req.getParameter("categoryNum"));
			
			if(categoryNum == 0) {
				listAll = dao.listFaq();
			}
			
			List<FaqDTO> list = dao.listFaq(categoryNum);
			
			for(FaqDTO dto : list) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			req.setAttribute("listAll", listAll);
			req.setAttribute("list", list);
			req.setAttribute("categoryNum", categoryNum);
				
			forward(req, resp, "/WEB-INF/views/faq/list.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		resp.sendError(400);
		
	} 
	
	protected void content(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 댓글의 답글 리스트:AJAX-Text
		FaqDAO dao = new FaqDAO();
		
		try {
			//int categoryNum = Integer.parseInt(req.getParameter("categoryNum"));
			long faqNum = Long.parseLong(req.getParameter("faqNum"));
			
			
			FaqDTO dto = dao.readFaq(faqNum);
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			req.setAttribute("dto", dto);
			
			forward(req, resp, "/WEB-INF/views/faq/list.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendError(400);
		
	}
	
	
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("submit", "등록");
		req.setAttribute("title", "faq 등록");
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/faq/write.jsp");
	}
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		
		String cp = req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/faq/tab.do");
			return;
		}
		
		try {
			FaqDTO dto = new FaqDTO();
			
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setCategoryNum(Integer.parseInt(req.getParameter("categoryNum")));
			
			dao.insertFaq(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/faq/tab.do");
	}

}
