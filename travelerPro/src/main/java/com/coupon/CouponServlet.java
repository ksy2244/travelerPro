package com.coupon;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.notice.NoticeDTO;
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;


@WebServlet("/coupon/*")
public class CouponServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
		
		if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if (uri.indexOf("register.do") != -1) {
			registerForm(req, resp);
		} else if (uri.indexOf("register_ok.do") != -1) {
			registerSubmit(req, resp);
		} else if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if (uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}
		
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CouponDAO dao = new CouponDAO();
		TravelUtil util = new TravelUtilBootstrap();
		
		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount();
			
			int size = 12;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<CouponDTO> list = dao.listCoupon(offset, size);
			
			String listUrl = cp + "/coupon/list.do";
			String articleUrl = cp + "/coupon/article.do?page="+current_page;
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			long gap;
			Date curDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for(CouponDTO dto : list) {
				Date date = sdf.parse(dto.getEnd_date());
				gap = (date.getTime() - curDate.getTime()) / (1000*60*60*24);
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
		forward(req, resp, "/WEB-INF/views/coupon/list.jsp");
	}
	
	protected void registerForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("submit", "등록");
		req.setAttribute("mode", "register");
		req.setAttribute("title", "쿠폰 등록");
		forward(req, resp, "/WEB-INF/views/coupon/register.jsp");
	}
	
	protected void registerSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CouponDAO dao = new CouponDAO();
		
		String cp = req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/coupon/list.do");
			return;
		}
		
		try {
			CouponDTO dto = new CouponDTO();
			
			dto.setCouponName(req.getParameter("couponName"));
			dto.setContent(req.getParameter("content"));
			

			String couponRate = req.getParameter("couponRate");
			if (couponRate.equals("")) {
				dto.setCouponRate(0);
			} else {
				dto.setCouponRate(Integer.parseInt(couponRate));
			}
			
			String couponPrice = req.getParameter("couponPrice");
			if (couponPrice.equals("")) {
				dto.setCouponPrice(0);
			} else {
				dto.setCouponPrice(Integer.parseInt(couponPrice));
			}
			
			
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			
			dao.insertCoupon(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/coupon/list.do");
		
	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CouponDAO dao = new CouponDAO();
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page="+page;
		
		try {
			long couponNum = Long.parseLong(req.getParameter("couponNum"));
			
			CouponDTO dto = dao.readCoupon(couponNum);
			
			
			if(dto == null) {
				resp.sendRedirect(cp+"/coupon/list.do?page=" + page);
				return;
			}
			
			dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));
			
			long gap;
			Date curDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			Date date = sdf.parse(dto.getEnd_date());
			gap = (date.getTime() - curDate.getTime()) / (1000*60*60*24);
			dto.setGap(gap);
				
			dto.setEnd_date(dto.getEnd_date().substring(0, 10));
			
			
			req.setAttribute("query", query);
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			forward(req, resp, "/WEB-INF/views/coupon/article.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/coupon/list.do?page="+page);
		
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CouponDAO dao = new CouponDAO();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		
		try {
			long couponNum = Long.parseLong(req.getParameter("couponNum"));
			CouponDTO dto = dao.readCoupon(couponNum);
			if(dto == null) {
				resp.sendRedirect(cp+"/coupon/list.do?page=" + page);
				return;
			}
			
			req.setAttribute("submit", "수정");
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");
			req.setAttribute("title", "쿠폰 수정");
			
			forward(req, resp, "/WEB-INF/views/coupon/register.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/coupon/list.do?page="+page);
		
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CouponDAO dao = new CouponDAO();
		
		String cp = req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp+"/coupon/list.do");
			return;
		}
		
		String page = req.getParameter("page");
		
		try {
			CouponDTO dto = new CouponDTO();
			
			dto.setCouponNum(Long.parseLong(req.getParameter("couponNum")));
			dto.setCouponName(req.getParameter("couponName"));
			dto.setContent(req.getParameter("content"));
			dto.setCouponRate(Integer.parseInt(req.getParameter("couponRate")));
			dto.setCouponPrice(Integer.parseInt(req.getParameter("couponPrice")));
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			
			dao.updateCoupon(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/coupon/list.do?page="+page);
		
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CouponDAO dao = new CouponDAO();
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long couponNum = Long.parseLong(req.getParameter("couponNum"));
			CouponDTO dto = dao.readCoupon(couponNum);
			if (dto == null) {
				resp.sendRedirect(cp+"/coupon/list.do?" + query);
				return;
			}
			
			dao.deleteCoupon(couponNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/coupon/list.do?" + query);
		
	}
}
