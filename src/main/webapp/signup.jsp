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
<title>Sign-up</title>
<link rel="stylesheet" href="./assets/css/login-signup.css">

</head>

<body>
	<div id="circle"></div>
	<main>
		<div class="top">
			<a href=""> <img src="./assets/images/icons/proplan_logo.png"
				alt="icon">
			</a>
			<p>
				Already have a account? <a href="./login.jsp">Log in </a>
			</p>
		</div>
		<div class="maincontainer">
			<div class="left">
				<img src="./assets/images/signup image.jpg" alt="img">
			</div>
			<div class="right">
				<h2>Get Started !</h2>
				<h5>Enter your details</h5>
				<form id="signup_form" action="./SignupServlet" method="POST">

					<div class="form-floating mb-3">
						<input type="text" class="form-control input" id="name"
							pattern="(?=.*\ d)(?=.*[a-z])(?=.*[A-Z]).{2,}"
							Title="1.Don't enter numbers, 2.Must include a uppercase character"
							placeholder="enter your name" name="name" required> <label
							for="name">Enter your name</label>
					</div>

					<div class="form-floating mb-3">
						<input type="email" class="form-control input" id="email"
							placeholder="Email id" name="email" required> <label
							for="email">Email id</label>
					</div>

					<div class="form-floating mb-3">
						<input type="text" class="form-control input" id="Profession"
							title="Enter the type of occupation" placeholder="Profession"
							pattern="(?=.*\ d)(?=.*[a-z])(?=.*[A-Z]).{2,}" name="profession"
							required> <label for="Profession">Profession</label>
					</div>
					<div class="form-floating mb-3">
						<input type="tel" class="form-control input" id="phone_num"
							pattern="[0-9]{10}"
							title="1.Enter Numbers only, 2.Must enter 10 numbers"
							placeholder="Mobile Number" name="phNo" required> <label
							for="phone_num">Mobile Number</label>
					</div>

					<div class="password">
						<div class="form-floating mb-3">
							<input name="pwd" type="password" class="form-control input"
								id="password"
								pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
								title="Enter a password mixed of uppercase characters, lowercase characters and Numbers with min 8 characters"
								placeholder="Enter password" required> <label
								for="password">Enter password</label>
						</div>

						<div class="form-floating mb-3">
							<input type="password" class="form-control input" id="cpassword"
								placeholder="Confirm password" name="cpwd" required> <label
								for="cpassword">Confirm password</label>
						</div>
						<img src="./assets/images/icons/invisible.png" alt="icon"
							id="pass_close"> <img src="./assets/images/icons/eye.png"
							alt="icon" id="pass_open">
					</div>

					<button type="submit" value="submit">Sign Up</button>
					<h5>OR</h5>
				</form>
				<div class="bottom">
					<span>Signin with</span> <a href="#"> <img
						src="./assets/images/icons/google icon.png" alt="">
					</a> <a href="#"> <img src="./assets/images/icons/fb icon.png"
						alt="">
					</a> <a href="#"> <img src="./assets/images/icons/twitter icon.png"
						alt="">
					</a>
				</div>
			</div>
		</div>
	</main>
</body>
<jsp:include page="./successErrorMsg.jsp"></jsp:include>
<script src="assets/js/signup.js"></script>
</html>