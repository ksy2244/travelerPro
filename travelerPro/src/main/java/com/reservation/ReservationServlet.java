package com.reservation;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.ceo.CeoDAO;
import com.ceo.ServiceDTO;
import com.coupon.CouponDTO;
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
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

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

		// 객실 화면 - 객실, 지도, 리뷰
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

		// 업체 찜
		else if (uri.indexOf("insertCompanyLike.do") != -1) {
			insertCompanyLike(req, resp);
		}

		// 테스트
		else if (uri.indexOf("test.do") != -1) {
			test(req, resp);
		}

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
			int size = 8;
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
		CeoDAO cdao = new CeoDAO();
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

			// 캐러셀에 담을 객실 이미지 가져오기
			List<ReservationDTO> imgList = dao.roomImageList(companyNum);

			//
			String companyImg = dao.companyImg(companyNum);

			int count = dao.reviewCount(companyNum);

			// 사용자가 입력한 시작일, 종료일 찾기
			String start_date = req.getParameter("start_date");
			String end_date = req.getParameter("end_date");

			List<ServiceDTO> list = cdao.listCategory();
			req.setAttribute("list", list);

			roomDto.setStart_date(start_date);
			roomDto.setEnd_date(end_date);

			// 로그인 유저의 게시글 공감 여부
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			boolean isLike = dao.isUserCompanyLike(companyNum, info.getUserId());

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
			req.setAttribute("companyImg", companyImg);
			req.setAttribute("imgList", imgList);
			req.setAttribute("companyNum", companyNum);
			req.setAttribute("start_date", start_date);
			req.setAttribute("end_date", end_date);
			req.setAttribute("companyDto", companyDto);
			req.setAttribute("roomDto", roomDto);
			req.setAttribute("isUserLike", isLike);
			req.setAttribute("count", count);

			// 포워딩
			forward(req, resp, "/WEB-INF/views/reservation/roomInfo.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();

		}

		resp.sendRedirect(cp + "/reservation/companyList.do?");
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
			roomList = dao.listRoom(companyNum, start_date, end_date);

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

			String address = companyDto.getAddr();

			String companyName = companyDto.getCompanyName();
			String companyInfo = dao.map(companyNum);

			req.setAttribute("companyInfo", companyInfo);
			req.setAttribute("address", address);
			req.setAttribute("companyName", companyName);
			req.setAttribute("companyInfo", companyInfo);

			forward(req, resp, "/WEB-INF/views/reservation/map.jsp");
			return;
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	private void review(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩
		int companyNum = Integer.parseInt(req.getParameter("companyNum"));
		req.setAttribute("companyNum", companyNum);

		ReservationDAO dao = new ReservationDAO();
		double rate = dao.reviewStarRate(companyNum);

		req.setAttribute("rate", rate);

		forward(req, resp, "/WEB-INF/views/reservation/review.jsp");
		return;

	}

	private void test(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 포워딩

		forward(req, resp, "/WEB-INF/views/reservation/test.jsp");
		return;

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

			int gap = dao.reservationGap(start_date, end_date);

			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			// 선택한 객실 정보 가져오기
			ReserveRoomDTO dto = dao.listSelectRoom(roomNum);

			// 나의 사용 가능한 쿠폰 정보 가져오기
			List<CouponDTO> list = null;

			list = dao.listCoupon(info.getUserId());

			System.out.println(gap);

			int paymentPrice = dto.getRoomPrice();
			
			if(dto.getDiscountRate() != 0) {
				paymentPrice = paymentPrice - (paymentPrice * dto.getDiscountRate() /100);
			}

			req.setAttribute("gap", gap);
			req.setAttribute("dto", dto);
			req.setAttribute("paymentPrice", paymentPrice);
			req.setAttribute("start_date", start_date);
			req.setAttribute("end_date", end_date);
			req.setAttribute("companyNum", companyNum);
			req.setAttribute("list", list);

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
			int couponNum = Integer.parseInt(req.getParameter("couponNum"));

			// 결제 번호를 위한 문자열 파싱
			String start = String.join("", req.getParameter("start_date").split("-"));
			String[] endSplit = req.getParameter("end_date").split("-");
			String end = endSplit[1] + endSplit[2];

			// 예약 번호 = 예약 시작일 + 예약 종료일 + 업체 번호 + 객실 번호
			String reservationCode = start + end + Integer.toString(companyNum) + Integer.toString(roomNum);
			long reservationNum = (Long.parseLong(reservationCode));

			System.out.println(reservationNum + "dfsdfsdfsdfdsfsfsdfs");

			System.out.println("결제 번호");
			dto.setRoomNum(roomNum);
			dto.setReservationNum(reservationNum);
			System.out.println(dto.getReservationNum());

			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			dto.setRealHeadCount(Integer.parseInt(req.getParameter("headCount")));
			dto.setTotalPrice(Integer.parseInt(req.getParameter("totalPrice")));
			dto.setCheckInTime(req.getParameter("checkInTime"));
			dto.setCheckOutTime(req.getParameter("checkOutTime"));
			dto.setDiscountRate(Integer.parseInt(req.getParameter("discountRate")));
			dto.setPaymentPrice(Integer.parseInt(req.getParameter("paymentPrice")));
			dto.setUserId(info.getUserId());
			dto.setRealUserName(req.getParameter("realUserName"));
			dto.setRealUserTel(req.getParameter("realUserTel"));

			dao.insertReservation(dto);

			// 쿠폰 사용했다면 나의 쿠폰 테이블에 추가
			if (couponNum != 0) {
				dao.couponUse(couponNum, info.getUserId(), dto.getReservationNum());
			}

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

		String state = "false";
		int companyLikeCount = 0;

		try {
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));
			String isNoLike = req.getParameter("isNoLike");

			if (info == null) {
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			if (isNoLike.equals("true")) {
				dao.insertCompanyLike(companyNum, info.getUserId()); // 찜
			} else {
				dao.deleteCompanyLike(companyNum, info.getUserId()); // 찜 취소
			}

			companyLikeCount = dao.countCompanyLike(companyNum);

			state = "true";
		} catch (SQLException e) {
			state = "liked";
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