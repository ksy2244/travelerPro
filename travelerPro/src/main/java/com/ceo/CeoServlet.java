package com.ceo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.TravelServlet;

@WebServlet("/ceo/*")
public class CeoServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();

		// uri에 따른 작업 구분
		if (uri.indexOf("main.do") != -1) {
			list(req, resp);
		}  else if (uri.indexOf("write.do") != -1) {
			writeForm(req, resp);
		}  else if (uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		}  else if (uri.indexOf("paylist.do") != -1) {
			payList(req, resp);
		} else if (uri.indexOf("room.do") != -1) {
			room(req, resp);
		}  else if (uri.indexOf("reservation.do") != -1) {
			reservation(req, resp);
		}  else if (uri.indexOf("recognition.do") != -1) {
			recognition(req, resp);
		}
	}
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/ceo/main.jsp");
	}
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/ceo/write.jsp");
	}
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	protected void payList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/ceo/paylist.jsp");
	}
	protected void room(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	protected void reservation(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/ceo/reservation.jsp");
	}
	protected void recognition(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/ceo/recognition.jsp");
	}

}
