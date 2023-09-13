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

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		Logger.info("email :" + email + "///" + " Password :" + password);
		User user;
		UserService userService = new UserService(new UserDao(), new UserValidator());
		RequestDispatcher rd;
		try {
			user = userService.login(email, password);

			if (user != null) {
				HttpSession session = request.getSession();

				session.setAttribute("currentuser", user);

				Logger.info(user.toString());
				request.setAttribute("successMsg", "Logged in successfully");
				rd = request.getRequestDispatcher("./profile.jsp");

				Logger.info("logged in successfully");

			} else {
				request.setAttribute("errorMsg","Incorrect username or password");
				rd = request.getRequestDispatcher("./login.jsp");

				Logger.info("User doesn't exist");
				

			}
		} catch (DaoException | UserException e) {

			request.setAttribute("errorMsg",e.getMessage());
			rd = request.getRequestDispatcher("./login.jsp");

			Logger.info(e.getMessage());
			e.printStackTrace();

		}

		rd.forward(request, response);
	}

}
