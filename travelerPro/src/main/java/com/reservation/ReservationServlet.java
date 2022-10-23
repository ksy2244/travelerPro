package com.reservation;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
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

@WebServlet("/reservation/*")
public class ReservationServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;
	 // 체크인/체크아웃 날짜를 전달하기 위한 객체
	ReservationDTO dateDto = new ReservationDTO();

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		// 숙박업체 리스트 화면
		if (uri.indexOf("companyList.do") != -1) {
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
			reservationForm(req, resp);
		}

		// 예약 완료 화면
		else if (uri.indexOf("reservation_ok.do") != -1) {
			reservationSubmit(req, resp);
		}
	}

	// 객실 상세 화면
	protected void roomDetailInfo(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// 객실 목록에서 예약할 객실을 선택한 화면
		ReservationDAO dao = new ReservationDAO();
		String cp = req.getContextPath();
		try {
			int roomNum = Integer.parseInt(req.getParameter("roomNum"));

			// 게시물 가져오기
			List<ReserveRoomDTO> list = null;
			list = dao.listSelectRoom(roomNum);

			// JSP로 전달할 속성
			req.setAttribute("list", list);
			req.setAttribute("dateDto", dateDto);
			req.setAttribute("mode", "reservation");

			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/roomDetailInfo.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/reservation/roomInfo.jsp");

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
			String articleUrl = cp + "/reservation/roomInfo.do?page=" + current_page;
			if (query.length() != 0) {
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}

			String paging = util.paging(current_page, total_page, listUrl);

			// 포워딩할 JSP에 전달할 속성
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

	protected void roomInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 숙박업체리스트에서 클릭한 화면
		ReservationDAO dao = new ReservationDAO();
		String cp = req.getContextPath();
		req.setCharacterEncoding("utf8");
		resp.setCharacterEncoding("utf8");

		try {
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));
			// 게시물 가져오기
			List<ReserveRoomDTO> list = null;

			list = dao.listRoom(companyNum);
			
			String start_date = req.getParameter("start_date");
			String end_date = req.getParameter("end_date");
			dateDto.setStart_date(start_date);
			dateDto.setEnd_date(end_date);
			
			// JSP로 전달할 속성
			req.setAttribute("list", list);
			req.setAttribute("start_date", start_date);
			req.setAttribute("end_date", end_date);
			req.setAttribute("companyNum", companyNum);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/roomInfo.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();

		}

		resp.sendRedirect(cp + "/reservation/companyList.do?");
	}


	private void reservationForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ReservationDAO dao = new ReservationDAO();
		String cp = req.getContextPath();
		try {
			int roomNum = Integer.parseInt(req.getParameter("roomNum")); // 게시물가져오기
			List<ReserveRoomDTO> list = null;
			list = dao.listSelectRoom(roomNum);

			// JSP로 전달할 속성
			req.setAttribute("list", list);
			req.setAttribute("title", "예약");
			req.setAttribute("list", list);
			req.setAttribute("mode", "reservation");
			req.setAttribute("dateDto", dateDto);
			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/reservation.jsp");

			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/reservation/roomInfo.jsp");

	}

	// 예약 완료
	protected void reservationSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ReservationDAO dao = new ReservationDAO();
		String cp = req.getContextPath();
		String message = "";
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("reservation");
		ReservationDTO dto = new ReservationDTO();

		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/");
			return;
		}

		try {

			int roomNum = Integer.parseInt(req.getParameter("roomNum"));
			// 게시물 가져오기
			List<ReserveRoomDTO> list = null;
			list = dao.listSelectRoom(roomNum);

			// JSP로 전달할 속성
			req.setAttribute("list", list);

			dto.setReservationNum(Integer.parseInt((req.getParameter("roomNum"))));
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			dto.setRealHeadCount((Integer.parseInt(req.getParameter("realHeadCount"))));
			dto.setTotalPrice((Integer.parseInt(req.getParameter("totalPrice"))));
			dto.setCheckInTime(req.getParameter("checkInTime"));
			dto.setCheckOutTime(req.getParameter("checkOutTime"));
			dto.setStatus(req.getParameter("status"));
			dto.setDiscountPrice((Integer.parseInt(req.getParameter("discountPrice"))));
			dto.setPaymentPrice((Integer.parseInt(req.getParameter("paymentPrice"))));
			dto.setUserId(info.getUserId());
			dto.setReservation_date((req.getParameter("reservation_date").replaceAll("(\\.|\\-|\\/)", "")));
			dto.setCouponPrice((Integer.parseInt(req.getParameter("couponPrice"))));
			dto.setRealUserName(req.getParameter("realUserName"));
			dto.setRealUserTel(req.getParameter("realUserTel"));

			dao.insertReservation(dto);

			forward(req, resp, "/WEB-INF/views/reservation/reservation.jsp");
			return;

		} catch (SQLException e) {
			if (e.getErrorCode() == 1)
				message = "예약 번호 중복으로 예약에 실패했습니다 ";
			else if (e.getErrorCode() == 1400)
				message = "필수 사항을 입력하지 않았습니다.";
			else if (e.getErrorCode() == 1840 || e.getErrorCode() == 1861)
				message = "날짜 형식이 일치하지 않습니다.";
			else
				message = "예약에 실패 했습니다.";

		} catch (Exception e) {
			message = "예약에 실패 했습니다..";
			e.printStackTrace();
		}

		req.setAttribute("title", "예약");
		req.setAttribute("dto", dto);
		req.setAttribute("dateDto", dateDto);
		req.setAttribute("mode", "reservation");
		req.setAttribute("message", message);
		forward(req, resp, "/WEB-INF/views/reservation/roomInfo.jsp");
	}

}
