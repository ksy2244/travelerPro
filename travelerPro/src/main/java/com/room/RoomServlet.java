package com.room;

import java.io.File;
import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import com.util.FileManager;
import com.util.FileUploadServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@MultipartConfig
@WebServlet("/room/*")
public class RoomServlet extends FileUploadServlet  {
	private static final long serialVersionUID = 1L;
	
	private String pathname;
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
	
		
		HttpSession session = req.getSession();
		
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "room";
		
		String uri =req.getRequestURI();
		if(uri.indexOf("list.do") != -1) {
			list(req,resp);
		}else if(uri.indexOf("write.do") != -1) {
			room(req,resp);
		}else if(uri.indexOf("write_ok.do") != -1) {
			roomSubmit(req,resp);
		}else if (uri.indexOf("article.do") != -1) {
			ceoroomSubmit(req,resp);
		}else if (uri.indexOf("update.do") != -1) {
			updateForm(req,resp);
		}else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req,resp);
		}	else if (uri.indexOf("deletefile.do") != -1) {
			deleteFile(req, resp);
		}	else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}					
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException{
		RoomDAO dao=new RoomDAO();
		TravelUtil util=new TravelUtilBootstrap();
		String cp= req.getContextPath();
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount();
			
			int size = 15;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<RoomDTO> list = dao.listroom(offset, size);
			
			String listUrl = cp + "/room/list.do";
			String articleUrl = cp + "/room/article.do?page=" + current_page;
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
		
		
		forward(req, resp, "/WEB-INF/views/room/list.jsp");
			
			
	}
	protected void room(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("title", "객실등록");
		req.setAttribute("mode", "write");		
		forward(req, resp, "/WEB-INF/views/room/write.jsp");
		
	}
	
	protected void roomSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao=new RoomDAO();
		
		String cp =req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/room/list.do");
			return;
		}
		
		try {
			RoomDTO dto=new RoomDTO();
			dto.setRoomName(req.getParameter("roomName"));
			dto.setRoomInfo(req.getParameter("roomInfo"));
			dto.setPrice(Integer.parseInt(req.getParameter("price")));
			dto.setDiscountRate(Integer.parseInt(req.getParameter("discountRate")));
			dto.setHeadCount(Integer.parseInt(req.getParameter("headCount")));		
			dto.setCompanyNum(Integer.parseInt(req.getParameter("companyNum")));
			
			dao.insertRoom(dto);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+ "/room/list.do");
		
		
	}
	
	protected void ceoroomSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao=new RoomDAO();
		
		String cp=req.getContextPath();
		
		String page=req.getParameter("page");
		String query ="page=" + page;
		
		try {
			int roomNum = Integer.parseInt(req.getParameter("roomNum"));
			
			RoomDTO dto= dao.readRoom(roomNum);
			if(dto == null) {
				resp.sendRedirect(cp + "/room/list.do?" +query);
				return; 
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			
			forward(req, resp, "/WEB-INF/views/room/article.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/room/list.do?" +query);
		
		
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao= new RoomDAO();
		
		String cp=req.getContextPath();
		
		String page=req.getParameter("page");
		
		try {
			int roomNum=Integer.parseInt(req.getParameter("roomNum"));
			RoomDTO dto =dao.readRoom(roomNum);
			
			if(dto==null) {
				resp.sendRedirect(cp+"/room/list.do?page=" + page);
				return;
			}
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("title", "객실 수정");
			req.setAttribute("mode", "update");
			
			forward(req, resp, "/WEB-INF/views/room/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+ "/room/list.do?page=" +page);
		
		
		
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao= new RoomDAO();
		
		String cp=req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/room/list.do");
			return;
		}
		String page =req.getParameter("page");
		
		try {
			RoomDTO dto=new RoomDTO();
			dto.setRoomName(req.getParameter("roomName"));
			dto.setRoomInfo(req.getParameter("roomInfo"));
			dto.setPrice(Integer.parseInt(req.getParameter("price")));
			dto.setDiscountRate(Integer.parseInt(req.getParameter("discountRate")));
			dto.setHeadCount(Integer.parseInt(req.getParameter("headCount")));
		
			
			dao.updateroom(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/room/list.do?page=" + page);
	}
	
	
	protected void deleteFile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao=new RoomDAO();

		String cp = req.getContextPath();

		String page = req.getParameter("page");
		
		try {
			Integer roomNum=Integer.parseInt(req.getParameter("roomNum"));
			RoomDTO dto=dao.readRoom(roomNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/room/list.do?page=" + page);
				return;
			}
			FileManager.doFiledelete(pathname, dto.getSaveFilename());

			dto.setOriginalFilename("");
			dto.setSaveFilename("");
			dto.setFileSize(0);
			dao.updateroom(dto);

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);

			req.setAttribute("mode", "update");

			forward(req, resp, "/WEB-INF/views/room/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/room/list.do?page=" + page);
	}
	
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao =new RoomDAO(); 
		String cp=req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		try {
			int roomNum =Integer.parseInt(req.getParameter("roomNum"));
			RoomDTO dto =dao.readRoom(roomNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/room/list.do?" + query);
				return;
			}
			if(dto.getSaveFilename() != null && dto.getSaveFilename().length() != 0) {
				FileManager.doFiledelete(pathname, dto.getSaveFilename());
			}
			dao.deleteRoom(roomNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		resp.sendRedirect(cp + "/room/list.do?" + query);
	}
	
	
}	

