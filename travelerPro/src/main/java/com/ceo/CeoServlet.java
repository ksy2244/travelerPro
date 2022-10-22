package com.ceo;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.TravelServlet;
import com.util.TravelUtil;

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
		}  else if (uri.indexOf("recognition_ok.do") != -1) {
			recognitionSubmit(req, resp);
		}  else if (uri.indexOf("paylist.do") != -1) {
			payList(req, resp);
		}  else if (uri.indexOf("room.do") != -1) {
			room(req, resp);
		}  else if (uri.indexOf("reservation.do") != -1) {
			reservation(req, resp);
		}  else if (uri.indexOf("recognition.do") != -1) {
			recognition(req, resp);
		} else if (uri.indexOf("article.do") != -1) {
			article(req, resp);
		}
	}
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		TravelUtil util = new TravelUtil();
		
		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount();
			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			
			int offset = (current_page -1) *size;
			if(offset <0) offset = 0;
			List<CeoDTO> list =dao.listCeo(offset, size);
			String listUrl = cp + "/ceo/main.do";
			String articleUrl = cp + "/ceo/article.do?page=" + current_page;
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		forward(req, resp, "/WEB-INF/views/ceo/main.jsp");
	}
	protected void recognitionSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		String cp = req.getContextPath();
		try {
			CeoDTO dto = new CeoDTO();
			dto.setCompanyName(req.getParameter("companyName"));
			dto.setBusinessNum(req.getParameter("businessNum1")+"-"+req.getParameter("businessNum2")+"-"+req.getParameter("businessNum3"));
			dto.setUserId(req.getParameter("userId"));
			if(req.getParameter("regionName").equals("강원도")) {
				dto.setRegionNum(1);
			}
			dto.setCheckinTime(req.getParameter("checkinTime"));
			dto.setCheckoutTime(req.getParameter("checkoutTime"));
			dto.setCompanyTel(req.getParameter("tel1")+"-"+req.getParameter("tel2")+"-"+req.getParameter("tel3"));
			dto.setZip(req.getParameter("zip"));
			dto.setAddr(req.getParameter("addr1"));
			dto.setAddrDetail(req.getParameter("addr2"));
			dto.setCompanyInfo(req.getParameter("companyInfo"));
			dto.setAmenities(req.getParameter("amenities"));
			dto.setGuide(req.getParameter("guide"));
			dto.setNotice(req.getParameter("notice"));
			
			dao.insertCeo(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+"/ceo/main.do");
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
		req.setAttribute("mode", "recognition");
	}
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page="+page;
		try {
			int num = Integer.parseInt(req.getParameter("companyNum"));
			CeoDTO dto = dao.readCto(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/ceo/main.do?"+query);
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			
			forward(req, resp, "/WEB-INF/views/ceo/article.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(req.getParameter("companyNum"));
		}
		resp.sendRedirect(cp + "/ceo/main.do?" + query);
	}
	

}
