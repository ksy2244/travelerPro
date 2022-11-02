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
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/mypage/*")
public class MyPageServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	
	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		req.setCharacterEncoding("utf-8");
		
		// 세션 정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) { // 로그인 되어 있지 않은 경우
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
				
		if(uri.indexOf("coupon.do") != -1) {
			coupon(req, resp);
		} else if(uri.indexOf("couponInfo.do") != -1) {
			couponInfo(req, resp);
		} if (uri.indexOf("alarm.do") != -1) {
			alarm(req, resp);
		}
		
	}
	
	protected void coupon(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MypageDAO dao = new MypageDAO();
		TravelUtil util = new TravelUtilBootstrap();
		
		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			System.out.print(info.getUserId());
			
			int dataCount = dao.dataCount(info.getUserId());
			
			int size = 9;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<CouponDTO> list = dao.myPageCoupon(info.getUserId(), size, offset);
			
			String listUrl = cp + "/mypage/coupon.do";
			String articleUrl = cp + "/mypage/couponInfo.do?page="+current_page;
			
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
		forward(req, resp, "/WEB-INF/views/mypage/coupon.jsp");
	}
	
	protected void couponInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MypageDAO dao = new MypageDAO();
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page="+page;
		
		try {
			long couponNum = Long.parseLong(req.getParameter("couponNum"));
			
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			
			CouponDTO dto = dao.myPageReadCoupon(couponNum, info.getUserId());
			
			
			if(dto == null) {
				resp.sendRedirect(cp+"/mypage/coupon.do?page=" + page);
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
			
			forward(req, resp, "/WEB-INF/views/mypage/couponInfo.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp+"/mypage/coupon.do?page="+page);
		
	}
	

	protected void alarm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			forward(req, resp, "/WEB-INF/views/mypage/alarm.jsp");
	}
}
