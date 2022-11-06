package com.mypage;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coupon.CouponDTO;
import com.member.SessionInfo;
import com.reservation.ReservationDTO;
import com.reservation.ReserveCompanyDTO;
import com.review.ReviewDTO;
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/mypage/*")
public class MypageServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		req.setCharacterEncoding("utf-8");

		// 세션 정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) { // 로그인 되어 있지 않은 경우
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		if (uri.indexOf("coupon.do") != -1) {
			coupon(req, resp);
		} else if (uri.indexOf("couponInfo.do") != -1) {
			couponInfo(req, resp);
		}

		else if (uri.indexOf("alarm.do") != -1) {
			alarm(req, resp);
		}

		else if (uri.indexOf("pick.do") != -1) {
			pick(req, resp);
		}
		// 나의 예약 정보
		else if (uri.indexOf("myReservation.do") != -1) {
			myReservation(req, resp);
		}

		// 예약 상세 정보
		else if (uri.indexOf("reservationDetail.do") != -1) {
			reservationDetail(req, resp);
		}

		// 나의 리뷰
		else if (uri.indexOf("myReview.do") != -1) {
			myReview(req, resp);
		}

	}

	protected void coupon(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MypageDAO dao = new MypageDAO();
		TravelUtil util = new TravelUtilBootstrap();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();

		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			System.out.print(info.getUserId());

			int dataCount = dao.dataCount(info.getUserId());

			int size = 9;
			int total_page = util.pageCount(dataCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<CouponDTO> list = dao.myPageCoupon(info.getUserId(), offset, size);

			String listUrl = cp + "/mypage/coupon.do";
			String articleUrl = cp + "/mypage/couponInfo.do?page=" + current_page;

			String paging = util.paging(current_page, total_page, listUrl);

			long gap;
			Date curDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (CouponDTO dto : list) {
				Date date = sdf.parse(dto.getEnd_date());
				gap = (date.getTime() - curDate.getTime()) / (1000 * 60 * 60 * 24);
				dto.setGap(gap);

				dto.setEnd_date(dto.getEnd_date().substring(0, 10));
			}

			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);

		} catch (Exception e) {
			e.printStackTrace();
		}
		forward(req, resp, "/WEB-INF/views/mypage/coupon.jsp");
	}

	protected void couponInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MypageDAO dao = new MypageDAO();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			long couponNum = Long.parseLong(req.getParameter("couponNum"));

			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			CouponDTO dto = dao.myPageReadCoupon(couponNum, info.getUserId());

			if (dto == null) {
				resp.sendRedirect(cp + "/mypage/coupon.do?page=" + page);
				return;
			}

			dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));

			long gap;
			Date curDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			Date date = sdf.parse(dto.getEnd_date());
			gap = (date.getTime() - curDate.getTime()) / (1000 * 60 * 60 * 24);
			dto.setGap(gap);

			dto.setEnd_date(dto.getEnd_date().substring(0, 10));

			req.setAttribute("query", query);
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);

			forward(req, resp, "/WEB-INF/views/mypage/couponInfo.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/mypage/coupon.do?page=" + page);

	}

	protected void alarm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/mypage/alarm.jsp");
	}

	protected void pick(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MypageDAO dao = new MypageDAO();
		TravelUtil util = new TravelUtilBootstrap();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();

		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			System.out.print(info.getUserId());

			int dataPickCount = dao.dataPickCount(info.getUserId());

			int size = 9;
			int total_page = util.pageCount(dataPickCount, size);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<ReserveCompanyDTO> list = dao.myPickList(info.getUserId(), offset, size);

			String listUrl = cp + "/mypage/pick.do";
			// String articleUrl = cp + "/mypage/couponInfo.do?page=" + current_page;

			String paging = util.paging(current_page, total_page, listUrl);

			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("dataCount", dataPickCount);

			req.setAttribute("paging", paging);

		} catch (Exception e) {
			e.printStackTrace();
		}
		forward(req, resp, "/WEB-INF/views/mypage/pick.jsp");
	}

	private void myReservation(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩
		MypageDAO dao = new MypageDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();

		req.setCharacterEncoding("utf8");

		try {

			List<ReservationDTO> list = null;

			if (info == null) {
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			System.out.println(info.getUserId());
			list = dao.myReseravationList(info.getUserId());
			int dataCount = dao.myReservationCount(info.getUserId());

			// JSP로 전달할 속성
			req.setAttribute("list", list);
			req.setAttribute("dataCount", dataCount);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/mypage/myReservation.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void reservationDetail(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		MypageDAO dao = new MypageDAO();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();
		System.out.println("reservationDatail00");

		req.setCharacterEncoding("utf8");

		try {

			System.out.println("reservationDatail");

			if (info == null) {
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}
			

			long reservationNum = Long.parseLong(req.getParameter("reservationNum"));

			// System.out.println(info.getUserId());
			ReservationDTO dto = new ReservationDTO();
			
			if(dao.reservationDetailCoupon(info.getUserId(), reservationNum) == reservationNum) {
				dto = dao.reservationDetailNoCoupon(reservationNum);
			} else {
				dto = dao.reservationDetail(reservationNum);
			}
			
			
			System.out.println(reservationNum);

			// JSP로 전달할 속성
			req.setAttribute("dto", dto);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/mypage/reservationDatail.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void myReview(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩
		MypageDAO dao = new MypageDAO();
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

			int dataCount = dao.myReviewCount(info.getUserId());

			// JSP로 전달할 속성
			req.setAttribute("list", list);
			req.setAttribute("dataCount", dataCount);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/mypage/myReview.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}