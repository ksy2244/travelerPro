package com.ceo;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

import org.json.JSONObject;

import com.member.SessionInfo;
import com.util.TravelServlet;
import com.util.TravelUtil;
import com.util.TravelUtilBootstrap;

@WebServlet("/ceo/*")
@MultipartConfig
public class CeoServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;
	private String pathname;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();
		
		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/");
		pathname = root + "uploads" + File.separator + "ceo";

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
		} else if (uri.indexOf("update.do") != -1) {
			update(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if (uri.indexOf("qna.do") != -1) {
			qna(req, resp);
		} else if (uri.indexOf("qnacontent.do") != -1) {
			qnaarticle(req, resp);
		} else if (uri.indexOf("insertReply.do") != -1) {
			insertReply(req, resp);
		} else if (uri.indexOf("insertReply.do") != -1) {
			insertReply(req, resp);
		} else if (uri.indexOf("listAnswer.do") != -1) {
			listAnswer(req, resp);
		}  
}
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		TravelUtil util = new TravelUtilBootstrap();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();
		
		if (info == null) {
			
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		
		
		try {
			String page = req.getParameter("page"); 
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataCount(info.getUserId());
			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			
			int offset = (current_page -1) *size;
			if(offset <0) offset = 0;
			List<CeoDTO> list =dao.listCeo(offset, size,info.getUserId());

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
			System.out.println(pathname);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		forward(req, resp, "/WEB-INF/views/ceo/main.jsp");
	}
	protected void recognitionSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		String cp = req.getContextPath();
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/ceo/main.do");
			return;
		}

		try {
			CeoDTO dto = new CeoDTO();
			dto.setCompanyName(req.getParameter("companyName"));
			dto.setBusinessNum1(req.getParameter("businessNum1"));
			dto.setBusinessNum2(req.getParameter("businessNum2"));
			dto.setBusinessNum3(req.getParameter("businessNum3"));
			dto.setBusinessNum(req.getParameter("businessNum1")+"-"+req.getParameter("businessNum2")+"-"+req.getParameter("businessNum3"));
			dto.setUserId(req.getParameter("userId"));
			if(req.getParameter("regionName").equals("강원도")) {
				dto.setRegionNum(1);
			}
			dto.setCheckinTime(req.getParameter("checkinTime"));
			dto.setCheckoutTime(req.getParameter("checkoutTime"));
			dto.setCompanyTel1(req.getParameter("tel1"));
			dto.setCompanyTel2(req.getParameter("tel2"));
			dto.setCompanyTel3(req.getParameter("tel3"));
			dto.setCompanyTel(req.getParameter("tel1")+"-"+req.getParameter("tel2")+"-"+req.getParameter("tel3"));
			dto.setZip(req.getParameter("zip"));
			dto.setAddr(req.getParameter("addr1"));
			dto.setAddrDetail(req.getParameter("addr2"));
			dto.setCompanyInfo(req.getParameter("companyInfo"));
			dto.setAmenities(req.getParameter("amenities"));
			dto.setGuide(req.getParameter("guide"));
			dto.setNotice(req.getParameter("notice"));
			
			Map<String,String[]> map = doFileUpload(req.getParts(),pathname);
			if(map != null) {
				String[] saveFiles = map.get("saveFilenames");
				dto.setImageFiles(saveFiles);
			}
			System.out.println(dto.getImageFiles());
			dao.insertCeo(dto);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(req.getParameter("regionName"));
			System.out.println(req.getParameter("companyName"));
		}
		resp.sendRedirect(cp+"/ceo/main.do");
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
	protected void payList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/ceo/paylist.jsp");
	}
	protected void room(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	protected void reservation(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/ceo/reservation.jsp");
	}
	protected void recognition(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", "recognition");
		forward(req, resp, "/WEB-INF/views/ceo/recognition.jsp");
	}
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		
		String page = req.getParameter("page");
		String query = "page="+page;
		try {
			int num = Integer.parseInt(req.getParameter("companyNum"));
			CeoDTO dto = dao.readCto(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/ceo/main.do?"+query);
				return;
			}
			List<CeoDTO> listFile = dao.listPhotoFile(num);
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);
			req.setAttribute("listFile", listFile);
			
			forward(req, resp, "/WEB-INF/views/ceo/article.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/ceo/main.do?" + query);
	}
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();

		/*
		 * HttpSession session = req.getSession(); SessionInfo info = (SessionInfo)
		 * session.getAttribute("member");
		 */
		
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		String query = "page=" + page;

		try {
			
			int companyNum = Integer.parseInt(req.getParameter("companyNum"));
			
			CeoDTO dto = dao.readCto(companyNum);
			
			if(dto == null) {
				resp.sendRedirect(cp + "/ceo/list.do?" + query);
				return;
			}
			
			
			dao.deleteCompany(companyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/ceo/list.do?" + query);
		
	}
	protected void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		
		try {
			int num = Integer.parseInt(req.getParameter("companyNum"));
			CeoDTO dto = dao.readCto(num);
			
			List<CeoDTO> listFile = dao.listPhotoFile(num);
			
			String [] bnum = dto.getBusinessNum().split("-");
			dto.setBusinessNum1(bnum[0]);
			dto.setBusinessNum2(bnum[1]);
			dto.setBusinessNum3(bnum[2]);
			String [] t = dto.getCompanyTel().split("-");
			dto.setCompanyTel1(t[0]);
			dto.setCompanyTel2(t[1]);
			dto.setCompanyTel3(t[2]);
			
			
			/*
			 * if(dto == null) { resp.sendRedirect(cp+"/ceo/main.do?page=" +page); return; }
			 */
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("listFile", listFile);
			req.setAttribute("mode", "update");
			
			forward(req, resp, "/WEB-INF/views/ceo/recognition.jsp");
			return;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(req.getParameter("companyNum"));
		}
		
		resp.sendRedirect(cp+"/ceo/main.do?page="+page);
	}
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		String cp = req.getContextPath();
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/ceo/main.do");
			return;
		}
		String page = req.getParameter("page");
		try {
			CeoDTO dto = new CeoDTO();
			
			dto.setCompanyNum(Integer.parseInt(req.getParameter("companyNum")));
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
			
			Map<String, String[]> map = doFileUpload(req.getParts(), pathname);
			if (map != null) {
				String[] saveFiles = map.get("saveFilenames");
				dto.setImageFiles(saveFiles);
			}
			
			dao.updateCeo(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp+"/ceo/main.do?page="+page);
	}
	
	protected void qna(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		TravelUtil util = new TravelUtilBootstrap();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String cp = req.getContextPath();
		
		if (info == null) {
			
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		
		
		try {
			String page = req.getParameter("page"); 
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			int dataCount = dao.dataQnaCount(info.getUserId());
			int size = 5;
			int total_page = util.pageCount(dataCount, size);
			if(current_page > total_page) {
				current_page = total_page;
			}
			
			
			int offset = (current_page -1) *size;
			if(offset <0) offset = 0;
			List<CeoDTO> list =dao.listqna(offset,size,info.getUserId());
			String listUrl = cp + "/ceo/main.do";
			String articleUrl = cp + "/ceo/qnacontent.do?page=" + current_page;
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
		
		
		forward(req, resp, "/WEB-INF/views/ceo/qna.jsp");
	}
	
	protected void qnaarticle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		String cp = req.getContextPath();
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if (info == null) {
			
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		
		String page = req.getParameter("page");
		String query = "page="+page;
		try {
			int num = Integer.parseInt(req.getParameter("companyNum"));
			CeoDTO dto = dao.readqna(num);
			if(dto == null) {
				resp.sendRedirect(cp + "/main.do?"+query);
				return;
			}
			
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("query", query);

			
			forward(req, resp, "/WEB-INF/views/ceo/qnaarticle.jsp");
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/ceo/qna.do?" + query);
		
	}
	protected void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		String cp = req.getContextPath();
		if(!req.getMethod().equalsIgnoreCase("POST")) {
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}
		String state = "false";
		try {
			CeoDTO dto = new CeoDTO();
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			if(info == null) {
				resp.sendRedirect(cp+"/member/login.do");
				return;
			}
			dto.setContent(req.getParameter("content"));
			dto.setCompanyNum(Integer.parseInt(req.getParameter("companyNum")));
			dto.setUserId(info.getUserId());
			dto.setInquiryNum(Integer.parseInt(req.getParameter("inquiryNum")));
			if(req.getParameter("content") == null) {
				dto.setAnswhether(0);
			} else {
				dto.setAnswhether(1);
			}
			
			dao.insertAnswer(dto);
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject job = new JSONObject();
		job.put("state", state);
		resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}
	protected void listAnswer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CeoDAO dao = new CeoDAO();
		
		try {
			
			int num = Integer.parseInt(req.getParameter("companyNum"));
			int inum = Integer.parseInt(req.getParameter("inquiryNum"));
			CeoDTO dto =dao.readAnswer(inum);
			

			
			req.setAttribute("dto", dto);
			req.setAttribute("companyNum", num);
			req.setAttribute("inquiryNum", inum);
			


			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		forward(req, resp, "/WEB-INF/views/ceo/listReply.jsp");
	}
	

}
