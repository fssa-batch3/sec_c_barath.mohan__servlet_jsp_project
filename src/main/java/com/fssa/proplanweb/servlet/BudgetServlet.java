package com.fssa.proplanweb.servlet;

import java.io.IOException;
import java.util.ArrayList;

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
import com.fssa.proplan.enumclass.TransactionType;
import com.fssa.proplan.exceptions.BudgetValidationException;
import com.fssa.proplan.exceptions.DaoException;
import com.fssa.proplan.exceptions.TransactionException;
import com.fssa.proplan.logger.Logger;
import com.fssa.proplan.model.Budget;
import com.fssa.proplan.model.BudgetCategory;
import com.fssa.proplan.model.Transaction;
import com.fssa.proplan.model.User;
import com.fssa.proplan.service.BudgetService;
import com.fssa.proplan.service.TransactionService;
import com.fssa.proplan.validator.BudgetValidator;
import com.fssa.proplan.validator.TransactionValidator;

/**
 * Servlet implementation class BudgetServlet
 */
@WebServlet("/BudgetServlet")
public class BudgetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	BudgetService budgetService = new BudgetService(new BudgetValidator(), new BudgetDao(), new UserDao());
	TransactionService transactionService = new TransactionService(new TransactionDao(), new TransactionValidator(),
			new UserDao());
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("currentuser");
		if (user == null) {
			request.setAttribute("errorMsg", "Login / Session Expired");
			request.setAttribute("path", "./login.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("./login.jsp");
			rd.forward(request, response);
		} else {
			try { 
				Budget budget = budgetService.getBudgetByUser(user);

				session.setAttribute("budget", budget);

			} catch (DaoException e) {
				Logger.info(e.getMessage());
				e.printStackTrace();
			}
			response.sendRedirect("./budget.jsp");
		}
	}

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
			double expensePercentage = Double.parseDouble(request.getParameter("expensePercentage"));
			double monthlyIncome = Double.parseDouble(request.getParameter("monthlyIncome"));
			double budgetAmount = (monthlyIncome * (expensePercentage / 100));
			Budget budget = new Budget();
			budget.setBudgetAmount(budgetAmount);
			budget.setMonthlyIncome(monthlyIncome);
			budget.setExpensePercentage(expensePercentage);
			budget.setSavingsPercentage(100 - expensePercentage);

			budget.setUser(user);
			String[] categoryNames = request.getParameterValues("categoryName");
			String[] categoryBudgets = request.getParameterValues("categoryBudget");

			ArrayList<BudgetCategory> budgetCategories = new ArrayList<BudgetCategory>();

			for (int i = 0; i < categoryNames.length; i++) {
				BudgetCategory budgetCategory = new BudgetCategory();
				budgetCategory.setCategoryName(categoryNames[i]);
				budgetCategory.setBudgetAmount(Double.parseDouble(categoryBudgets[i]));
				budgetCategory.setAmountSpent(0);
				budgetCategories.add(budgetCategory);
			}
			budget.setBudgetCategory(budgetCategories);

			Logger.info(budget);

			Transaction transaction =new Transaction();
			transaction.setAmount(monthlyIncome);
			transaction.setUser(user);
			transaction.setRemarks("Monthly Income");
			transaction.setTransactionType(TransactionType.INCOME);
			try {
				transactionService.addTransaction(transaction);
				budgetService.createBudget(budget);
				System.out.println("budget created successfully!");
				request.setAttribute("successMsg", "Budget created successfully");

			} catch (DaoException | BudgetValidationException | TransactionException e) {
				System.out.println("Create Budget Failed");
				request.setAttribute("errorMsg", e.getMessage());

				e.printStackTrace();
			}
			request.setAttribute("path", "./BudgetServlet");
			RequestDispatcher rd = request.getRequestDispatcher("./budget.jsp");
			rd.forward(request, response);
		}
	}
}
