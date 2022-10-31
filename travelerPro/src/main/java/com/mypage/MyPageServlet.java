package com.mypage;

import java.io.File;
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

import com.coupon.CouponDAO;
import com.coupon.CouponDTO;
import com.member.SessionInfo;
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/mypage/*")
public class MyPageServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	private String pathname;
	
	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		
		// 세션 정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String ajax = req.getHeader("AJAX");
		if(ajax != null && info == null) {
			resp.sendError(403);
			return;
		} else if(info == null) { // 로그인 되어 있지 않은 경우
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		// 파일을 저장할 경로
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "mypage";
				
		if(uri.indexOf("coupon.do") != -1) {
			coupon(req, resp);
		} else if(uri.indexOf("couponInfo.do") != -1) {
			couponInfo(req, resp);
		} if (uri.indexOf("mypage.do") != -1) {
			mypage(req, resp);
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
			
			int dataCount = dao.dataCount();
			
			int size = 9;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<CouponDTO> list = dao.myPageCoupon(offset, size);
			
			String listUrl = cp + "/mypage/coupon.do";
			String articleUrl = cp + "/mypage/couponInfo.do?page="+current_page;
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			String end_date = null;
			for(CouponDTO dto : list) {
				end_date = dto.getEnd_date();
			}
			
			req.setAttribute("end_date", end_date);
			
			end_date = end_date + " 00:00:00";
			
			
			Date now = new Date(Calendar.getInstance().getTimeInMillis());
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			Date ed = sf.parse(end_date);
	       
	        long diff = ed.getTime() - now.getTime();
	        long Day = diff/(24*60*60*1000);
	        
	        String searchDate = "쿠폰 만료일까지 " + (Day+1) +"일 남았습니다.";
			
			req.setAttribute("searchDate", searchDate);
			
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
			
			CouponDTO dto = dao.myPageReadCoupon(couponNum);
			
			
			if(dto == null) {
				resp.sendRedirect(cp+"/mypage/coupon.do?page=" + page);
				return;
			}
			
			dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));
			
			String end_date = dto.getEnd_date();
			
			end_date = end_date + " 00:00:00";
			
			
			Date now = new Date(Calendar.getInstance().getTimeInMillis());
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			Date ed = sf.parse(end_date);
	       
	        long diff = ed.getTime() - now.getTime();
	        long Day = diff/(24*60*60*1000);
	        
	        String searchDate = "쿠폰 만료일까지 " + (Day+1) +"일 남았습니다.";
			
			req.setAttribute("searchDate", searchDate);
			
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
	
		protected void mypage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/mypage/member.jsp");
	}


}
