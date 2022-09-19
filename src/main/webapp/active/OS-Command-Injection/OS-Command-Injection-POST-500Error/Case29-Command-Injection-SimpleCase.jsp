<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.InputStreamReader" %>
<%@page import="java.io.IOException" %>
<%@page import="java.io.File" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Case 1 - Injection into search parameter to execute a command. Goal: execute the 'whoami' command to determine the name of the current user.</title>
</head>
<body>
<p style="text-align:center;"><img src='<%=request.getParameter("image")%>' class="center" width="500" height="100"></p>

<%
if (request.getParameter("msg") == null) {
%>

	Enter your name:<br><br>
	<form name="frmInput" id="frmInput" action="Case01-Command-Injection-SimpleCase.jsp?image=/wavsep_enhancement_war_exploded/images/wavsep-logo.jpeg" method="POST">
		<input type="text" name="msg" id="msg"><br>
		<input type=submit value="submit">
	</form>
<%
} 
else {
	   
	   String msg = request.getParameter("msg");
	   String currPath = getServletConfig().getServletContext().getRealPath("");
	   System.setProperty("user.dir", currPath);

	   String[] cmd = {"/bin/sh", "-c", "echo " + msg };
	   String output = "Hello ";
	   if(cmd != null) {
	      String s = null;
	      try {
	         Process p = Runtime.getRuntime().exec(cmd, null, new File(currPath));
	         BufferedReader sI = new BufferedReader(new InputStreamReader(p.getInputStream()));
	         while((s = sI.readLine()) != null) {
	            output += s;
	         }
	      }
	      catch(IOException e) {
	         e.printStackTrace();
	      }
	   }
	   
	   out.println(output + ", how are you? Nice to meet you!");
}
%>

</body>
</html>