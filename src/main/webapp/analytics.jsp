<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,500,0,0">
<link rel="stylesheet" href="./assets/css/analytics.css">
<link rel="stylesheet" href="./assets/css/style.css">

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<title>Proplan</title>

</head>

<body>
	
	<jsp:include page="./header.jsp"></jsp:include>
	<main>
		<!-- --------------left side div--------------- -->
		<jsp:include page="./sidebar.jsp"></jsp:include>
	

		<!--------------------Center Side--------------->
		<div class="center_content">
			<h2>Statistics</h2>
			<div class="month-scroll">
				<img src="./assets/images/icons/Arrow-left.svg" alt="ICON">
				<div class="month">
					<h4>May</h4>
					<p>2022</p>
				</div>
				<div class="month">
					<h4>Jun</h4>
					<p>2022</p>
				</div>
				<div class="month ">
					<h4>July</h4>
					<p>2023</p>
				</div>
				<div class="month ">
					<h4>Sept</h4>
					<p>2022</p>
				</div>
				<div class="month">
					<h4>OCT</h4>
					<p>2022</p>
				</div>
				<div class="month">
					<h4>NOV</h4>
					<p>2022</p>
				</div>
				<div class="month">
					<h4>DEC</h4>
					<p>2022</p>
				</div>
				<div class="month active_month">
					<h4>JAN</h4>
					<p>2023</p>
				</div>
				<img src="./assets/images/icons/arrow-right.svg" alt="ICON">

			</div>
			<!-- Graphh------------- -->
			<div class="total_graph_div">
				<canvas id="total_graph"></canvas>
				<div class="bar">
					<div class="bar_list">
						<div class="category_color color_8"></div>
						<p>Expenses</p>
					</div>
					<div class="bar_list">
						<div class="category_color color_9"></div>
						<p>Income</p>
					</div>
				</div>
			</div>

			<!-- Category lists------------------ -->

			<!--  expense category-------------- -->
			<h3>Expenses</h3>

			<div class="expense_header">
				<p>
					Total Expenses : <span class="total_expense_value"> 0/-</span>
				</p>
				<p id="create_expense_category">View Category Budget</p>
			</div>

			<div class="expense_categories">
				<!-- <div class="every_expense_category">
                    <div class="expense_category_header">
                        <p class="expense_category_name">Home</p>
                        <div class="amount">
                            <p class="expense_category_spending">2000/-</p>
                            <img src="../images/icons/arrow_down.png" alt="icon">
                        </div>
                    </div>
                    <div class="expense_category_details">
                        <div class="each_expense_details">
                            <p>Rent <span class="each_expense_value">0/-</span></p>
                            <p>Rent <span class="each_expense_value">0/-</span></p>
                            <p>Rent <span class="each_expense_value">0/-</span></p>
                            <p>Rent <span class="each_expense_value">0/-</span></p>
                            <p>Rent <span class="each_expense_value">0/-</span></p>
                        </div>
                        <div class="each_category_total_value">
                            <p>Total <span class="each_expense_total">0/-</span></p>
                        </div>
                    </div>
                </div> -->

			</div>

			<!--  pie chart for the expense category ----------- -->
			<div class="expense_category_chart">
				<canvas id="categorychart"></canvas>
				<div class="cate_lists">
					<div class="category_lists"></div>
					<div class="expenses_total">
						Total Expenses : <span class="total_expense_value">0/-</span>
					</div>
				</div>

			</div>
			<!--  Income category-------------- -->
			<h3>Inflows</h3>

			<div class="income_header">
				<p>
					Total Income : <span class="total_income_value">0/-</span>
				</p>
				<!-- <p id="create_income_category"></p> -->
			</div>
			<div class="income_categories"></div>

			<!-- Piechart for the income category-------- -->

			<div class="income_category_chart">
				<canvas id="incomecategorychart"></canvas>
				<div class="cate_lists">
					<div class="category_lists"></div>
					<div class="income_total">
						Total Amount of Inflows : <span class="total_income_value">0/-</span>
					</div>
				</div>
			</div>

		</div>

	</main>
	<script src="./assets/js/common.js"></script>
	<script src="./assets/js/analytics.js"></script>
</body>

</html>