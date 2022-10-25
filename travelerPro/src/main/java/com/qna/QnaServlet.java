package com.qna;


import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;

import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/qna/*")
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
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp); // 문의수정폼
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp); // 수정등록
		} else if (uri.indexOf("deleteFile.do") != -1) {
			deleteFile(req, resp); // 수정에서 파일 삭제
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp); // 글삭제
		} else if (uri.indexOf("download.do") != -1) {
			download(req, resp); // 파일다운로드
		} else if (uri.indexOf("insertReply.do") != -1) {
			insertReply(req, resp); // 관리자 답글 등록
		} else if (uri.indexOf("listReply.do") != -1) {
			listReply(req, resp); // 댓글리스트
		} else if (uri.indexOf("deleteReply.do") != -1) {
			deleteReply(req, resp); // 댓글삭제
		} else if (uri.indexOf("insertReplyAnswer.do") != -1) {
			insertReplyAnswer(req, resp); // 댓글의 답글 등록
		} else if (uri.indexOf("listReplyAnswer.do") != -1) {
			listReplyAnswer(req, resp); // 댓글의 답글 리스트
		} else if (uri.indexOf("deleteReplyAnswer.do") != -1) {
			deleteReplyAnswer(req, resp); // 댓글 답글 삭제
		} else if (uri.indexOf("countReplyAnswer.do") != -1) {
			countReplyAnswer(req, resp); // 댓글의 답글 개수
		}

	}

	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnaDAO dao = new QnaDAO();
		
		String cp = req.getContextPath();
		TravelUtil util = new TravelUtilBootstrap();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if(condition == null) {
				condition = "all";
				keyword = "";
			}
			
			if(req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}

			int dataCount;
			if(keyword.length() == 0) {
				dataCount = dao.dataCount();
			} else {
				dataCount = dao.dataCount(condition, keyword);
			}
			
			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<QnaVO> list = null;
			if(keyword.length() == 0) {
				list = dao.listQna(offset, size);
			} else {
				list = dao.listQna(offset, size, condition, keyword);
			}
			
			String query = "";
			if(keyword.length() != 0) {
				query = "condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
			}
			
			String listUrl = cp + "/qna/list.do";
			String articleUrl = cp + "/qna/article.do?page="+current_page;
			if(query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			req.setAttribute("condition", condition);
			req.setAttribute("keyword", keyword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		forward(req, resp, "/WEB-INF/views/qna/list.jsp");
	}

	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				req.setAttribute("mode", "write");
				forward(req, resp, "/WEB-INF/views/qna/write.jsp");
	}

	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		QnaDAO dao = new QnaDAO();
		
		String cp = req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/qan/list.do");
			return;
		}
		
		try {
			QnaVO dto = new QnaVO();
			
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setUserId(req.getParameter("userId"));
			dto.setCategoryNum(Integer.parseInt(req.getParameter("categoryNum")));
			
			dao.insertQna(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/qna/list.do");
	}
	

	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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
	
	protected void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
	protected void listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}

	protected void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
	protected void insertReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
	protected void listReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
	protected void deleteReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
	protected void countReplyAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	}
	
	
}
