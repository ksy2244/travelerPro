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
import com.reservation.ReserveCompanyDTO;
import com.util.TravelServlet;

@WebServlet("/main/*")
public class HomeServlet extends TravelServlet {
   private static final long serialVersionUID = 1L;

   @Override
   protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      req.setCharacterEncoding("utf-8");
      
      String uri = req.getRequestURI();
      
      // 메인 화면
      if(uri.indexOf("main.do") != -1) {
    	  main(req,resp);
	  }
      else if(uri.indexOf("companyphoto.do")!=-1) {
    	  companyphoto(req,resp);
      }
   }
   
   protected void main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 forward(req, resp, "/WEB-INF/views/main/main.jsp");
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
     
      
      
      
      
   
   

   

