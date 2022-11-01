package com.room;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.member.SessionInfo;
import com.util.FileManager;

import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;


@WebServlet("/room/*")
@MultipartConfig
public class RoomServlet extends TravelServlet  {
	private static final long serialVersionUID = 1L;
	
	private String pathname;
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
	
		
		HttpSession session = req.getSession();
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		if(info ==null) { 
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
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
			deleteRoomFile(req, resp);
		}	else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}					
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException{
		RoomDAO dao=new RoomDAO();
		TravelUtil util=new TravelUtilBootstrap();
		String cp= req.getContextPath();
		
		try {
			long companyNum=Long.parseLong(req.getParameter("companyNum"));
			String page = req.getParameter("page");		
			
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount(companyNum);
			
			int size = 15;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<RoomDTO> list = dao.listroom(offset, size, companyNum);
			String listUrl = cp +"/room/list.do?companyNum=" +companyNum;
			String articleUrl = cp + "/room/article.do?page=" +current_page + "&companyNum=" +companyNum ;
			String paging = util.paging(current_page, total_page, listUrl);
			
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("size", size);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("paging", paging);
			req.setAttribute("companyNum", companyNum);
			
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		forward(req, resp, "/WEB-INF/views/room/list.jsp");
			
			
	}
	protected void room(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		long companyNum=Long.parseLong(req.getParameter("companyNum"));
		req.setAttribute("title", "객실등록");
		req.setAttribute("mode", "write");	
		req.setAttribute("companyNum", companyNum);
		forward(req, resp, "/WEB-INF/views/room/write.jsp");
		
	}
	
	protected void roomSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao=new RoomDAO();
		long companyNum=Long.parseLong(req.getParameter("companyNum"));
		//req.setAttribute("companyNum", companyNum);
		String cp =req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {		
			resp.sendRedirect(cp + "/room/list.do?companyNum="+companyNum);
			return;
		}
		
		try {
			
			RoomDTO dto=new RoomDTO();
			
			
			dto.setRoomName(req.getParameter("roomName"));
			dto.setRoomInfo(req.getParameter("roomInfo"));
			dto.setPrice(Integer.parseInt(req.getParameter("price")));
			dto.setDiscountRate(Integer.parseInt(req.getParameter("discountRate")));
			dto.setHeadCount(Integer.parseInt(req.getParameter("headCount")));		
			dto.setCompanyNum(Long.parseLong(req.getParameter("companyNum")));
			Map<String, String[]>map=doFileUpload(req.getParts(),pathname);
			if(map !=null) {
				String[]saveFiles =map.get("saveFilenames");
				dto.setImageFiles(saveFiles);
			}
			dao.insertRoom(dto);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+ "/room/list.do?companyNum=" +companyNum);
		
	}
	
	private Map<String, String[]> doFileUpload(Collection<Part> parts, String pathname2) {
		Map<String, String[]> map = null;
		try {
			File f = new File(pathname2);
			if (!f.exists()) { 
				f.mkdirs();
			}

			String original, save, ext;
			List<String> listOriginal = new ArrayList<String>();
			List<String> listSave = new ArrayList<String>();

			for (Part p : parts) {
				String contentType = p.getContentType();

				if (contentType != null) { 
					original = getOriginalFilename(p);
					if (original == null || original.length() == 0) {
						continue;
					}

					ext = original.substring(original.lastIndexOf("."));
					save = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
					save += System.nanoTime();
					save += ext;

					String fullpath = pathname2 + File.separator + save;
					p.write(fullpath);

					listOriginal.add(original);
					listSave.add(save);
				}
			}

			if (listOriginal.size() != 0) {
				String[] originals = listOriginal.toArray(new String[listOriginal.size()]);
				String[] saves = listSave.toArray(new String[listSave.size()]);

				map = new HashMap<>();

				map.put("originalFilenames", originals);
				map.put("saveFilenames", saves);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}
	private String getOriginalFilename(Part p) {
		try {
			for (String s : p.getHeader("content-disposition").split(";")) {
				if (s.trim().startsWith("filename")) {
					return s.substring(s.indexOf("=") + 1).trim().replace("\"", "");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}
	
	protected void ceoroomSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao=new RoomDAO();
		
		String cp=req.getContextPath();
		
		String page=req.getParameter("page");
		String query ="page=" + page;
		long companyNum=Long.parseLong(req.getParameter("companyNum"));
			
		try {
			int roomNum = Integer.parseInt(req.getParameter("roomNum"));
			
			RoomDTO dto= dao.readRoom(roomNum);
			if(dto == null) {
				resp.sendRedirect(cp + "/room/list.do?companyNum=" +companyNum + "&roomNum=" +roomNum);
				return; 
			}
			List<RoomDTO>listFile=dao.listphotoFile(roomNum);
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("companyNum", companyNum);
			req.setAttribute("query", query);
			req.setAttribute("listFile", listFile);
			
			forward(req, resp, "/WEB-INF/views/room/article.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/room/list.do?comapanyMum=" +companyNum);
		
		
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao= new RoomDAO();
		
		String cp=req.getContextPath();
		long companyNum=Long.parseLong(req.getParameter("companyNum"));
		String page=req.getParameter("page");
		
		try {
			int roomNum=Integer.parseInt(req.getParameter("roomNum"));
			RoomDTO dto =dao.readRoom(roomNum);
			
			//List<RoomDTO>listFile =dao.listPhotoFile(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/room/list.do?companyNum=" + companyNum);
				return;
			}
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("title", "객실 수정");
			req.setAttribute("mode", "update");
			req.setAttribute("companyNum", companyNum);
			forward(req, resp, "/WEB-INF/views/room/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+ "/room/list.do?companyNum=" +companyNum);
		
		
		
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao= new RoomDAO();
		long companyNum=Long.parseLong(req.getParameter("companyNum"));
		
		String cp=req.getContextPath();
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/room/list.do?companyNum="+companyNum );
			return;
		}
		//String page =req.getParameter("page");
		//req.setAttribute("page", page);
		//req.setAttribute("companyNum", companyNum);
		try {
			
			RoomDTO dto=new RoomDTO();
			dto.setRoomNum(Integer.parseInt(req.getParameter("roomNum")));
			dto.setRoomName(req.getParameter("roomName"));
			dto.setRoomInfo(req.getParameter("roomInfo"));
			dto.setPrice(Integer.parseInt(req.getParameter("price")));
			dto.setDiscountRate(Integer.parseInt(req.getParameter("discountRate")));
			dto.setHeadCount(Integer.parseInt(req.getParameter("headCount")));
			dto.setCompanyNum(Long.parseLong(req.getParameter("companyNum")));
			Map<String , String[]>map =doFileUpload(req.getParts(), pathname);
			if(map !=null) {
				String[]saveFiles =map.get("saveFilenames");
				dto.setImageFiles(saveFiles);
			}
			dao.updateroom(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/room/list.do?companyNum=" + companyNum);
	}
	
	
	protected void deleteRoomFile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao=new RoomDAO();

		String cp = req.getContextPath();
		long companyNum=Long.parseLong(req.getParameter("companyNum"));
		String page = req.getParameter("page");
		
		try {
			Integer roomNum=Integer.parseInt(req.getParameter("roomNum"));
			RoomDTO dto=dao.readRoom(roomNum);
			
			if (dto == null) {
				resp.sendRedirect(cp + "/room/list.do?companyNum=" + companyNum +"&rommNum" +roomNum);
				return;
			}
			
		RoomDTO vo=dao.readPhotoFile(roomNum);
				
			
			

			if(vo!=null) {
				FileManager.doFiledelete(pathname, dto.getSaveFilename());
				//dao.deletePhoto(num);
				//dao.updateroom(dto);
			}
			
		
			

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("companyNum", companyNum);
			req.setAttribute("mode", "update");
			req.setAttribute("roomNum", roomNum);
			forward(req, resp, "/WEB-INF/views/room/write.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resp.sendRedirect(cp + "/room/list.do? companyNum=" + companyNum );
	}
	
	
	
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RoomDAO dao =new RoomDAO(); 
		String cp=req.getContextPath();
		long companyNum=Long.parseLong(req.getParameter("companyNum"));
		String page = req.getParameter("page");
		//String query = "page=" + page;
		//String test="test="+companyNum;
		
		try {
			int roomNum =Integer.parseInt(req.getParameter("roomNum"));
			RoomDTO dto =dao.readRoom(roomNum);
			if (dto == null) {
				resp.sendRedirect(cp + "/room/list.do?companyNum=" + companyNum);
				return;
			}
			
			
			List<RoomDTO>listFile=dao.listphotoFile(roomNum);
			for(RoomDTO vo:listFile) {
				FileManager.doFiledelete(pathname, vo.getSaveFilename());
			}
			dao.deleteRoomFile("all", roomNum);
			
			dao.deleteRoom(roomNum);
			req.setAttribute("companyNum", companyNum);
			req.setAttribute("page",page);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		resp.sendRedirect(cp + "/room/list.do?companyNum=" + companyNum);
	}
	
	
}	

