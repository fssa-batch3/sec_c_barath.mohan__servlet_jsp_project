package com.fssa.proplanweb.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.proplan.logger.Logger;

/**
 * Servlet implementation class HomePage
 */
@WebServlet("/HomePage")
public class HomePage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger= new Logger();
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		logger.info("Get method of Home Page Servlet : Redirecting to Home.jsp");
		response.sendRedirect("./home.jsp");
		
	}

	

}
