package com.notice;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.member.SessionInfo;
import com.util.MyUploadServlet;
import com.util.MyUtil;
import com.util.MyUtilBootstrap;


@MultipartConfig
@WebServlet("/notice/*")
public class NoticeServlet extends MyUploadServlet {
	private static final long serialVersionUID = 1L;
	
	private String pathname;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		/*
		if(info.getUserId() == "admin") {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		*/
		
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "notice";
				
		if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if(uri.indexOf("write.do") != -1) {
			writeForm(req, resp);
		} else if(uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		} else if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if(uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if(uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if(uri.indexOf("deleteFile.do") != -1) {
			deleteFile(req, resp);
		} else if(uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if(uri.indexOf("download.do") != -1) {
			download(req, resp);
		} 
		
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		MyUtil util = new MyUtilBootstrap();
		
		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount();
			
			int size = 15;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<NoticeDTO> list = dao.listNotice(offset, size);
			
			String listUrl = cp + "/notice/list.do";
			String articleUrl = cp + "/notice/article.do?page=" + current_page;
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		forward(req, resp, "/WEB-INF/views/notice/list.jsp");
	}
	
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/notice/write.jsp");
	}
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String cp = req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/notice/list.do");
			return;
		}
		
		try {
			NoticeDTO dto = new NoticeDTO();
			
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			
			Part p = req.getPart("selectFile");
			Map<String, String> map = doFileUpload(p, pathname);
			if(map != null) {
				String saveFilename = map.get("saveFilename");
				String originalFilename = map.get("originalFilename");
				long size = p.getSize();
				
				dto.setSaveFilename(saveFilename);
				dto.setOriginalFilename(originalFilename);
				dto.setFileSize(size);
			}
			
			dao.insertNotice(dto);
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/notice/list.do");
		
	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		MyUtil util = new MyUtilBootstrap();
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long noticeNum = Long.parseLong(req.getParameter("noticeNum"));
			
			NoticeDTO dto = dao.readNotice(noticeNum);
			if(dto == null) {
				resp.sendRedirect(cp + "/notice/list.do?" + query);
				return;
			}
			
			dto.setContent(util.htmlSymbols(dto.getContent()));
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			
			forward(req, resp, "/WEB-INF/views/notice/article.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/notice/list.do?" + query);
		
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void deleteFile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

}
