package com.reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.MemberDAO;
import com.member.MemberDTO;
import com.member.SessionInfo;
import com.util.TravelServlet;

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

		else if (uri.indexOf("roomDetailInfo.do") != -1) {
			roomDetailInfo(req, resp);
		}

		else if (uri.indexOf("reservation.do") != -1) {
			reservation(req, resp);
		}
	}

	// 객실 화면
	protected void roomInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/reservation/roomInfo.jsp");
	}

	// 객실 상세 화면
	protected void roomDetailInfo(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/reservation/roomDetailInfo.jsp");
	}

	// 예약 화면
	protected void reservation(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/reservation/reservation.jsp");
	}

}
