package com.main;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.reservation.ReservationDAO;
import com.reservation.ReservationDTO;
import com.reservation.ReserveCompanyDTO;
import com.util.TravelServlet;

@WebServlet("/*")
public class MainServlet extends TravelServlet {
   private static final long serialVersionUID = 1L;

   @Override
   protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      req.setCharacterEncoding("utf-8");
      
      String uri = req.getRequestURI();
      
      // 메인 화면
      if(uri.indexOf("main.do") != -1) {
    	 
    	  
         forward(req, resp, "/WEB-INF/views/main/main.jsp");
		}
      else if(uri.indexOf("companyphoto.do")!=-1) {
    	  companyphoto(req,resp);
      }
   }
      
      protected void companyphoto(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	  try {
			ReservationDAO dao = new ReservationDAO();
			String areaCode = req.getParameter("areaCode");
			String areaName = req.getParameter("areaName");
			
			List<ReserveCompanyDTO> list = dao.listTopCompany();
			JSONObject job = new JSONObject();
			job.put("list", list);
			job.put("areaCode", areaCode);
			job.put("areaName", areaName);
			//job.put("paging", paging);
			
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print(job.toString());
			return;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	  
    	  resp.sendError(400);
      }

}
      // -- ** 더보기 ** -- 
      // 자주 묻는 질문 FAQ
      
      /* 
      if(uri.indexOf("main.do") != -1) {
         forward(req, resp, "/WEB-INF/views/main/faq.jsp");
      }
      
      // 1:1 문의 
      if(uri.indexOf("main.do") != -1) {
         forward(req, resp, "/WEB-INF/views/main/memberq.jsp");
      }
      
      // 공지사항 
      if(uri.indexOf("main.do") != -1) {
         forward(req, resp, "/WEB-INF/views/main/notice.jsp");
      }
            
      // 약관 및 정책
      if(uri.indexOf("main.do") != -1) {
         forward(req, resp, "/WEB-INF/views/main/~~~.jsp"); // 아직 안 적음 
      }
            
      */
      
      
      
      
   
   

   

