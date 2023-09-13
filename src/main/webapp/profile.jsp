<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="com.fssa.proplan.model.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./assets/css/style.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="./assets/css/profile.css">
<link rel="stylesheet" href="./assets/css/errormsg.css">
<title>Proplan</title>
</head>

<body>
	<%
	User user= (User) session.getAttribute("currentuser");
	String displayName = user.getDisplayName();
	String userName = user.getName();
	String phNo = user.getPhoneNumber();
	String emailId = user.getEmailId();
	String profession =user.getProfession();
	%>

	<jsp:include page="./header.jsp"></jsp:include>
	<main>
		<!-- --------------left side div--------------- -->
		<jsp:include page="./sidebar.jsp"></jsp:include>
		<!----------------center content div----------------->
		<div class="center_side">

			<div class="left_content">
				<img src="./assets/images/tony.jpg" alt="profile img">

			</div>
			<div class="right_content">
				<p>
					Display name <span id="display_name"><%=displayName != null ? displayName : ""%></span>
				</p>
				<p>
					Name<span class="name"><%=userName%></span>
				</p>
				<p>
					Email <span id="email"><%=emailId%></span>
				</p>
				<p>
					Phone Number <span id="ph_no"><%=phNo%></span>
				</p>
				<p>
					Profession <span id="profession"><%=profession%></span>
				</p>

				<button id="edit">
					<img src="./assets/images/icons/edit.svg" alt="icons">
				</button>

			</div>

			<div class="right_content1 not_view">
				<form class="form" action="./UpdateProfileDetails" method="post">

					<p>
						Display Name <input type="text" id="new_display_name"
							name="displayname"
							value="<%=displayName != null ? displayName : ""%>">
					</p>
					<p>
						Name <input type="text" id="new_name" name="name"
							value="<%=userName%>">
					</p>
					<p>
						Email <input type="email" id="new_email" name="email"
							value="<%=emailId%>" readonly>
					</p>
					<p>
						Phone number <input type="tel" id="new_ph_no" pattern=[0-9]{10}
							value="<%=phNo%>" name="phno">
					</p>
					<p>
						Profession <input type="text" id="new_profession"
							value="<%=profession%>" name="profession">
					</p>

					<button id="save" type="submit" value="submit">
						<img src="./assets/images/icons/save_icon.png" alt="icon">
					</button>
				</form>
			</div>

		</div>

		<!----------------right div----------------->
		<jsp:include page="./profiletab.jsp"></jsp:include>
	</main>

	<script src="./assets/js/profile.js"></script>
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
			window.location.href="./profile.jsp";
		}, 5000);
		
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
			window.location.href="./profile.jsp";
		}, 5000);
		
		<%}%>
		
		

	</script>

</body>
</html>