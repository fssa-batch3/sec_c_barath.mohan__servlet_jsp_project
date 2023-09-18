
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js" ></script>
<script>
<%	String errorMsg = (String) request.getAttribute("errorMsg");
	String successMsg = (String) request.getAttribute("successMsg");
	String path=(String) request.getAttribute("path");

	System.out.println(successMsg +" Succesmsg =-========-=  errormsg "+errorMsg);
	
	
	if (errorMsg != null) {%>
		console.log("<%=errorMsg%>");
		<%System.out.print(errorMsg+"inside");%>
		swal("Failed!"," <%=errorMsg%>", "error");
		setTimeout(() => {
			console.log("df");
			window.location.href="<%=path%>";
		}, 4000);
		
	<%
	
	}%>
		
		<%
		if ( successMsg!= null) {%>
		console.log("<%=successMsg%>");
		<%System.out.print(successMsg+"inside");%>
		swal("Success!"," <%=successMsg%>", "success");
		setTimeout(() => {
			console.log("df");
			window.location.href="<%=path%>";
		}, 4000);
		<%}%>
</script>	