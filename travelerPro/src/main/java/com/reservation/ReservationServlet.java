package com.reservation;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/reservation/*")
public class ReservationServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();
		if (uri.indexOf("roomInfo.do") != -1) {
			roomInfo(req, resp);
		}

		// 숙박업체 리스트 화면
		else if (uri.indexOf("companyList.do") != -1) {
			companyList(req, resp);
		}

		// 객실 화면 (업체 선택 후 나오는 화면)
		else if (uri.indexOf("roomInfo.do") != -1) {
			roomInfo(req, resp);
		}

		// 객실 상세 화면 (객실 선택 후 볼 수 있는 화면)
		else if (uri.indexOf("roomDetailInfo.do") != -1) {
			roomDetailInfo(req, resp);
		}

		// 예약 화면(이용자 이름, 이용자 전화번호 받는 화면)
		else if (uri.indexOf("reservation.do") != -1) {
			reservation(req, resp);
		}
	}

	
	// 객실 상세 화면
	protected void roomDetailInfo(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/reservation/roomDetailInfo.jsp");
	}

	// 예약 화면
	protected void reservation(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/reservation/reservation.jsp");
	}

	protected void companyList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 숙박업체 리스트
		ReservationDAO dao = new ReservationDAO();
		TravelUtil util = new TravelUtilBootstrap();

		String cp = req.getContextPath();

		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			// 검색
			String condition = req.getParameter("condition");
			String keyword = req.getParameter("keyword");
			if (condition == null) {
				condition = "all";
				keyword = "";
			}

			// GET 방식인 경우 디코딩
			if (req.getMethod().equalsIgnoreCase("GET")) {
				keyword = URLDecoder.decode(keyword, "utf-8");
			}

			// 전체 데이터 개수
			int dataCompanyCount;
			if (keyword.length() == 0) {
				dataCompanyCount = dao.dataCompanyCount();
			} else {
				dataCompanyCount = dao.dataCompanyCount(condition, keyword);
			}

			// 전체 페이지 수
			int size = 10;
			int total_page = util.pageCount(dataCompanyCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			// 게시물 가져오기
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<ReserveCompanyDTO> list = null;
			if (keyword.length() == 0) {
				list = dao.listCompany(offset, size);
			} else {
				// list = dao.listCompany(offset, size, condition, keyword);
			}

			String query = "";
			if (keyword.length() != 0) {
				query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
			}

			// 페이징 처리
			String listUrl = cp + "/reservation/companyList.do";
			String articleUrl = cp + "/reservation/companyList.do?page=" + current_page;
			if (query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}

			String paging = util.paging(current_page, total_page, listUrl);

			// 포워딩할 JSP에 전달할 속성
			// req.setAttribute("dto", dto);

			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCompanyCount", dataCompanyCount);
			req.setAttribute("size", size);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			req.setAttribute("condition", condition);
			req.setAttribute("keyword", keyword);

		} catch (Exception e) {
			e.printStackTrace();
		}

		// JSP로 포워딩
		forward(req, resp, "/WEB-INF/views/reservation/companyList.jsp");
	}

	/*
	 * 
	 * protected void companyList(HttpServletRequest req, HttpServletResponse resp)
	 * throws ServletException, IOException { // 숙박업체 리스트 ReservationDAO dao = new
	 * ReservationDAO(); TravelUtil util = new TravelUtilBootstrap();
	 * 
	 * String cp = req.getContextPath();
	 * 
	 * try { String page = req.getParameter("page"); int current_page = 1; if (page
	 * != null) { current_page = Integer.parseInt(page); }
	 * 
	 * // 검색 String condition = req.getParameter("condition"); String keyword =
	 * req.getParameter("keyword"); if (condition == null) { condition = "all";
	 * keyword = ""; }
	 * 
	 * // GET 방식인 경우 디코딩 if (req.getMethod().equalsIgnoreCase("GET")) { keyword =
	 * URLDecoder.decode(keyword, "utf-8"); }
	 * 
	 * // 전체 데이터 개수 int dataCount; if (keyword.length() == 0) { dataCount =
	 * dao.dataCount(); } else { dataCount = dao.dataCount(condition, keyword); }
	 * 
	 * // 전체 페이지 수 int size = 10; int total_page = util.pageCount(dataCount, size);
	 * if (current_page > total_page) { current_page = total_page; }
	 * 
	 * // 게시물 가져오기 int offset = (current_page - 1) * size; if (offset < 0) offset =
	 * 0;
	 * 
	 * List<ReservationDTO> list = null; if (keyword.length() == 0) { list =
	 * dao.listRoom(offset, size); } else { list = dao.listRoom(offset, size,
	 * condition, keyword); }
	 * 
	 * String query = ""; if (keyword.length() != 0) { query = "condition=" +
	 * condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8"); }
	 * 
	 * // 페이징 처리 String listUrl = cp + "/reservation/companyList.do"; String
	 * articleUrl = cp + "/reservation/companyList.do?page=" + current_page; if
	 * (query.length() != 0) { listUrl += "?" + query; articleUrl += "&" + query; }
	 * 
	 * String paging = util.paging(current_page, total_page, listUrl);
	 * 
	 * // 포워딩할 JSP에 전달할 속성 // req.setAttribute("dto", dto);
	 * 
	 * req.setAttribute("list", list); req.setAttribute("page", current_page);
	 * req.setAttribute("total_page", total_page); req.setAttribute("dataCount",
	 * dataCount); req.setAttribute("size", size); req.setAttribute("articleUrl",
	 * articleUrl); req.setAttribute("paging", paging);
	 * req.setAttribute("condition", condition); req.setAttribute("keyword",
	 * keyword);
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * // JSP로 포워딩 forward(req, resp, "/WEB-INF/views/reservation/companyList.jsp");
	 * }
	 * 
	 */
	protected void roomInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 숙박업체리스트에서 클릭한 화면
		ReservationDAO dao = new ReservationDAO();
		TravelUtil util = new TravelUtilBootstrap();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));
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

			// 게시물 가져오기
			ReserveCompanyDTO dto = dao.readCompany(companyNum);
			if (dto == null) { // 게시물이 없으면 다시 리스트로
				resp.sendRedirect(cp + "/reservation/roomInfo.do?" + query);
				return;
			}

			// JSP로 전달할 속성
			req.setAttribute("dto", dto);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/roomInfo.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/reservation/roomInfo.do?" + query);
	}
}
