package com.more;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.answer.FaqDTO;
import com.member.SessionInfo;
import com.util.TravelServlet;

@WebServlet("/more/*")
public class MoreServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("faq.do") != -1) {
			faq(req, resp);
		} if(uri.indexOf("faqList.do") != -1) {
			faqList(req, resp);
		}
		
	}
	
	protected void faq(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/more/faq.jsp");
	}
	
	protected void faqList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cp = req.getContextPath();

		
		MoreDAO dao = new MoreDAO();
		List<FaqDTO> list = null;
		try {
			int categoryNum = Integer.parseInt(req.getParameter("categoryNum"));
			
			if(categoryNum == 0) {
				list = dao.moreFaqAll();
			} else {
				list = dao.moreFaq(categoryNum);
			}
			
			for(FaqDTO dto : list) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			req.setAttribute("list", list);
				
			forward(req, resp, "/WEB-INF/views/more/faqList.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		resp.sendError(400);
		
	}
	
	
	

}
