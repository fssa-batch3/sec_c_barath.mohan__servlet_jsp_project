<%@page import="com.fssa.proplan.validator.TransactionValidator"%>
<%@page import="com.fssa.proplan.dao.TransactionDao"%>
<%@page import="com.fssa.proplan.service.TransactionService"%>
<%@page import="com.fssa.proplan.validator.UserValidator"%>
<%@page import="com.fssa.proplan.dao.UserDao"%>
<%@page import="com.fssa.proplan.model.*"%>
<%@page import="com.fssa.proplan.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.fssa.proplan.*"%>
<%@ page import="java.util.*"%>
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
	UserService userService = new UserService(new UserDao(), new UserValidator());
	TransactionService transactionService = new TransactionService(new TransactionDao(), new TransactionValidator(),
			new UserDao());
	
	User user = (User) session.getAttribute("currentuser");
	double balance = transactionService.getBalance(user);
	
	double totalIncomeAmount = transactionService.getTotalIncome(user);
	double totalExpenseAmount = transactionService.getTotalExpense(user);
	double expensePercentage = ((totalExpenseAmount / totalIncomeAmount) * 100);
	
	double balancePercentage = (((totalIncomeAmount - totalExpenseAmount) / totalIncomeAmount) * 100);
	expensePercentage = Double.parseDouble(String.format("%.2f", expensePercentage));
	balancePercentage = Double.parseDouble(String.format("%.2f", balancePercentage));
	float incomeBarHeight= totalIncomeAmount>0 ?200:0;
	
	float expenseBarHeight= (float)expensePercentage*2;
	
	
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
				<a href="./home.jsp" id="back_button"> Back</a>
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

				<label for="utilities"> <input type="radio" id="utilities"
					name="expense_category" value="Utilities" required>Utilities
				</label> <label for="travel"> <input type="radio" id="travel"
					name="expense_category" value="Travel">Travel
				</label> <label for="insurance"> <input type="radio" id="insurance"
					name="expense_category" value="Insurance">Insurance
				</label> <label for="rent"> <input type="radio" id="rent"
					name="expense_category" value="Rent">Rent
				</label> <label for="maintenance"> <input type="radio"
					id="maintenance" name="expense_category" value="Maintenance">Maintenance
				</label> <label for="goods"> <input type="radio" id="goods"
					name="expense_category" value="Goods / Products">Goods /
					Products
				</label> <label for="entertainment"> <input type="radio"
					id="entertainment" name="expense_category" value="Entertainment">Entertainment
				</label> <label for="charges"> <input type="radio" id="charges"
					name="expense_category" value="Charges / Fees">Charges /
					Fees
				</label> <label for="others"> <input type="radio" id="others"
					name="expense_category" value="Others">Others
				</label>
			</div>
			<label for="expense_amount">Amount <input type="number"
				id="expense_amount" placeholder="Ex: 1000/2000/3000...,"
				name="amount" required>
			</label>
			<div class="button_div">
				<button type="submit" id="add_expense_button" value="submit">Add
					Expense</button>
				<a href="./home.jsp" id="back_button"> Back</a>
			</div>
		</form>

		<!--------------- Center Content ------------------ -->
		<div class="center_side">
			<h3>Overview</h3>
			<h1>
				Welcome <span id="name"><%=user.getName()%></span>
			</h1>
			<div class="homestats">
				<div id="homechart">
					<div class="div">
						<!-- <p class="hover_para"> ₹ 20,000</p> -->
						<div class="chart_div">
							<p>Total Income</p>
							<div class="total_income_chart chart_bars" style="height:<%=incomeBarHeight%>px"></div>
						</div>
					</div>
					<div class="chart_div">
						<p>Budget</p>
						<div class="total_income_chart chart_bars" ></div>
					</div>
					<div class="chart_div">
						<p>Total Expense</p>
						<div class="total_income_chart chart_bars"style="height:<%=expenseBarHeight%>px"></div>
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
							Budget : <span id="budget_percentage"></span>
						</p>
						<p>
							Expenses allowed : <span id="expenses_allowed"></span>
						</p>
					</div>

					<div>
						<button id="add_income">
							<img src="./assets/images/icons/add.png" alt="icon">
						</button>
						<h3>ADD an Inflow</h3>
					</div>
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

				<h2>This month - January</h2>
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
						List<Transaction> transactionDetails = transactionService.getAllTransactionDetails(user);
						System.out.println(transactionDetails);
						for (int i = transactionDetails.size() - 1; i >= 0; i--) {
							Transaction details = transactionDetails.get(i);
						%>
						<tr>
							<td><%=i + 1%></td>
							<td><%=details.getRemarks()%><br> <span><%=details.getTransactionType().getStringValue()%></span>
							</td>
							<td
								id="<%=details.getTransactionType().toString().toLowerCase()%>"><%=details.getAmount()%></td>
							<td><%=details.getDate()%></td>
							<td id="balance"><%=details.getBalance()%></td>

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
	<script src="https://smtpjs.com/v3/smtp.js"></script>
	<script src="./assets/js/home.js"></script>
	<script src="./assets/js/notify.js"></script>
	<script>
	<%
	String errorMsg = (String) request.getAttribute("errorMsg");
	String successMsg = (String) request.getAttribute("successMsg");

	System.out.println((String) request.getAttribute("errorMsg")+"  before   ");
	
	
	
	if (errorMsg != null) {%>
		console.log("<%=errorMsg%>");
		Notify.error("<%=errorMsg%>");
		setInterval(() => {
			window.location.href="./home.jsp";
		}, 4500);
		
		<%
		request.removeAttribute("errorMsg");
		System.out.println((String) request.getAttribute("errorMsg")+"jskbdhfuvcjyh");
		errorMsg=null;
		System.out.print(errorMsg+"jnd");
	}%>
		
		<%
		if ( successMsg!= null) {%>
		console.log("<%=successMsg%>");
		Notify.success("<%=successMsg%>");
		setInterval(() => {
			window.location.href="./home.jsp";
		}, 4500);
		
		<%}%>
		
		

	</script>

</body>

</html>