package com.fssa.proplanweb.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fssa.proplan.dao.TransactionDao;
import com.fssa.proplan.dao.UserDao;
import com.fssa.proplan.exceptions.DaoException;
import com.fssa.proplan.model.Transaction;
import com.fssa.proplan.model.User;
import com.fssa.proplan.service.TransactionService;
import com.fssa.proplan.validator.TransactionValidator;

/**
 * Servlet implementation class TransactionRecords
 */
@WebServlet("/TransactionRecords")
public class TransactionRecords extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TransactionRecords() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		TransactionService transactionService = new TransactionService(new TransactionDao(), new TransactionValidator(),
				new UserDao());

		User user1 = new User("dhilip", "1234567890", "student", "barathdh@gmail.com", "baGra@t1");

		List<Transaction> details = null;
		try {
			details = transactionService.getExpenseTransactionDetails(user1);

		} catch (DaoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		PrintWriter pw = response.getWriter();

		for (Transaction s : details) {
			pw.print(s);
			pw.println("-------------------------");
		}
		

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
