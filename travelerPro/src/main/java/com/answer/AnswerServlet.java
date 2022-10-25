package com.answer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.qna.QnaVO;
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;


@WebServlet("/answer/*")
public class AnswerServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
	
		if (uri.indexOf("faq.do") != -1) {
			faq(req, resp);
		} else if (uri.indexOf("faqList.do") != -1) {
			faqList(req, resp);
		} else if (uri.indexOf("faqContent.do") != -1) {
			faqContent(req, resp);
		} else if (uri.indexOf("faqWrite.do") != -1) {
			faqWriteForm(req, resp);
		} else if (uri.indexOf("faqWrite_ok.do") != -1) {
			faqWriteSubmit(req, resp);
		} else if (uri.indexOf("qnaList.do") != -1) {
			qnaList(req, resp);
		}
	}
	
	protected void faq(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/answer/faq.jsp");
	}
	
	protected void faqList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
				
			forward(req, resp, "/WEB-INF/views/answer/faqList.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		resp.sendError(400);
		
	} 
	
	protected void faqContent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		
		try {
			//int categoryNum = Integer.parseInt(req.getParameter("categoryNum"));
			long faqNum = Long.parseLong(req.getParameter("faqNum"));
			
			
			FaqDTO dto = dao.readFaq(faqNum);
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			req.setAttribute("dto", dto);
			
			forward(req, resp, "/WEB-INF/views/answer/faqList.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendError(400);
		
	}
	
	
	protected void faqWriteForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("submit", "등록");
		req.setAttribute("title", "faq 등록");
		req.setAttribute("mode", "faqWrite");
		forward(req, resp, "/WEB-INF/views/answer/faqWrite.jsp");
	}
	
	protected void faqWriteSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		
		String cp = req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/answer/faq.do");
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
		
		resp.sendRedirect(cp + "/answer/faq.do");
	}
	
	protected void qnaList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberADAO dao = new MemberADAO();
		TravelUtil util = new TravelUtilBootstrap();
		
		String cp = req.getContextPath();
		
		try {
			int current_page = 1;
			
			int dataCount = dao.qnaCount();
			
			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<QnaVO> list = dao.qnaList(offset, size);
			
			String listUrl = cp + "/answer/qnaList.do";
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("paging", paging);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		forward(req, resp, "/WEB-INF/views/answer/qnaList.jsp");
	
	}

}
