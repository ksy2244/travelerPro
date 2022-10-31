package com.reservation;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.member.SessionInfo;
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

		// 세션 정보

		// 숙박업체 리스트 화면
		if (uri.indexOf("companyList.do") != -1) {
			companyList(req, resp);
		}

		// 객실 화면 (업체 선택 후 나오는 화면)
		else if (uri.indexOf("roomInfo.do") != -1) {
			roomInfo(req, resp);
		}

		// 예약 화면(이용자 이름, 이용자 전화번호 받는 화면)
		else if (uri.indexOf("reservation.do") != -1) {
			reservationForm(req, resp);
		}

		// 예약 완료 화면
		else if (uri.indexOf("reservation_ok.do") != -1) {
			reservationSubmit(req, resp);
		}

		// 룸 정보 - 객실, 지도, 리뷰
		else if (uri.indexOf("roomList.do") != -1) {
			// 객실
			roomList(req, resp);
		}

		else if (uri.indexOf("map.do") != -1) {
			// 지도
			map(req, resp);
		}

		else if (uri.indexOf("review.do") != -1) {
			// 리뷰 보기 및 작성
			review(req, resp);
		}

		else if (uri.indexOf("myReservation.do") != -1) {
			myReservation(req, resp);
		}

		else if (uri.indexOf("insertCompanyLike.do") != -1) {
			// 공감 저장
			insertCompanyLike(req, resp);
		}

		// 결제 테스트
		else if (uri.indexOf("test.do") != -1) {
			test(req, resp);
		}

	}

	private void roomList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ReservationDAO dao = new ReservationDAO();

		req.setCharacterEncoding("utf8");

		try {
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));
			String start_date = req.getParameter("start_date");
			String end_date = req.getParameter("end_date");

			List<ReserveRoomDTO> roomList = null;

			// 선택한 업체의 객실 정보
			roomList = dao.listRoom(companyNum);

			System.out.println("dff" + start_date);
			System.out.println("dff" + end_date);

			// JSP로 전달할 속성
			req.setAttribute("companyNum", companyNum);
			req.setAttribute("roomList", roomList);
			req.setAttribute("start_date", start_date);
			req.setAttribute("end_date", end_date);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/roomList.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendError(400);

	}

	private void map(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩
		req.setCharacterEncoding("utf8");
		try {
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));

			ReserveCompanyDTO companyDto = new ReserveCompanyDTO();

			ReservationDAO dao = new ReservationDAO();
			companyDto = dao.readCompany(companyNum);

			String addr = companyDto.getAddr();
			String addrDetail = companyDto.getAddrDetail();
			String companyName = companyDto.getCompanyName();

			String address = addr + " " + addrDetail;

			req.setAttribute("address", address);
			req.setAttribute("companyName", companyName);

			forward(req, resp, "/WEB-INF/views/reservation/map.jsp");
			return;
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	private void myReservation(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩
		ReservationDAO dao = new ReservationDAO();
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

			// JSP로 전달할 속성
			req.setAttribute("list", list);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/myReservation.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendError(400);

	}

	private void review(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩
		int companyNum = Integer.parseInt(req.getParameter("companyNum"));
		req.setAttribute("companyNum", companyNum);

		forward(req, resp, "/WEB-INF/views/reservation/review.jsp");
		return;

	}

	private void test(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩

		forward(req, resp, "/WEB-INF/views/reservation/test.jsp");
		return;

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
			int dataCompanyCount = dao.dataCount();

			if (keyword.length() == 0) {
				dataCompanyCount = dao.dataCount();
			} else {
				// dataCompanyCount = dao.dataCompanyCount(condition, keyword);
			}

			// 전체 페이지 수
			int size = 5;
			int total_page = util.pageCount(dataCompanyCount, size);
			System.out.println("dd" + total_page);
			if (current_page > total_page) {
				current_page = total_page;
			}

			// 게시물 가져오기
			int offset = (current_page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<ReserveCompanyDTO> list = null;
			if (keyword.length() == 0) {
				list = dao.listCompany();

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

		try {
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));

			ReserveCompanyDTO companyDto = new ReserveCompanyDTO();
			ReserveRoomDTO roomDto = new ReserveRoomDTO();

			// 업체 정보 가져오기
			companyDto = dao.readCompany(companyNum);

			// 선택한 업체의 객실 정보
			roomDto.setCompanyNum(companyNum);

			// 사용자가 입력한 시작일, 종료일 찾기
			String start_date = req.getParameter("start_date");
			String end_date = req.getParameter("end_date");

			roomDto.setStart_date(start_date);
			roomDto.setEnd_date(end_date);

			// 이용 시작일, 종료일 초기값 설정
			if (start_date == null || end_date == null) {

				Calendar cal = Calendar.getInstance();
				String format = "yyyy-MM-dd";
				SimpleDateFormat sdf = new SimpleDateFormat(format);
				start_date = sdf.format(cal.getTime());

				cal.add(Calendar.DATE, +1); // 내일 날짜
				end_date = sdf.format(cal.getTime());

			}

			roomDto.setStart_date(start_date);
			roomDto.setEnd_date(end_date);

			// JSP로 전달할 속성
			req.setAttribute("companyNum", companyNum);
			req.setAttribute("start_date", start_date);
			req.setAttribute("end_date", end_date);
			req.setAttribute("companyDto", companyDto);
			req.setAttribute("roomDto", roomDto);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/roomInfo.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();

		}

		resp.sendRedirect(cp + "/reservation/companyList.do?");
	}

	// 예약 폼 화면
	private void reservationForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ReservationDAO dao = new ReservationDAO();
		try {
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));

			int roomNum = Integer.parseInt(req.getParameter("roomNum"));

			String start_date = req.getParameter("start_date");
			String end_date = req.getParameter("end_date");

			// 선택한 객실 정보 가져오기
			ReserveRoomDTO dto = dao.listSelectRoom(roomNum);

			int paymentPrice = 0;
			// 금액 게산
			int sale = (int) (dto.getRoomPrice() * (dto.getDiscountRate() / 100.0));

			paymentPrice = dto.getRoomPrice() - sale;

			// JSP로 전달할 속성
			req.setAttribute("dto", dto);
			req.setAttribute("paymentPrice", paymentPrice);
			req.setAttribute("start_date", start_date);
			req.setAttribute("end_date", end_date);
			req.setAttribute("companyNum", companyNum);

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
		ReservationDTO dto = new ReservationDTO();

		String message = "";
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		try {
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));
			int roomNum = Integer.parseInt(req.getParameter("roomNum"));

			// 예약 번호 = 오늘(예약일) + 업체 번호 + 객실 번호
			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
			String today = now.format(formatter);
			String reservationCode = today + Integer.toString(companyNum) + Integer.toString(roomNum);
			long reservationNum = Long.parseLong(reservationCode);

			dto.setRoomNum(roomNum);
			dto.setReservationNum(reservationNum);
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			dto.setRealHeadCount(Integer.parseInt(req.getParameter("headCount")));
			dto.setTotalPrice(Integer.parseInt(req.getParameter("totalPrice")));
			dto.setCheckInTime(req.getParameter("checkInTime"));
			dto.setCheckOutTime(req.getParameter("checkOutTime"));
			dto.setDiscountPrice(Integer.parseInt(req.getParameter("discountRate")));
			dto.setPaymentPrice(Integer.parseInt(req.getParameter("paymentPrice")));
			dto.setUserId(info.getUserId());
			dto.setRealUserName(req.getParameter("realUserName"));
			dto.setRealUserTel(req.getParameter("realUserTel"));

			dao.insertReservation(dto);

			ReserveRoomDTO sdto = dao.listSelectRoom(roomNum);

			// JSP로 전달할 속성
			req.setAttribute("dto", dto);
			req.setAttribute("sdto", sdto);

			forward(req, resp, "/WEB-INF/views/reservation/reservation_ok.jsp");
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

		req.setAttribute("message", message);
		forward(req, resp, "/WEB-INF/views/reservation/reservation.jsp");
	}

	protected void insertCompanyLike(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		ReservationDAO dao = new ReservationDAO();

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();

		System.out.println("insertCompanyLike");
		String state = "false";
		int companyLikeCount = 0;

		try {

			if (info == null) {
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			int companyNum = Integer.parseInt(req.getParameter("companyNum"));

			String isNoLike = req.getParameter("isNoLike");

			if (isNoLike.equals("true")) {
				dao.insertCompanyLike(companyNum, info.getUserId()); // 공감
			} else {
				dao.deleteCompanyLike(companyNum, info.getUserId()); // 공감 취소
			}

			companyLikeCount = dao.countCompanyLike(companyNum);

			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject job = new JSONObject();
		job.put("state", state);
		job.put("companyLikeCount", companyLikeCount);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
}