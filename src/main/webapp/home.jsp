<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.fssa.proplan.validator.TransactionValidator"%>
<%@page import="com.fssa.proplan.dao.TransactionDao"%>
<%@page import="com.fssa.proplan.service.TransactionService"%>
<%@page import="com.fssa.proplan.validator.UserValidator"%>
<%@page import="com.fssa.proplan.dao.UserDao"%>
<%@page import="com.fssa.proplan.model.*"%>
<%@page import="com.fssa.proplan.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.fssa.proplan.*"%>
<%@page import="java.util.*"%>


<!DOCTYPE html>
<html lang="en">
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<link rel="stylesheet" href="./assets/css/style.css">
<title>Proplan</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="./assets/css/errormsg.css">

</head>

<body>
	<%
	User user = (User) session.getAttribute("currentuser");

	Budget budget = (Budget) session.getAttribute("budget");
	ArrayList<BudgetCategory> budgetCategories = new ArrayList<BudgetCategory>();
	double budgetPercentage = 0;
	double expensesAllowed = 0;
	if (budget != null) {

		budgetCategories = (ArrayList<BudgetCategory>) budget.getBudgetCategory();
		budgetPercentage = budget.getExpensePercentage();
		expensesAllowed = budget.getBudgetAmount();
	}

	double balance = (double) request.getAttribute("balance");

	double totalIncomeAmount = (double) request.getAttribute("totalIncomeAmount");
	double totalExpenseAmount = (double) request.getAttribute("totalExpenseAmount");
	double expensePercentage = ((totalExpenseAmount / totalIncomeAmount) * 100);

	double balancePercentage = (((totalIncomeAmount - totalExpenseAmount) / totalIncomeAmount) * 100);
	expensePercentage = Double.parseDouble(String.format("%.2f", expensePercentage));
	balancePercentage = Double.parseDouble(String.format("%.2f", balancePercentage));
	float incomeBarHeight = totalIncomeAmount > 0 ? 200 : 0;
	float budgetBarHeight = (float) budgetPercentage * 2;
	float expenseBarHeight = (float) expensePercentage * 2;

	List<Transaction> transactionDetails = (List<Transaction>) request.getAttribute("transactionDetails");
	Calendar cal = Calendar.getInstance();
	String currentMonth = new SimpleDateFormat("MMMMMMMMMMM").format(cal.getTime());
	%>
	<jsp:include page="./header.jsp"></jsp:include>
	<main>
		<!-- --------------left side div--------------- -->
		<jsp:include page="./sidebar.jsp"></jsp:include>

		<!----------------Add income expense form--------------->

		<form class="add_income_form " action="./AddIncomeServlet"
			method="POST">
			<h2>Add an Income</h2>
			<label for="income_type">Title <input type="text"
				id="income_type" name="remarks"
				placeholder="Ex: Salary /  Stock returns..," required></label><br>
			<p>Category:</p>
			<div class="income_category">
				<label for="salary"> <input type="radio" id="salary"
					name="income_category" value="Salary" required>Salary
				</label> <label for="stock_returns"> <input type="radio"
					id="stock_returns" name="income_category" value="Stock returns"
					required>Stock returns
				</label> <label for="commission"> <input type="radio"
					id="commission" name="income_category" value="Commission" required>Commission
				</label> <label for="lended_amount"> <input type="radio"
					id="lended_amount" name="income_category" value="Lended money"
					required>Lended money
				</label> <label for="other"> <input type="radio" id="other"
					name="income_category" value="Others" required>Others
				</label>
			</div>

			<label for="income_amount">Amount <input type="number"
				id="income_amount" placeholder="Ex: 1000/2000/3000...,"
				name="amount" required></label>
			<div class="button_div">
				<button type="submit" id="add_income_button" value="submit">Add
					Income</button>
				<a href="./HomePage" id="back_button"> Back</a>
			</div>
		</form>
		<!-- Adding expense form--------------------- -->
		<form class="add_expense_form" action="./AddExpenseServlet"
			method="POST">
			<h2>Add an Expense</h2>
			<label for="expense_type">Title <input type="text"
				id="expense_type" placeholder="Ex: movie,accessories..,"
				name="remarks" required>
			</label> <br>
			<p>Category:</p>
			<div class="expense_category">
				<%
				for (BudgetCategory category : budgetCategories) {
				%>
				<label for="<%=category.getCategoryName()%>"> <input
					type="radio" id="<%=category.getCategoryName()%>"
					name="expense_category" value="<%=category.getCategoryName()%>"
					required> <%=category.getCategoryName()%>
				</label>
				<%
				}
				%>

			</div>
			<label for="expense_amount">Amount <input type="number"
				id="expense_amount" placeholder="Ex: 1000/2000/3000...,"
				name="amount" required>
			</label>
			<div class="button_div">
				<button type="submit" id="add_expense_button" value="submit">Add
					Expense</button>
				<a href="./HomePage" id="back_button"> Back</a>
			</div>
		</form>

		<!--------------- Center Content ------------------ -->
		<div class="center_side">
			<h4>Overview</h4>
			<h2>
				Welcome <span id="name"><%=user.getName()%></span>
			</h2>
			<div class="homestats">
				<div id="homechart">
					<div class="div">
						<!-- <p class="hover_para"> ₹ 20,000</p> -->
						<div class="chart_div">
							<p>Total Income</p>
							<div class="total_income_chart chart_bars"
								style="height:<%=incomeBarHeight%>px"></div>
						</div>
					</div>
					<div class="chart_div">
						<p>Budget</p>
						<div class="total_income_chart chart_bars"
							style="height:<%=budgetBarHeight%>px"></div>
					</div>
					<div class="chart_div">
						<p>Total Expense</p>
						<div class="total_income_chart chart_bars"
							style="height:<%=expenseBarHeight%>px"></div>
					</div>
				</div>
				<div class="add">
					<div class="stats">
						<h4>
							Expenses - <span id="expense_percentage"><%=expensePercentage%>%</span>
						</h4>
						<h4>
							Balance - <span id="balance_percentage"><%=balancePercentage%>%</span>
						</h4>
					</div>
					<div class="stats">
						<p>
							Budget : <span id="budget_percentage"><%=budgetPercentage%>%</span>
						</p>
						<p>
							Expenses allowed : <span id="expenses_allowed"><%=expensesAllowed%></span>
						</p>
					</div>

					<!--  <div>
						<button id="add_income">
							<img src="./assets/images/icons/add.png" alt="icon">
						</button>
						<h3>ADD an Inflow</h3>
					</div>-->
					<div>
						<button id="add_expense">
							<img src="./assets/images/icons/add.png" alt="icon">
						</button>
						<h3>ADD an Outflow</h3>
					</div>
				</div>
			</div>

			<!-- -------------- Home Table------------- -->
			<div class="home_transactions">

				<h3>
					This month -
					<%=currentMonth%></h3>
				<table>

					<tr>
						<td>Sl.no</td>
						<td>Type</td>
						<td>Amount</td>
						<td>Date</td>
						<td>Balance</td>

					</tr>

					<tbody id="home_table_body">

						<%
						int count = 1;
						for (int i = transactionDetails.size() - 1; i >= 0; i--) {
							Transaction details = transactionDetails.get(i);
						%>
						<tr>
							<td><%=i + 1%></td>
							<td><%=details.getRemarks()%><br> <span><%=details.getTransactionType().getValue()%></span>
							</td>
							<td
								id="<%=details.getTransactionType().toString().toLowerCase()%>">&#8377;
								<%=details.getAmount()%></td>
							<td><%=details.getDate()%></td>
							<td id="balance">&#8377; <%=details.getBalance()%></td>

						</tr>
						<%
						}
						%>


					</tbody>
				</table>
			</div>
			<%
			if (transactionDetails == null) {
			%>
			<div class="nothing_to_show">
				<img src="./assets/images/icons/nothing_to_show.png"
					alt="nothing image">
				<p>Nothing to show here</p>
			</div>
			<%
			}
			%>

		</div>
		<!-- -----------Right Side Div ------------------ -->
		<jsp:include page="./profiletab.jsp"></jsp:include>
	</main>
	
	<script src="./assets/js/home.js"></script>

	<jsp:include page="./successErrorMsg.jsp"></jsp:include> 

</body>

</html>