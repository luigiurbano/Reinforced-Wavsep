<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.Scanner"%>
<%@ page language="java" contentType="text/html; charset=windows-1255"
    pageEncoding="windows-1255"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1255">
<title>Insert title here</title>
</head>
<body>

<form method="post">
<input type="text" value="">
<input type=submit>
</form>

<%

out.println("post: " +IOUtils.toString(request.getReader()));

if ("POST".equalsIgnoreCase(request.getMethod())) {
    Scanner s = null;
    try {
        s = new Scanner(request.getInputStream(), "UTF-8").useDelimiter("\\A");
    } catch (IOException e) {
        e.printStackTrace();
    } finally { }
    out.print(s.hasNext() ? s.next() : "");
}
    
%>

</body>
</html>