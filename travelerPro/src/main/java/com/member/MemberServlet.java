package com.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.util.TravelServlet;

@WebServlet("/member/*")
public class MemberServlet extends TravelServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri = req.getRequestURI();
		if (uri.indexOf("login.do") != -1) {
			loginForm(req, resp);
		} else if (uri.indexOf("login_ok.do") != -1) {
			loginSubmit(req, resp);
		} else if (uri.indexOf("logout.do") != -1) {
			logout(req, resp);
		} else if (uri.indexOf("member.do") != -1) {
			memberForm(req, resp);
		} else if (uri.indexOf("member_ok.do") != -1) {
			memberSubmit(req, resp);
		} else if (uri.indexOf("pwd.do") != -1) {
			pwdForm(req, resp);
		} else if (uri.indexOf("pwd_ok.do") != -1) {
			pwdSubmit(req, resp);
		} else if (uri.indexOf("update_ok.do") != -1) {
			updateSubmit(req, resp);
		} else if (uri.indexOf("userIdCheck.do") != -1) {
			userIdCheck(req, resp);
		} else if (uri.indexOf("alarm.do") != -1) {
			alarmForm(req, resp);
		} else if (uri.indexOf("alarm_ok.do") != -1) {
			alarmSubmit(req, resp);
		} else if (uri.indexOf("delete.do") != -1) {
			delete(req, resp);
		}
	}

	protected void loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}

	protected void loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		MemberDAO dao = new MemberDAO();
		String cp = req.getContextPath();

		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/");
			return;
		}

		String userId = req.getParameter("userId");
		String userPwd = req.getParameter("userPwd");

		MemberDTO dto = dao.loginMember(userId, userPwd);
		if (dto != null) {
			SessionInfo info = new SessionInfo();
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			info.setUserRoll(dto.getRoll());

			session.setAttribute("member", info);

			resp.sendRedirect(cp + "/");
			return;
		}

		String msg = "????????? ?????? ??????????????? ???????????? ????????????.";
		req.setAttribute("message", msg);

		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}

	protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		String cp = req.getContextPath();

		session.removeAttribute("member");

		session.invalidate();

		resp.sendRedirect(cp + "/");
	}

	private void memberForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ????????????
		req.setAttribute("title", "????????????");
		req.setAttribute("mode", "member");

		forward(req, resp, "/WEB-INF/views/member/member.jsp");

	}

	private void memberSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ???????????? ??????
		MemberDAO dao = new MemberDAO();

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/");
			return;
		}

		String message = "";
		try {
			MemberDTO dto = new MemberDTO();
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setNickName(req.getParameter("nickName"));

			String birth = req.getParameter("birth").replaceAll("(\\.|\\-|\\/)", "");
			dto.setBirth(birth);

			String email1 = req.getParameter("email1");
			String email2 = req.getParameter("email2");
			dto.setEmail(email1 + "@" + email2);

			String tel1 = req.getParameter("tel1");
			String tel2 = req.getParameter("tel2");
			String tel3 = req.getParameter("tel3");
			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);

			dao.insertMember(dto);
			resp.sendRedirect(cp + "/");
			return;

		} catch (SQLException e) {
			if (e.getErrorCode() == 1)
				message = "????????? ???????????? ?????? ????????? ?????? ????????????.";
			else if (e.getErrorCode() == 1400)
				message = "?????? ????????? ???????????? ???????????????.";
			else if (e.getErrorCode() == 1840 || e.getErrorCode() == 1861)
				message = "?????? ????????? ???????????? ????????????.";
			else
				message = "?????? ????????? ?????? ????????????.";

		} catch (Exception e) {
			message = "?????? ????????? ?????? ????????????.";
			e.printStackTrace();
		}

		req.setAttribute("title", "?????? ??????");
		req.setAttribute("mode", "member");
		req.setAttribute("message", message);
		forward(req, resp, "/WEB-INF/views/member/member.jsp");
	}

	private void pwdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ????????????
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String cp = req.getContextPath();
		if (info == null) {
			// ?????? ?????? ????????????
			resp.sendRedirect(cp + "/member/login.do");
			return;
		}

		String mode = req.getParameter("mode");
		if (mode.equals("update")) {
			req.setAttribute("title", "?????? ?????? ??????");
		} else {
			req.setAttribute("title", "?????? ??????");
		}
		req.setAttribute("mode", mode);

		forward(req, resp, "/WEB-INF/views/member/pwd.jsp");
	}

	private void pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ???????????? ??????
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();

		String cp = req.getContextPath();

		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/");
			return;
		}

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) { // ???????????? ??? ??????
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			// DB?????? ?????? ?????? ?????? ????????????
			MemberDTO dto = dao.readMember(info.getUserId());
			if (dto == null) {
				session.invalidate();
				resp.sendRedirect(cp + "/");
				return;
			}

			String userPwd = req.getParameter("userPwd");
			String mode = req.getParameter("mode");
			if (!dto.getUserPwd().equals(userPwd)) {

				if (mode.equals("update")) {
					req.setAttribute("title", "?????? ?????? ??????");
				} else {
					req.setAttribute("title", "?????? ??????");
				}

				req.setAttribute("mode", mode);
				req.setAttribute("message", "??????????????? ???????????? ????????????.");
				forward(req, resp, "/WEB-INF/views/member/pwd.jsp");
				return;
			}

			/*
			 * if (mode.equals("delete")) { // ???????????? dao.deleteMember(info.getUserId());
			 * 
			 * session.removeAttribute("member"); session.invalidate();
			 * 
			 * resp.sendRedirect(cp + "/");
			 * 
			 * return; }
			 */
			// ?????????????????? - ????????????????????? ??????
			req.setAttribute("title", "?????? ?????? ??????");
			req.setAttribute("dto", dto);
			req.setAttribute("mode", "update");
			forward(req, resp, "/WEB-INF/views/member/update_member.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/");
	}

	private void updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ???????????? ?????? ??????
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();

		String cp = req.getContextPath();
		if (req.getMethod().equalsIgnoreCase("GET")) {
			resp.sendRedirect(cp + "/");
			return;
		}

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			MemberDTO dto = new MemberDTO();

			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			dto.setNickName(req.getParameter("nickName"));

			String birth = req.getParameter("birth").replaceAll("(\\.|\\-|\\/)", "");
			dto.setBirth(birth);

			String email1 = req.getParameter("email1");
			String email2 = req.getParameter("email2");
			dto.setEmail(email1 + "@" + email2);

			String tel1 = req.getParameter("tel1");
			String tel2 = req.getParameter("tel2");
			String tel3 = req.getParameter("tel3");
			dto.setTel(tel1 + "-" + tel2 + "-" + tel3);

			dao.updateMember(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/");
	}

	private void userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ????????? ?????? ??????
		MemberDAO dao = new MemberDAO();

		String userId = req.getParameter("userId");
		MemberDTO dto = dao.readMember(userId);

		String passed = "false";
		if (dto == null) {
			passed = "true";
		}

		JSONObject job = new JSONObject();
		job.put("passed", passed);

		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.print(job.toString());
	}

	protected void alarmForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			MemberDAO dao = new MemberDAO();
			String date = dao.sysdate();

			req.setAttribute("date", date);

		} catch (Exception e) {
			e.printStackTrace();
		}

		forward(req, resp, "/WEB-INF/views/member/alarm.jsp");
	}

	private void alarmSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();

		String cp = req.getContextPath();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if (info == null) {
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			MemberDTO dto = new MemberDTO();

			dto.setUserId(info.getUserId());
			if (req.getParameter("mAlarm") != null) {
				dto.setmAlarm(Integer.parseInt(req.getParameter("mAlarm")));
			}

			if (req.getParameter("pAlarm") != null) {
				dto.setpAlarm(Integer.parseInt(req.getParameter("pAlarm")));
			}

			if (req.getParameter("eAlarm") != null) {
				dto.seteAlarm(Integer.parseInt(req.getParameter("eAlarm")));
			}

			if (req.getParameter("sAlarm") != null) {
				dto.setsAlarm(Integer.parseInt(req.getParameter("sAlarm")));
			}

			dto.setModify_date(req.getParameter("modify_date"));
			dao.updateAlarm(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		resp.sendRedirect(cp + "/");
	}

	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO();
		HttpSession session = req.getSession();

		String cp = req.getContextPath();

		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");

			MemberDTO dto = new MemberDTO();

			dto.setUserId(info.getUserId());

			dao.deleteMember(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}
		resp.sendRedirect(cp + "/");
	}

}
