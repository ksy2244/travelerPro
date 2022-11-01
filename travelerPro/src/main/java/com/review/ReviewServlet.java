package com.review;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.member.SessionInfo;
import com.reservation.ReservationDAO;
import com.reservation.ReservationDTO;
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/review/*")
public class ReviewServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		// 세션 정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		// 리뷰 추가
		if (uri.indexOf("insertReview.do") != -1) {
			insertReview(req, resp);
		}

		// 리뷰 리스트
		else if (uri.indexOf("listReview.do") != -1) {
			listReview(req, resp);
		}

		// 리뷰 삭제
		else if (uri.indexOf("deleteReview.do") != -1) {
			deleteReview(req, resp);

		}
		// 리뷰
		else if (uri.indexOf("review.do") != -1) {
			review(req, resp);
		}

		// 나의 리뷰
		else if (uri.indexOf("myReview.do") != -1) {
			myReview(req, resp);
		}

	}

	private void review(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩

		forward(req, resp, "/WEB-INF/views/reservation/review.jsp");
		return;

	}

	private void insertReview(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		ReviewDAO dao = new ReviewDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String state = "false";
		long reservationNum = 0;

		try {
			ReviewDTO dto = new ReviewDTO();

			int companyNum = Integer.parseInt(req.getParameter("companyNum"));

			System.out.println(companyNum);
			int checkRoll = dao.checkRoll(companyNum, info.getUserId());
			
			System.out.println(checkRoll);
			if(checkRoll <=0 ) {
				return;
			}

			dto.setUserId(info.getUserId());
			dto.setContent(req.getParameter("content"));
			dto.setStarRate(Integer.parseInt(req.getParameter("star")));
			dto.setCompanyNum(Integer.parseInt(req.getParameter("companyNum")));

			dao.insertReview(dto);

			System.out.println(dto.getReservationNum());

			state = "true";

		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject job = new JSONObject();
		job.put("state", state);
		job.put("reservationNum", reservationNum);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());

	}

	// 리뷰 삭제 - AJAX:JSON
	private void deleteReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ReviewDAO dao = new ReviewDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String state = "false";

		try {
			int reviewNum = Integer.parseInt(req.getParameter("reviewNum"));
			System.out.println(reviewNum);
			dao.deleteReview(reviewNum, info.getUserId());

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

	private void listReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ReviewDAO dao = new ReviewDAO();
		TravelUtil util = new TravelUtilBootstrap();
		int reviewCount = 0;
		try {

			int companyNum = Integer.parseInt(req.getParameter("companyNum"));

			String pageNo = req.getParameter("pageNo");

			int current_page = 1;
			if (pageNo != null) {
				current_page = Integer.parseInt(pageNo);
			}

			int size = 5;
			int total_page = 0;
			int replyCount = 0;

			reviewCount = dao.dataCountReview(companyNum);
			total_page = util.pageCount(replyCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			// 리스트에 출력할 데이터
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<ReviewDTO> listReview = dao.listReview(companyNum, offset, size);

			// 엔터를 <br>
			for (ReviewDTO dto : listReview) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}

			// 페이징 처리 : AJAX 용 - listPage : 자바스크립트 함수명
			String paging = util.pagingMethod(current_page, total_page, "listPage");

			req.setAttribute("listReview", listReview);
			req.setAttribute("pageNo", current_page);
			req.setAttribute("reviewCount", reviewCount);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);

			forward(req, resp, "/WEB-INF/views/reservation/listReview.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendError(400);

	}

	private void myReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩
		ReviewDAO dao = new ReviewDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();

		req.setCharacterEncoding("utf8");

		try {

			List<ReviewDTO> list = null;

			if (info == null) {

				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			list = dao.myReviewList(info.getUserId());
			System.out.println(info.getUserId());

			// JSP로 전달할 속성
			req.setAttribute("list", list);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/myReview.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
