
<%
String currentPage = (String) request.getAttribute("page");
if (currentPage == null) {
	currentPage = "";
}
System.out.print("currentPage : " + currentPage);
%>
<div class="left_side">
	<div class="tabs">
		<%
		if (currentPage.equals("home.jsp")) {
		%>
		<a href="./HomePage" id="homeicon"> <img
			src="./assets/images/icons/white_home.png" alt="icons"> Home
		</a>

		<%
		} else {
		%>
		<a href="./HomePage"> <img src="./assets/images/icons/home.png"
			alt="icons"> Home
		</a>
		<%
		}
		%>


		<%
		if (currentPage.equals("analytics.jsp")) {
		%>
		<a href="analytics.jsp" id="expensesicon"> <img
			src="./assets/images/icons/analysis_white.png" alt="">Analytics
		</a>

		<%
		} else {
		%>
		<a href="analytics.jsp"> <img
			src="./assets/images/icons/statistics.png" alt="">Analytics
		</a>
		<%
		}
		%>

		<%
		if (currentPage.equals("budget.jsp")) {
		%>
		<a href="./BudgetServlet" id="budget_icon"> <img
			src="./assets/images/icons/white_budget_icon.png" alt="icons">
			Budget
		</a>

		<%
		} else {
		%>
		<a href="./BudgetServlet"> <img
			src="./assets/images/icons/budget.png" alt="icons"> Budget
		</a>
		<%
		}
		%>

		<%
		if (currentPage.equals("wallet.jsp")) {
		%>
		<a href="wallet.jsp" id="walleticon"> <img
			src="./assets/images/icons/wallet_white.png" alt="icons">
			Wallet
		</a>

		<%
		} else {
		%>
		<a href="wallet.jsp"> <img src="./assets/images/icons/savings.png"
			alt="icons"> Wallet
		</a>
		<%
		}
		%>




		<%
		if (currentPage.equals("notes.jsp")) {
		%>
		<a href="notes.jsp" id="notesicon"> <img
			src="./assets/images/icons/white_notes_icon.png" alt="icons">Notes
		</a>

		<%
		} else {
		%>
		<a href="notes.jsp"> <img src="./assets/images/icons/notes.png"
			alt="icons">Notes
		</a>
		<%
		}
		%>


		<%
		if (currentPage.equals("profile.jsp")) {
		%>
		<a href="./ProfileDetails" id="profile"> <img
			src="./assets/images/icons/white_user.png" alt="icons">
			Profile
		</a>

		<%
		} else {
		%>

		<a href="./ProfileDetails"> <img
			src="./assets/images/icons/profile.png" alt="icons"> Profile
		</a>
		<%
		}
		%>

		<%
		if (currentPage.equals("about.jsp")) {
		%>
		<a href="about.jsp" id="about_icon"> <img
			src="./assets/images/icons/white_about_icon.png" alt="icons">
			About
		</a>

		<%
		} else {
		%>

		<a href="about.jsp"> <img src="./assets/images/icons/about.png"
			alt="icons"> About
		</a>
		<%
		}
		%>


	</div>
</div>