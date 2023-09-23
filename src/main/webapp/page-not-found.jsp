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
<link rel="stylesheet" href="./assets/css/errorPage.css">
</head>
<body>
<%
User user = (User) session.getAttribute("currentuser");
String path="./home.jsp";
if(user==null){
	path="./login.jsp";
}
%>
<header>
<img src="./assets/images/icons/proplan_logo.png" alt="logo">
<a href="<%=path%>">Back to Home</a>
</header>
	<main>
	
	<img alt="404 error" src="./assets/images/gifs/404.gif">
	</main>
</body>
</html>
