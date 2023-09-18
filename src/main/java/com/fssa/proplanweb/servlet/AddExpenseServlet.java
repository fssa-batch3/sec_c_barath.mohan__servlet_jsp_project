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
 * Servlet implementation class AddExpenseServlet
 */
@WebServlet("/AddExpenseServlet")
public class AddExpenseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("currentuser");
		if (user == null) {
			request.setAttribute("errorMsg", "Login / Session Expired");
			request.setAttribute("path", "./login.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("./login.jsp");
			rd.forward(request, response);
		} else {
			TransactionService transactionService = new TransactionService(new TransactionDao(),
					new TransactionValidator(), new UserDao());
			Transaction transaction = new Transaction();
			transaction.setAmount(Double.parseDouble(request.getParameter("amount")));
			transaction.setUser(user);
			transaction.setRemarks((String) request.getParameter("remarks"));
			transaction.setTransactionType(TransactionType.EXPENSE);
			transaction.setCategoryName(request.getParameter("expense_category"));
			try {
				transactionService.addTransaction(transaction);
				System.out.println("Expense has been successfully added");
				Logger.info("Expense has been successfully added");
				response.sendRedirect("./HomePage?successMsg=\"Expense added successfully\"");

			} catch (DaoException | TransactionException e) {
				response.sendRedirect("./HomePage?errorMsg=\"" + e.getMessage() + "\"");

				Logger.info(e.getMessage());
				e.printStackTrace();
			}
		}
	}

}
