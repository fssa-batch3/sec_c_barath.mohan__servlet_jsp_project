package com.fssa.proplanweb.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.proplan.dao.TransactionDao;
import com.fssa.proplan.dao.UserDao;
import com.fssa.proplan.enumclass.TransactionType;
import com.fssa.proplan.exceptions.DaoException;
import com.fssa.proplan.exceptions.TransactionException;
import com.fssa.proplan.logger.Logger;
import com.fssa.proplan.model.Transaction;
import com.fssa.proplan.model.User;
import com.fssa.proplan.service.TransactionService;
import com.fssa.proplan.validator.TransactionValidator;

/**
 * Servlet implementation class AddIncomeServlet
 */
@WebServlet("/AddIncomeServlet")
public class AddIncomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Logger.info("Calling get method");

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("currentuser");
		TransactionService transactionService = new TransactionService(new TransactionDao(), new TransactionValidator(),
				new UserDao());
		Transaction Transaction = new Transaction(user, TransactionType.INCOME,
				Double.parseDouble(request.getParameter("amount")), (String) request.getParameter("remarks"));
		try {
			transactionService.addTransaction(Transaction);
			Logger.info("Income has been successfully added");
			request.setAttribute("successMsg", "Income added successfully");
 
		} catch (DaoException | TransactionException e) {
			request.setAttribute("errorMsg", e.getMessage());
			
			Logger.info(e.getMessage());

			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("./home.jsp");
		rd.forward(request, response);

	}

}
