package com.notice;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.TravelServlet;

@WebServlet("/notice/*")
public class NoticeServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		// 메인 화면
		String uri = req.getRequestURI();
		
		// 세션 정보
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		
		if(info.getUserId() == "admin") { // 로그인 되어 있지 않은 경우
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}
		
		// 파일을 저장할 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "sbbs";
				
		// uri에 따른 작업 구분
		if(uri.indexOf("list.do") != -1) {
			list(req, resp);
		} else if(uri.indexOf("write.do") != -1) {
			writeForm(req, resp);
		} else if(uri.indexOf("write_ok.do") != -1) {
			writeSubmit(req, resp);
		} else if(uri.indexOf("article.do") != -1) {
			article(req, resp);
		} else if(uri.indexOf("update.do") != -1) {
			updateForm(req, resp);
		} else if(uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if(uri.indexOf("deleteFile.do") != -1) {
			deleteFile(req, resp);
		} else if(uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		} else if(uri.indexOf("download.do") != -1) {
			download(req, resp);
		} 
		
	}
	
	protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/notice/list.jsp");
	}
	
	protected void writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/notice/wirte.jsp");
	}
	
	protected void writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void deleteFile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	
	protected void download(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}

}
