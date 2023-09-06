package com.fssa.proplanweb.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.proplan.dao.UserDao;
import com.fssa.proplan.exceptions.DaoException;
import com.fssa.proplan.exceptions.UserException;
import com.fssa.proplan.logger.Logger;
import com.fssa.proplan.model.User;
import com.fssa.proplan.service.UserService;
import com.fssa.proplan.validator.UserValidator;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Logger logger = new Logger();
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		System.out.println(email + "---------" + password);
		User user;
		UserService userService = new UserService(new UserDao(), new UserValidator());
		try {
			user = userService.login(email, password);

			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("username", user.getName());
				session.setAttribute("emailid", user.getEmailId());
				session.setAttribute("phno", user.getPhoneNumber());
				session.setAttribute("displayname", user.getDisplayName());
				session.setAttribute("profession", user.getProfession());
				session.setAttribute("password", user.getPassword());
				session.setAttribute("currentuser", user);
				logger.info(user.toString());
				RequestDispatcher rd = request.getRequestDispatcher("./profile.jsp");
				logger.info("logged in successfully");

				rd.forward(request, response);
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("./login.html");
				logger.info("User doesn't exist");

				rd.forward(request, response);
			}
		} catch (DaoException | UserException e) {
			RequestDispatcher rd = request.getRequestDispatcher("./login.html");
			logger.info(e.getMessage());
			e.printStackTrace();
			rd.forward(request, response);

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
