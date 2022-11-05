package com.answer;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

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
		} else if (uri.indexOf("faqWrite.do") != -1) {
			faqWriteForm(req, resp);
		} else if (uri.indexOf("faqWrite_ok.do") != -1) {
			faqWriteSubmit(req, resp);
		} else if (uri.indexOf("faqUpdate.do") != -1) {
			faqUpdateForm(req, resp);
		} else if (uri.indexOf("faqUpdate_ok.do") != -1) {
			faqUpdateSubmit(req, resp);
		} else if (uri.indexOf("faqDelete.do") != -1) {
			faqDelete(req, resp);
		} else if (uri.indexOf("qnaList.do") != -1) {
			qnaList(req, resp);
		} else if (uri.indexOf("qnaArticle.do") != -1) {
			qnaArticle(req, resp);
		} else if (uri.indexOf("qnaInsert.do") != -1) {
			qnaInsert(req, resp);
		} else if (uri.indexOf("qnaDto.do") != -1) {
			qnaDto(req, resp);
		} else if (uri.indexOf("qnaDelete.do") != -1) {
			qnaDelete(req, resp);
		}
	}

	protected void faq(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/answer/faq.jsp");
	}

	protected void faqList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();
		List<FaqDTO> list = null;
		try {
			int categoryNum = Integer.parseInt(req.getParameter("categoryNum"));

			if (categoryNum == 0) {
				list = dao.listFaq();
			} else {
				list = dao.listFaq(categoryNum);
			}

			for (FaqDTO dto : list) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			req.setAttribute("list", list);
			req.setAttribute("categoryNum", categoryNum);

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

	protected void faqWriteSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
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

	protected void faqUpdateForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();

		String cp = req.getContextPath();

		try {
			long faqNum = Long.parseLong(req.getParameter("faqNum"));
			FaqDTO dto = dao.readFaq(faqNum);

			if (dto == null) {
				resp.sendRedirect(cp + "/answer/faq.do");
				return;
			}

			req.setAttribute("dto", dto);
			req.setAttribute("submit", "수정");
			req.setAttribute("title", "faq 수정");
			req.setAttribute("mode", "faqUpdate");

			forward(req, resp, "/WEB-INF/views/answer/faqWrite.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/answer/faq.do");

	}

	protected void faqUpdateSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/answer/faq.do");
			return;
		}

		try {
			FaqDTO dto = new FaqDTO();

			dto.setFaqNum(Long.parseLong(req.getParameter("faqNum")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setCategoryNum(Integer.parseInt(req.getParameter("categoryNum")));

			dao.updateFaq(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/answer/faq.do");

	}

	protected void faqDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		FaqDAO dao = new FaqDAO();

		String cp = req.getContextPath();

		try {
			long faqNum = Long.parseLong(req.getParameter("faqNum"));

			FaqDTO dto = dao.readFaq(faqNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/answer/faq.do");
				return;
			}

			dao.deleteFaq(faqNum);

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
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			int dataCount = dao.qnaCount();

			int size = 10;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<QnaVO> list = dao.qnaList(offset, size);

			for (QnaVO dto : list) {
				dto.setContent(util.htmlSymbols(dto.getContent()));
			}

			String listUrl = cp + "/answer/qnaList.do";
			String articleUrl = cp + "/answer/qnaArticle.do?page=" + current_page;

			long gap;
			Date curDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			for (QnaVO dto : list) {
				Date date = sdf.parse(dto.getReg_date());
				gap = (curDate.getTime() - date.getTime()) / (1000 * 60 * 60 * 24); // 일자
				// gap = (curDate.getTime() - date.getTime()) / (1000 * 60 * 60); // 시간
				dto.setGap(gap);

				dto.setReg_date(dto.getReg_date().substring(0, 10));
			}

			String paging = util.paging(current_page, total_page, listUrl);

			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("paging", paging);
			req.setAttribute("articleUrl", articleUrl);

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/answer/qnaList.jsp");

	}

	protected void qnaArticle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberADAO dao = new MemberADAO();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long questionNum = Long.parseLong(req.getParameter("questionNum"));

			QnaVO dto = dao.qnaRead(questionNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/answer/qnaList.do");
				return;
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);

			forward(req, resp, "/WEB-INF/views/answer/qnaArticle.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/answer/qnaList.do?page=" + page);

	}

	protected void qnaInsert(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberADAO dao = new MemberADAO();

		String state = "false";
		try {
			MemberADTO dto = new MemberADTO();
			QnaVO vo = new QnaVO();

			dto.setContent(req.getParameter("content"));
			dto.setQuestionNum(Long.parseLong(req.getParameter("questionNum")));

			vo.setQuestionNum(Long.parseLong(req.getParameter("questionNum")));

			dao.insertQna(dto, vo);

			state = "true";

		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject job = new JSONObject();
		job.put("state", state);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}

	protected void qnaDto(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberADAO dao = new MemberADAO();

		String page = req.getParameter("page");

		try {
			long questionNum = Long.parseLong(req.getParameter("questionNum"));

			MemberADTO dto = dao.qnaList(questionNum);

			if (dto != null) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);

			forward(req, resp, "/WEB-INF/views/answer/qnaContent.jsp");
			return;

		} catch (Exception e) {
		}

		resp.sendError(400);

	}

	protected void qnaDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberADAO dao = new MemberADAO();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long questionNum = Long.parseLong(req.getParameter("questionNum"));
			long answerNum = Long.parseLong(req.getParameter("answerNum"));

			MemberADTO dto = dao.qnaList(questionNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/answer/qnaList.do?" + query);
				return;
			}

			dao.deleteAnswer(answerNum, questionNum);

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/answer/qnaList.do?" + query);

	}

}
