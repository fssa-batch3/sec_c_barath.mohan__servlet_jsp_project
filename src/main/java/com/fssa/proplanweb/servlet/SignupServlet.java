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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		UserService userService = new UserService(new UserDao(),new UserValidator());
		User userDetails = new User();
		userDetails.setName(request.getParameter("name"));
		userDetails.setEmailId(request.getParameter("email"));
		userDetails.setPhoneNumber(request.getParameter("phNo"));
		userDetails.setProfession(request.getParameter("profession"));
		request.getParameterNames();

        Map<String, String[]> modelMap = request.getParameterMap();
        for(String key: modelMap.keySet()){
            System.out.println(key);
            System.out.println(" : ");
            System.out.println(modelMap.get(key).toString());
            System.out.println("");
        }
		;
		System.out.println(request.getParameter("pwd"));
		userDetails.setPassword(request.getParameter("pwd"));
		try {
			userService.addUser(userDetails);
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", userDetails);
			RequestDispatcher rd= request.getRequestDispatcher("./login.html");
			rd.forward(request, response);
		} catch (DaoException | UserException e) {
			
			RequestDispatcher rd= request.getRequestDispatcher("./signup.jsp");
			System.out.println(e.getMessage());
			rd.forward(request, response);
			e.printStackTrace();
		}
		
	}

}












