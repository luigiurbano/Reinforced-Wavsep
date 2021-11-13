<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evaluation of Reflected XSS Detection Accuracy - GET - WebSecLab</title>
</head>
<body>

<%--
	String anticsrf = (String)request.getSession().getAttribute("anticsrf");
	if(anticsrf == null) {
		//Generate and store a new token
		anticsrf = "" + Math.random();
		request.getSession().setAttribute("anticsrf", anticsrf);
	}

String cookieName = "msg";
boolean foundFlag = false;

Cookie cookies [] = request.getCookies ();
Cookie myCookie = null;
if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		if (cookies [i].getName().equals (cookieName)) {		
			foundFlag = true;
			break;
		}
	}
	if(foundFlag == false) {
		//Create a cookie, if not supplied
		response.addHeader("Set-Cookie", cookieName + "=EmptyValue; HTTPOnly");
	}
}
--%>

<center><H1>Evaluation of Reflected XSS Detection Accuracy - GET - WebSecLab</H1></center>
<font size="5">Test Cases:</font><br><br>
<B><a href="js3.jsp?in=textvalue">Case01-js3.jsp</a></B><br>
  exploitable injection into JS executable context (<B>unquoted input</B>).<br>
  <U>Barriers:</U><br>
  None (Cookie)<br>
  <U>Examples:</U><br>
  Exploit: <B>1,x:alert(12345)</B><br><br>
  
<B><a href="js4_dq.jsp?in=textvalue">Case02-js4_dq.jsp</a></B><br>
  exploitable Javascript and <B>double quotes</B> injection into a script block.
<br>
  <U>Barriers:</U><br>
  None (Cookie)<br>
  <U>Examples:</U><br>
  Exploit: <B>js4%22,x:alert(12345),y:%22</B><br><br>

<B><a href="js6_sq.jsp?in=textvalue">Case03-js6_sq.jsp</a></B><br>
  exploitable Javascript and <B>single quotes</B> injection into a script block.
<br>
  <U>Barriers:</U><br>
  None (Cookie)<br>
  <U>Examples:</U><br>
  Exploit: <B>js6%27,x:alert(12345),y:%27</B><br>
</body>
</html>

