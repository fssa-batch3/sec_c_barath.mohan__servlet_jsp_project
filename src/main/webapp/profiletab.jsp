<%@page import="java.time.LocalDate"%>
<%@page import="com.fssa.proplan.validator.TransactionValidator"%>
<%@page import="com.fssa.proplan.dao.TransactionDao"%>
<%@page import="com.fssa.proplan.service.TransactionService"%>
<%@page import="com.fssa.proplan.validator.UserValidator"%>
<%@page import="com.fssa.proplan.dao.UserDao"%>
<%@page import="com.fssa.proplan.model.User"%>
<%@page import="com.fssa.proplan.service.UserService"%>
<%
String displayName= (String)session.getAttribute("displayname");
String userName=(String) session.getAttribute("username");
String phNo= (String)session.getAttribute("phno");
String emailId= (String)session.getAttribute("emailid");
String profession= (String)session.getAttribute("profession");
String password=(String) session.getAttribute("password");
UserService userService = new UserService(new UserDao(), new UserValidator());
TransactionService transactionService= new TransactionService(new TransactionDao(), new TransactionValidator(), new UserDao());
User user = (User) session.getAttribute("currentuser");
double balance = transactionService.getBalance(user);
double totalIncomeAmount = transactionService.getTotalIncome(user);
double totalExpenseAmount = transactionService.getTotalExpense(user);


%>
<div class="right_side">
	<div class="right_side_1">
		<div class="profile">
			<img src="./assets/images/tony.jpg" alt="profile img">
		</div>
		<h2 id="displayy_name"><%=userName!=null?userName:""%></h2>
		<h5 id="professionn"><%=profession!=null?profession:""%></h5>
		<div class="this_month">
			<h5>This month</h5>
			<h5><%=LocalDate.now().getMonth() %></h5>
		</div>
		<div class="total_balance">
			<p>Total Balance</p>
			<h1>
				&#x20B9; <span id="total_balance"><%=balance %></span>
			</h1>
		</div>
		<div class="total_income">
			<p>Total Income</p>
			<h1>
				&#8377;<span id="total_income"><%=totalIncomeAmount %></span>
			</h1>
		</div>
		<div class="total_expense">
			<p>Total Expense</p>
			<h1>
				&#8377;<span id="total_expense"><%=totalExpenseAmount %></span>
			</h1>
		</div>
	</div>
</div>