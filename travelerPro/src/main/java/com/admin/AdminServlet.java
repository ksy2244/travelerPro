package com.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.member.MemberDTO;
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/admin/*")
public class AdminServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String uri = req.getRequestURI();
	
		if(uri.indexOf("main.do") != -1) {
			main(req, resp);
		} else if(uri.indexOf("userList.do") != -1) {
			userList(req, resp);
		} else if(uri.indexOf("companyList.do") != -1) {
			companyList(req, resp);
		} else if(uri.indexOf("companyArticle.do") != -1) {
			companyArticle(req, resp);
		} else if(uri.indexOf("companyUpdate.do") != -1) {
			companyUpdate(req, resp);
		} 
	}
	
	protected void main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		
		try {
			
			int resultMember = dao.plusMember();
			req.setAttribute("resultMember", resultMember);
			
			int resultCompany = dao.plusCompany();
			req.setAttribute("resultCompany", resultCompany);
			
			int resultCoupon = dao.plusCoupon();
			req.setAttribute("resultCoupon", resultCoupon);
			
			int resultNotice = dao.plusNotice();
			req.setAttribute("resultNotice", resultNotice);
			
			int resultmemberQ = dao.plusmemberQ();
			req.setAttribute("resultmemberQ", resultmemberQ);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		forward(req, resp, "/WEB-INF/views/admin/main.jsp");
	}
	
	
	protected void userList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		TravelUtil util = new TravelUtilBootstrap();
		
		String cp = req.getContextPath();
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.userDataCount();
			
			int size = 15;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			
			List<MemberDTO> list = dao.totalUserList(offset, size);
			
			String listUrl = cp + "/admin/userList.do";
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("paging", paging);
	
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		forward(req, resp, "/WEB-INF/views/admin/userList.jsp");
	
	}
	
	protected void companyList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		TravelUtil util = new TravelUtilBootstrap();
		
		String cp = req.getContextPath();
		
		try {
			int current_page = 1;
			
			int dataCount = dao.userDataCount();
			
			int size = 15;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<AdminDTO> list = dao.companyList(offset, size);
			
			String listUrl = cp + "/admin/companyList.do";
			String articleUrl = cp + "/admin/companyArticle.do?page=" + current_page;
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("paging", paging);
			req.setAttribute("articleUrl", articleUrl);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		forward(req, resp, "/WEB-INF/views/admin/companyList.jsp");
	
	}
	
	protected void companyArticle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page="+page;
		
		try {
			long companyNum = Long.parseLong(req.getParameter("companyNum"));
			
			AdminDTO dto = dao.companyRead(companyNum);
			if(dto == null) {
				resp.sendRedirect(cp + "/admin/companyList.do?"+query);
				return;
			}
			
			if(dto.getCheckInTime().contains("시")) {
				dto.setCheckInTime(dto.getCheckInTime().replaceAll("시", ":00"));
			}
			
			if(dto.getCheckOutTime().contains("시")) {
				dto.setCheckOutTime(dto.getCheckOutTime().replaceAll("시", ":00"));
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			
			forward(req, resp, "/WEB-INF/views/admin/companyArticle.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		resp.sendRedirect(cp + "/admin/companyList.do?" + query);
	
	}
	
	protected void companyUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AdminDAO dao = new AdminDAO();
		
		String state = "false";
		
		try {
			long companyNum = Long.parseLong(req.getParameter("companyNum"));
			int approval = Integer.parseInt(req.getParameter("approval"));
			
			dao.updateCompany(approval, companyNum);
			
			state = "true";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONObject job = new JSONObject();
		job.put("state", state);
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}

}
