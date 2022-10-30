package com.more;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.answer.FaqDAO;
import com.answer.FaqDTO;
import com.notice.NoticeDAO;
import com.notice.NoticeDTO;
import com.util.FileManager;
import com.util.FileUploadServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@MultipartConfig
@WebServlet("/more/*")
public class MoreServlet extends FileUploadServlet {
	private static final long serialVersionUID = 1L;
	
	private String pathname;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		HttpSession session = req.getSession();
		
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "notice";
		
		if(uri.indexOf("faq.do") != -1) {
			faq(req, resp);
		} else if(uri.indexOf("faqList.do") != -1) {
			faqList(req, resp);
		} else if(uri.indexOf("notice.do") != -1) {
			notice(req, resp);
		} else if(uri.indexOf("noticeInfo.do") != -1) {
			noticeArticle(req, resp);
		} else if(uri.indexOf("download.do") != -1) {
			download(req, resp);
		}
		
	}
	
	protected void faq(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/more/faq.jsp");
	}
	
	protected void faqList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		List<FaqDTO> list = null;
		try {
			int categoryNum = Integer.parseInt(req.getParameter("categoryNum"));
			
			if(categoryNum == 0) {
				list = dao.listFaq();
			} else {
				list = dao.listFaq(categoryNum);
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
	
	protected void notice(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		TravelUtil util = new TravelUtilBootstrap();
		
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
			
			long gap;
			Date curDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			for (NoticeDTO dto : list) {
				Date date = sdf.parse(dto.getReg_date());
				gap = (curDate.getTime() - date.getTime()) / (1000*60*60*24); // 일자
				//gap = (curDate.getTime() - date.getTime()) / (1000 * 60 * 60); // 시간
				dto.setGap(gap);

				dto.setReg_date(dto.getReg_date().substring(0, 10));
			}
			
			String listUrl = cp + "/more/notice.do";
			String articleUrl = cp + "/more/noticeInfo.do?page=" + current_page;
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		forward(req, resp, "/WEB-INF/views/more/notice.jsp");
	}
	
	protected void noticeArticle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		//MyUtil util = new MyUtilBootstrap();
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long noticeNum = Long.parseLong(req.getParameter("noticeNum"));
			
			NoticeDTO dto = dao.readNotice(noticeNum);
			if(dto == null) {
				resp.sendRedirect(cp + "/more/notice.do?" + query);
				return;
			}
			
			//dto.setContent(util.htmlSymbols(dto.getContent()));
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			
			forward(req, resp, "/WEB-INF/views/more/noticeInfo.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/more/notice.do?" + query);
		
	}
	
	protected void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NoticeDAO dao = new NoticeDAO();
		boolean b = false;
		
		try {
			long noticeNum = Long.parseLong(req.getParameter("noticeNum"));
			NoticeDTO dto = dao.readNotice(noticeNum);
			if(dto != null) {
				b = FileManager.doFiledownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(!b) {
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패했습니다.');history.back();</script>");
		}
	}
	
	

}
