package com.fssa.proplanweb.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fssa.proplan.dao.BudgetDao;
import com.fssa.proplan.dao.TransactionDao;
import com.fssa.proplan.dao.UserDao;
import com.fssa.proplan.exceptions.DaoException;
import com.fssa.proplan.logger.Logger;
import com.fssa.proplan.model.Budget;
import com.fssa.proplan.model.Transaction;
import com.fssa.proplan.model.User;
import com.fssa.proplan.service.BudgetService;
import com.fssa.proplan.service.TransactionService;
import com.fssa.proplan.service.UserService;
import com.fssa.proplan.validator.BudgetValidator;
import com.fssa.proplan.validator.TransactionValidator;
import com.fssa.proplan.validator.UserValidator;

/**
 * Servlet implementation class HomePage
 */
@WebServlet("/HomePage")
public class HomePage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Logger.info("Get method of Home Page Servlet : Redirecting to Home.jsp");
		UserService userService = new UserService(new UserDao(), new UserValidator());
		TransactionService transactionService = new TransactionService(new TransactionDao(), new TransactionValidator(),
				new UserDao());
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentuser");
		if (user == null) {
			request.setAttribute("errorMsg", "Login / Session Expired");
			request.setAttribute("path", "./login.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("./login.jsp");
			rd.forward(request, response);
		} else {
			try { 
				double balance = transactionService.getBalance(user);
				double totalIncomeAmount = transactionService.getTotalIncome(user);
				double totalExpenseAmount = transactionService.getTotalExpense(user);
				List<Transaction> transactionDetails = transactionService.getAllTransactionDetails(user);
				request.setAttribute("transactionDetails", transactionDetails);
				request.setAttribute("balance", balance);
				request.setAttribute("totalIncomeAmount", totalIncomeAmount);
				request.setAttribute("totalExpenseAmount", totalExpenseAmount);
				Logger.info(balance + "---" + totalExpenseAmount + "--------" + totalIncomeAmount);

				BudgetService budgetService = new BudgetService(new BudgetValidator(), new BudgetDao(), new UserDao());
				Budget budget = budgetService.getBudgetByUser(user);
				session.setAttribute("budget", budget);
				System.out.println(request.getParameter("successMsg") + "  =-====servlet====-=   "
						+ request.getParameter("errorMsg"));
				if (request.getParameter("successMsg") != null) {
					request.setAttribute("successMsg", request.getParameter("successMsg"));
				}
				if (request.getParameter("errorMsg") != null) {
					request.setAttribute("errorMsg", request.getParameter("errorMsg"));
				}
				request.setAttribute("path", "./HomePage");

				RequestDispatcher rd = request.getRequestDispatcher("./home.jsp");

				rd.forward(request, response);
			} catch (DaoException e) {

				System.out.println(e.getMessage() + "  catch block");
				e.printStackTrace();
			}

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);

	}

}
