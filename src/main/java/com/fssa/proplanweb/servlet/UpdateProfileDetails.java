package com.fssa.proplanweb.servlet;

import java.io.IOException;

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
 * Servlet implementation class UpdateProfileDetails
 */
@WebServlet("/UpdateProfileDetails")
public class UpdateProfileDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		User user = new User();
		user.setDisplayName(request.getParameter("displayname"));
		user.setName(request.getParameter("name"));
		user.setEmailId(request.getParameter("email"));
		user.setPhoneNumber(request.getParameter("phno"));
		user.setProfession(request.getParameter("profession"));
		
		
		UserService userService=new UserService(new UserDao(),new UserValidator());
		try {
			userService.updateUser(user);
			System.out.println("User details is updated sucessfully");
			User user1 = userService.getUserByEmail(user.getEmailId());
			
			HttpSession session = request.getSession();
			session.setAttribute("username", user1.getName());
			session.setAttribute("emailid", user1.getEmailId());
			session.setAttribute("phno", user1.getPhoneNumber());
			session.setAttribute("displayname", user1.getDisplayName());
			session.setAttribute("profession", user1.getProfession());
			session.setAttribute("password", user1.getPassword());
			session.setAttribute("currentuser", user1);
			
		} catch (DaoException | UserException e) {
			System.out.println("User details is updation failed");
			e.printStackTrace();
		}
		
		response.sendRedirect("./profile.jsp");
		
	}
	

}
