package com.fssa.proplanweb.servlet;

import java.io.IOException;
import java.util.Map;
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
import com.fssa.proplan.model.User;
import com.fssa.proplan.service.UserService;
import com.fssa.proplan.validator.UserValidator;

/**
 * Servlet implementation class SignupServlet
 */

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String password = request.getParameter("pwd");
		String cpassword = request.getParameter("cpwd");
		if (!password.equals(cpassword)) {
			request.setAttribute("errorMsg","Password and Confirm password doesn't match");
			request.setAttribute("path", "./signup.jsp");
		}
		else {
			UserService userService = new UserService(new UserDao(), new UserValidator());
			User userDetails = new User();
			userDetails.setName(request.getParameter("name"));
			userDetails.setEmailId(request.getParameter("email"));
			userDetails.setPhoneNumber(request.getParameter("phNo"));
			userDetails.setProfession(request.getParameter("profession"));
			request.getParameterNames();

			Map<String, String[]> modelMap = request.getParameterMap();
			for (String key : modelMap.keySet()) {
				System.out.println(key);
				System.out.println(" : ");
				System.out.println(modelMap.get(key).toString());
				System.out.println("");
			}
			;
			System.out.println(request.getParameter("pwd"));
			userDetails.setPassword(password);
			userDetails.setPassword(cpassword);

			try {
				userService.addUser(userDetails);
				HttpSession session = request.getSession();
				session.setAttribute("currentUser", userDetails);
				request.setAttribute("successMsg", "Account created successfully!");
				request.setAttribute("path", "./login.jsp");

			} catch (DaoException | UserException e) {
				request.setAttribute("errorMsg", e.getMessage());
				request.setAttribute("path", "./signup.jsp");

				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("./signup.jsp");

		rd.forward(request, response);
	}

}
