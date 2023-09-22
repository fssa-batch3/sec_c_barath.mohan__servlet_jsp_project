package com.fssa.proplanweb.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.proplan.dao.BudgetDao;
import com.fssa.proplan.dao.UserDao;
import com.fssa.proplan.exceptions.DaoException;
import com.fssa.proplan.exceptions.UserException;
import com.fssa.proplan.logger.Logger;
import com.fssa.proplan.model.Budget;
import com.fssa.proplan.model.User;
import com.fssa.proplan.service.BudgetService;
import com.fssa.proplan.service.UserService;
import com.fssa.proplan.validator.BudgetValidator;
import com.fssa.proplan.validator.UserValidator;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BudgetService budgetService = new BudgetService(new BudgetValidator(), new BudgetDao(), new UserDao());
	UserService userService = new UserService(new UserDao(), new UserValidator());

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");
		if(email==null&& password==null) {
			response.sendRedirect("./login.jsp");
		}
		else {
			
			Logger.info("email :" + email + "///" + " Password :" + password);
			User user;

			RequestDispatcher rd;
			try {
				user = userService.login(email, password);

				if (user != null) {
					HttpSession session = request.getSession();

					session.setAttribute("currentuser", user);
					Budget budget = budgetService.getBudgetByUser(user);

					session.setAttribute("budget", budget);

					Logger.info(user.toString());
					request.setAttribute("successMsg", "Logged in successfully");
					request.setAttribute("path", "ProfileDetails");
					rd = request.getRequestDispatcher("./ProfileDetails");

					Logger.info("logged in successfully");

				} else {
					request.setAttribute("errorMsg", "Incorrect username or password");
					request.setAttribute("path","./login.jsp");
					rd = request.getRequestDispatcher("./login.jsp");

					Logger.info("User doesn't exist");

				}
			} catch (DaoException | UserException e) {

				request.setAttribute("errorMsg", e.getMessage());
				request.setAttribute("path", "./login.jsp");
				rd = request.getRequestDispatcher("./login.jsp");

				Logger.info(e.getMessage());
				e.printStackTrace();

			}

			rd.forward(request, response);
		}

		
	}

}
