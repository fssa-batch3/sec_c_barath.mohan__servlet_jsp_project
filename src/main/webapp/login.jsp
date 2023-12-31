<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="./assets/css/login-signup.css">
<link rel="stylesheet" href="./assets/css/errormsg.css">
<title>login</title>
<style>
.right {
	padding-top: 50px;
}
</style>
</head>

<body>
	<div id="circle"></div>
	<main>
		<div class="top">
			<a href=""> <img src="./assets/images/icons/proplan_logo.png"
				alt="icon">
			</a>
			<p>
				Don't have a account? <a href="./signup.jsp">Sign Up</a>
			</p>
		</div>
		<div class="maincontainer">
			<div class="left">
				<img src="./assets/images/signup_image.jpg" alt="img">
			</div>
			<div class="right">
				<h2>Log In !</h2>
				<h5>Enter your details</h5>
				<form id="check" action="./LoginServlet" method="GET">
					<div class="form-floating mb-3">
						<input type="email" class="form-control input" id="email"
							placeholder="Email id" name="email" required> <label
							for="email">Email id</label>
					</div>
					<div class="password">
						<div class="form-floating mb-3">
							<input type="password" class="form-control input password_input"
								id="password" placeholder="Enter password" name="password"
								required> <label for="password">Enter password</label>
						</div>
						<img src="./assets/images/icons/invisible.png" alt="icon"
							id="pass_close"> <img src="./assets/images/icons/eye.png"
							alt="icon" id="pass_open">
					</div>
					<button type="submit">Log in</button>
					<h5>OR</h5>
				</form>

				<div class="bottom">
					<span>Login with</span> <a href="#"> <img
						src="./assets/images/icons/google icon.png" alt="icons">
					</a> <a href="#"> <img src="./assets/images/icons/fb icon.png"
						alt="icons">
					</a> <a href="#"> <img src="./assets/images/icons/twitter icon.png"
						alt="icons">
					</a>

				</div>
			</div>
		</div>

	</main>

	<script src="./assets/js/signup.js"></script>
	<script src="./assets/js/notify.js"></script>
	<jsp:include page="./successErrorMsg.jsp"></jsp:include>

</body>
</html>