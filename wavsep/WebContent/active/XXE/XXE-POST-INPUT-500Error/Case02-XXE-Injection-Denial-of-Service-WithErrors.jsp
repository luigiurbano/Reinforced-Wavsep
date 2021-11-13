<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Case 2 - XXE Injection into intercepted request. Goal: perform XXE injection to execute a DoS.</title>
    <script>
	    function sendXml()
	    {
		       var xhr = new XMLHttpRequest();
		       xhr.open("POST", "/wavsep/active/XXE/XXE-POST-INPUT-500Error/result-XXE.jsp");
		       var xmlDoc;
		       
		       xhr.onreadystatechange = function() 
		       {
		           if (xhr.readyState == 4 && xhr.status == 200)
		           {
			           document.getElementById("result").innerHTML=xhr.responseText
		           }
		       };
		       
		       xhr.setRequestHeader('Content-Type', 'text/xml');
		       var xml = document.getElementById("input").value;
		       xhr.send(xml);
	      }
    </script>
</head>

<body>
<h4></h4>
	<form>
		<textarea name="input" id="input" rows="15" cols="60"></textarea><br><br>
		<input type="button" onclick="sendXml()" value="submit"><br><br>
	</form>
	<div id="result"></div>
	
	<br><br>
</body>
</html>