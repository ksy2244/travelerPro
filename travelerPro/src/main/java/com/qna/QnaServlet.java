package com.qna;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.answer.MemberADAO;
import com.answer.MemberADTO;
import com.member.SessionInfo;
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/qna/*")
@MultipartConfig
public class QnaServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) { // 로그인 되어 있지 않은 경우
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		if (uri.indexOf("list.do") != -1) {
			list(req, resp); // 글리스트
		} else if (uri.indexOf("write.do") != -1) {
			writeForm(req, resp); // 문의작성폼
		} else if (uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp); // 문의등록
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp); // 문의보기
		}  else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp); // 글삭제
		}

	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnaDAO dao = new QnaDAO();

		String cp = req.getContextPath();
		TravelUtil util = new TravelUtilBootstrap();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String userId = info.getUserId();

			int dataCount;
			
			dataCount = dao.dataCount(userId);
			

			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<QnaVO> list = dao.listQna(userId, offset, size);
			
			String listUrl = cp + "/qna/list.do";
			String articleUrl = cp + "/qna/article.do?page=" + current_page;
			
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

		forward(req, resp, "/WEB-INF/views/qna/list.jsp");
	}

	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnaDAO dao = new QnaDAO();
			
			List<QnaVO> list = dao.listCategory();
			req.setAttribute("list", list);
	
	
		req.setAttribute("mode", "write");
		forward(req, resp, "/WEB-INF/views/qna/write.jsp");
	}

	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnaDAO dao = new QnaDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/qna/list.do");
			return;
		}

		try {
			QnaVO dto = new QnaVO();
			
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setCategoryNum(Integer.parseInt(req.getParameter("categoryNum")));
			dto.setUserId(info.getUserId());
			
			dao.insertQna(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/qna/list.do");
	}

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnaDAO dao = new QnaDAO();
		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long questionNum = Long.parseLong(req.getParameter("questionNum"));
		
			QnaVO dto = dao.readQna(questionNum);
			if (dto == null) { 
				resp.sendRedirect(cp + "/qna/list.do?" + query);
				return;
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			
			MemberADAO adao = new MemberADAO();
			
				
			MemberADTO vo = adao.qnaList(questionNum);
				
			req.setAttribute("vo", vo);
				
			forward(req, resp, "/WEB-INF/views/qna/article.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/qna/list.do?" + query);
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			QnaDAO dao  = new QnaDAO();
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			String cp = req.getContextPath();
			
			String page = req.getParameter("page");
			String query = "page=" + page;
		
			try {
				long questionNum = Long.parseLong(req.getParameter("questionNum"));
				String condition = req.getParameter("condition");
				String keyword = req.getParameter("keyword");
				if (condition == null) {
					condition = "all";
					keyword = "";
				}
				keyword = URLDecoder.decode(keyword, "utf-8");

				if (keyword.length() != 0) {
					query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
				}
				
				QnaVO dto = dao.readQna(questionNum);
				if( dto == null) {
					resp.sendRedirect(cp + "/qna/list.do?" + query);
					return;
				}
				
				if (!info.getUserId().equals(dto.getUserId()) && !info.getUserId().equals("admin")) {
					resp.sendRedirect(cp + "/qna/list.do?" + query);
					return;
				}

				dao.deleteQna(questionNum, info.getUserId());	
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			resp.sendRedirect(cp + "/qna/list.do?" + query);
	}

}
