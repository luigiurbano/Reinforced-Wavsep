<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%><%@ page import="com.nsunina.wavsepenhancement.encoders.HtmlEncoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Case 25 - RXSS via VBScript injection into the scope of a script tag (VBScript, Double Quote String Delimiter)</title>
</head>
<body>

<%
if (request.getParameter("userinput") == null || !"POST".equalsIgnoreCase(request.getMethod())) {
%>
	Enter your input:<br><br>
	<form name="frmInput" id="frmInput" action="Case25-Vbs2ScriptTagDoubleQuoteDelimiter.jsp" method="POST">
		<input type="text" name="userinput" id="userinput"><br>
		<input type=submit value="submit">
	</form>
<%
} 
else {	
    try {
	  	    String userinput = request.getParameter("userinput"); 
	  	    //only encode Angle brackets and single quotes
	  	    userinput = HtmlEncoder.htmlEncodeAngleBracketsAndSingleQuotes(userinput);
     		out.println("<script language='VBScript'>\n"
     			+ "Dim customerName\n"
     			+ "customerName = \"" + userinput + "\"\n" 
     			+ "Document.Write (\"Welcome \" & customerName)\n"
     			+ "</script> ");
	  	    out.flush();
    } catch (Exception e) {
        out.println("Exception details: " + e);
    }
} //end of if/else block
%>
</body>
</html>