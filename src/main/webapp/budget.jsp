<%@page import="com.fssa.proplan.model.BudgetCategory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.fssa.proplan.logger.Logger"%>
<%@page import="com.fssa.proplan.model.Budget"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Proplan - Budget</title>
<link rel="stylesheet" href="./assets/css/style.css">
<link rel="stylesheet" href="./assets/css/budget.css">
<link rel="stylesheet" href="./assets/css/errormsg.css">
</head>
<body>
	<%
	Budget budget = (Budget) session.getAttribute("budget");
	double budgetAmount = 0;
	double totalAmountSpent = 0;
	double monthlyIncome = 0;
	double expensePercentage = 0;
	double totalAmountSpentPercentage = 0;
	double totalAmountSpentPercentageChart=0;
	ArrayList<BudgetCategory> budgetCategories = new ArrayList<BudgetCategory>();
	if (budget != null) {
		budgetAmount = budget.getBudgetAmount();
		totalAmountSpent = budget.getAmountSpent();
		monthlyIncome = budget.getMonthlyIncome();
		expensePercentage = budget.getExpensePercentage();
		totalAmountSpentPercentage = (totalAmountSpent / budgetAmount) * 100;
		totalAmountSpentPercentageChart= (totalAmountSpent/budgetAmount)*120;
		budgetCategories = (ArrayList<BudgetCategory>) budget.getBudgetCategory();
	}

	Logger.info(budget);
	%>
	<jsp:include page="./header.jsp"></jsp:include>
	<main>
		<!-- --------------left side div--------------- -->
		<jsp:include page="./sidebar.jsp"></jsp:include>
		<div class="center_content">
			<div class="budget_header">
				<h3>Budget Planner</h3>
				<%
				if (budget == null) {
				%>
				<p id="create_budget">Create a Budget Plan</p>
				<%
				}
				else{
				%>
				<p id="edit_budget">Edit your Budget Plan</p>
				<%
				}%>

			</div>
			<div class="total_income_show">
				<p>Income</p>
				<p id="monthly_income_value">
					&#8377;
					<%=monthlyIncome%>
					/-
				</p>
			</div>

			<div class="budget_content1">

				<div class="total_expenses_allowed content1_d">
					<p>Total Expenses allowed</p>
					<p>
						<span id="total_expenses_allowed">&#8377; <%=budgetAmount%>/-
						</span> <span id="total_expenses_allowed_percen"> <%=expensePercentage%>%
						</span>
					</p>
				</div>

				<div class="difference_chart">
					<div class=" expenses_allowed bar_chart"></div>
					<div class="expenses_spent bar_chart" style="height:<%=totalAmountSpentPercentageChart%>px" ></div>
				</div>

				<div class="totally_spent content1_d">
					<p>Total Amount spent</p>
					<p>
						<span id="totally_spent">&#8377; <%=totalAmountSpent%>/-
						</span> <span id="total_expenses_spent_percen"> <%=totalAmountSpentPercentage%>%
						</span>
					</p>
				</div>

			</div>
			<hr>

			<!-- ----------Each catregory data------------- -->

			<div class="categories_compare">
				<div class="categories_compare_header">
					<h2>Categories</h2>
					
				</div>
				<div class="categories_data">

					<!-- ----------- nothing to show----------- -->
					<%
					if (budget == null) {
					%>
					<div class="nothing_to_show">
						<img src="./assets/images/icons/nothing_to_show.png"
							alt="nothing image">
						<p>Nothing to show here</p>
					</div>
					<%
					}
					%>
					<%
					int i=0;
					for (BudgetCategory category : budgetCategories) {
						i++;
					%>
					<div class="cateogory_details">
						<h3>
							<%=i %>.
							<%=category.getCategoryName()%></h3>
						<p>
							Budget - &#8377;
							<%=category.getBudgetAmount()%>/-
						</p>
						<p>
							Spent - &#8377;
							<%=category.getAmountSpent()%>/-
						</p>
						<div class="category_chart">
							<div class="expenses_allowed"></div>
							<div class="expenses_spent"></div>
						</div>
					</div>
					<%
					

					}
					%>



				</div>
			</div>

		</div>

		<!--  ----------Budget Form----------- -->
		<form class="budget" action="./BudgetServlet" method="post">
			<h3>Create your Budget plan</h3>

			<div class="flex">
				<p>Your Monthly Income</p>
				<input type="number" placeholder="ex,30,000/-..."
					id="monthly_income" name="monthlyIncome">
			</div>
			<hr>
			<span class="next_step"> Next <img
				src="./assets/images/icons/down_arrow_white.png" alt="">
			</span>

			<!--  ------Next 1------ -->

			<div class="budget_set">
				<h3>Set Your Monthly budget</h3>
				<p>Expenses : : Savings</p>
				<div id="budget_input">
					<input type="range" id="budget_range" min="10" max="90" step="5"
						list="budget_range_list" value="80" required
						name="expensePercentage">

					<datalist id="budget_range_list">
						<option value="10">10%</option>
						<option value="30">30%</option>
						<option value="50">50%</option>
						<option value="70">70%</option>
						<option value="90">90%</option>
					</datalist>
				</div>
				<div class="flex">
					<p>
						Expenses <br> <span id="expenses_change_value">60%
							/2000/-</span>
					</p>
					<p>
						Savings <br> <span id="savings_change_value"></span>
					</p>
				</div>
				<hr>
				<span class="next_step"> Next <img
					src="./assets/images/icons/down_arrow_white.png" alt="">
				</span>
			</div>


			<!--  ------Next 1------ -->
			<div class="category_create_sec">


				<div class="category_create">
					<div class="category_create_header">
						<p>Categorize Your Expense</p>
						<p>
							Remaining: <span id="remaining_amount"></span>
						</p>
					</div>

					<div class="create_category_feild">
						<input type="text" class="budget_category"
							placeholder="ex,Shopping.." name="categoryName"> <input
							type="number" class="budget_value" placeholder="ex,4000/-..."
							name="categoryBudget">
					</div>
					<div class="create_category_feild">
						<input type="text" class="budget_category"
							placeholder="ex,Shopping.." name="categoryName"> <input
							type="number" class="budget_value" placeholder="ex,4000/-..."
							name="categoryBudget">
					</div>
				</div>
				<p id="add_category">Add a category</p>
				<div class="save_category_details">
					<p class="back">Back</p>
					<button id="save_category_details" type="submit">Save</button>
				</div>
			</div>
		</form>

		<!-- -------------- Edit budget form---------------- -->

		<div class="edit_budget_form">
			<h3>Edit your Budget plan</h3>

			<div class="flex">
				<p>Your Monthly Income</p>
				<input type="number" placeholder="ex,30,000/-..."
					id="updated_monthly_income">
			</div>
			<hr>
			<span class="updated_next_step"> Next <img
				src="./assets/images/icons/down_arrow_white.png" alt="">
			</span>

			<div class=" updated_budget_values not_view">
				<h3>Your Monthly budget</h3>
				<p>Expenses : : Savings</p>
				<div id="budget_input">
					<input type="range" id="updated_budget_range" min="10" max="90"
						step="5" list="budget_range_list" value="80" required>

					<datalist id="budget_range_list">
						<option value="10">10%</option>
						<option value="30">30%</option>
						<option value="50">50%</option>
						<option value="70">70%</option>
						<option value="90">90%</option>
					</datalist>
				</div>
				<div class="flex">
					<p>
						Expenses <br> <span id="updated_expenses_change_value">0%
							/0/-</span>
					</p>
					<p>
						Savings <br> <span id="updated_savings_change_value">0%
							/0/-</span>
					</p>
				</div>
				<hr>
				<span class="updated_next_step"> Next <img
					src="./assets/images/icons/down_arrow_white.png" alt="">
				</span>
			</div>
			<div class="updated_category_values not_view">
				<div class="category_values ">
					<div class="category_values_header">
						<p>Your Categorized Expenses</p>
						<p>
							Remaining : <span id="updated_remaining_amount"></span>
						</p>
					</div>

					<!--  content comes from js -->
				</div>
				<p id="updated_add_category">Add a category</p>
				<div class="save_category_details">
					<p class="back">Back</p>
					<p id="update_category_details">update</p>
				</div>
			</div>


		</div>

	</main>
	<jsp:include page="./successErrorMsg.jsp"></jsp:include>

</body>
<script src="./assets/js/budget.js"></script>


</html>
