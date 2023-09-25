<%@page import="com.fssa.proplan.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Proplan - Error Page</title>
<link rel="stylesheet" href="./assets/css/style.css">
<link rel="stylesheet" href="./assets/css/errorPage.css">

</head>
<body>
	<%
	User user = (User) session.getAttribute("currentuser");
	String path = "./home.jsp";
	if (user == null) {
		path = "./login.jsp";
	}
	%>
	<jsp:include page="./header.jsp"></jsp:include>
	<main>
	<jsp:include page="./sidebar.jsp"></jsp:include>
	<div class="center_side error_div">
		<img alt="404 error" src="./assets/images/gifs/404.gif" id="errorImg">
		<h3 id="h3_error">OOPS! Page not found</h3>
		<p id="p_error">Sorry, but the page you are looking for doesn't exist, have been removed, name changed or is temporarily unavailable.</p>
	</div>

	
	</main>
</body>
</html>
