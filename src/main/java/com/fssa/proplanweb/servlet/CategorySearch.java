package com.fssa.proplanweb.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import com.fssa.proplan.dao.BudgetDao;
import com.fssa.proplan.dao.UserDao;
import com.fssa.proplan.exceptions.DaoException;
import com.fssa.proplan.model.BudgetCategory;

@WebServlet("/CategorySearch")
public class CategorySearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String searchedValue = request.getParameter("searchValue");
		String email = request.getParameter("userEmail");
		BudgetDao budgetDao = new BudgetDao();
		try {
			ArrayList<BudgetCategory> categoryDetails = budgetDao
					.getBudgetCategoriesByUserId(UserDao.getUserIdByEmail(email));
			ArrayList<BudgetCategory> filteredCategoryDetails = new ArrayList<BudgetCategory>();
			for (BudgetCategory budgetCategory : categoryDetails) {
				if (budgetCategory.getCategoryName().startsWith(searchedValue)
						|| budgetCategory.getCategoryName().toLowerCase().startsWith(searchedValue)
						|| budgetCategory.getCategoryName().toUpperCase().startsWith(searchedValue)) {
					filteredCategoryDetails.add(budgetCategory);
				}
			}

			JSONArray jsonArray = new JSONArray(filteredCategoryDetails);
			
			out.print(jsonArray);
			out.flush();

		} catch (DaoException e) {

			e.printStackTrace();
		}

	}

}
