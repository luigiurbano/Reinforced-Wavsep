<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%><%@ page import="com.nsunina.wavsepenhancement.encoders.HtmlEncoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Case 13 - RXSS via VBScript injection into the scope of an HTML/VBScript Event (Double Quote Delimiter)</title>
</head>
<body>

<%
if (request.getParameter("userinput") == null) {
%>
	Enter your input:<br><br>
	<form name="frmInput" id="frmInput" action="Case13-Vbs2DoubleQuoteVbsEventScope.jsp" method="POST">
		<input type="text" name="userinput" id="userinput"><br>
		<input type=submit value="submit">
	</form>
<%
} 
else {
    try {
	  	    String userinput = request.getParameter("userinput");
	  	    //only encode Angle brackets and double quotes
	  	    userinput = HtmlEncoder.htmlEncodeAngleBracketsAndDoubleQuotes(userinput);
     		out.println("Hello Button: <input type=\"button\" value=\"ClickMe\" onClick=\"VBScript:Document.Write 'hello mr. " +
     				    userinput + "'\">");
     		
	  	    out.flush();
    } catch (Exception e) {
        out.println("Exception details: " + e);
    }
} //end of if/else block
%>

</body>
</html>