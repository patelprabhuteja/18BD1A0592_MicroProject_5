package com.websockets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static RequestDispatcher rd;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");

		HttpSession session = request.getSession(true);
		String username=request.getParameter("user");
		if(username.equals("Patient")) {
			username=request.getParameter("name");
			session.setAttribute("username", username);
		}
		else {
			String password=request.getParameter("name");
			if(username.equals("Doctor") && password.equals("doctor")) {
				session.setAttribute("username", "Doctor");
			}
			else if(username.equals("Ambulance") && password.equals("ambulance")) {
				session.setAttribute("username", "Ambulance");
			}
			else {
				response.sendError(403, "Invalid Password");
				return;
			}
		}
		if (username != null && username.equals("Doctor")) {
			rd = request.getRequestDispatcher("/doctor.jsp");
			rd.forward(request, response);
		} else if (username != null && username.equals("Ambulance")) {
			rd = request.getRequestDispatcher("/ambulance.jsp");
			rd.forward(request, response);
		} else if (username != null) {
			rd = request.getRequestDispatcher("/patient.jsp");
			rd.forward(request, response);
		}
	}
}