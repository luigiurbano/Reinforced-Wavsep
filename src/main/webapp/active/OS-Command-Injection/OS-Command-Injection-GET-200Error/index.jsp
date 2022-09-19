<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evaluation of OS Command Injection Detection Accuracy - HTTP GET Method</title>
</head>
<body>

<%@ include file="include.jsp"%>

<%
	String defaultFullOsCommandInputWithoutPrefix = null;
	String defaultFullOsCommandInputWithPrefix = null;
	String defaultPostfixOsCommandInputWithInitialCommand = null;
	String defaultPostfixOsCommandInputWithoutInitialCommand = null;
	String defaultEmptyInput = null;
	String defaultPartialInput = null;
	String defaultPostfixValueInput = null;
	String defaultPostfixCommandInput = null;
	String defaultInvalidInput = null;
 

 	boolean isWindows = System.getProperty("os.name").contains("Win");
 
	if (isWindows) { //If OS Type = Windows Add the cmd prefix
		defaultFullOsCommandInputWithoutPrefix = "dir"; 
		defaultFullOsCommandInputWithPrefix = "cmd.exe /c dir";
		
		defaultPostfixOsCommandInputWithInitialCommand = "findstr Java"; 
		defaultPostfixOsCommandInputWithoutInitialCommand = "Java";
		defaultEmptyInput = "";
		defaultPartialInput = "eclipse.ini";
		defaultPostfixValueInput = "Build";
		defaultPostfixCommandInput = " | findstr Build";
		defaultInvalidInput = "dfdflkjsh";
 	} else {
		defaultFullOsCommandInputWithoutPrefix = "ls";
		defaultFullOsCommandInputWithPrefix = "ls";
		defaultEmptyInput = "";
		defaultPartialInput = "eclipse.ini";
		defaultPostfixValueInput = "Build";
		defaultPostfixCommandInput = " | grep Build"; 
		defaultInvalidInput = "dfdflkjsh";
 	}
%>

<center><font size="5">OS Command Injection Test Cases - HTTP 200 Valid Responses:</font></center><br><br>

<br>
<b>Injection Contexts Covered:</b><br>
1) Initial Statement/Command Context: Default OS Command Input with and without prefix:<br>
   <b><i>[windows only: cmd.exe /c ]*OS COMMAND INJECTION*</i></b><br>
2) Internal Statement/Command Context: Input integrated in the middle of a fixed OS command:<br>
   <b><i>[windows only: cmd.exe /c ][fixed-os-command ]*INPUT*[ | postfix-fixed-commands]</i></b><br>
   <b><i>[windows only: cmd.exe /c ][fixed-os-command ]*INPUT*</i></b><br>
3) Internal Statement/Command Context: Input integrated in postfix section of an OS command:<br>
   <b><i>[windows only: cmd.exe /c ][fixed-os-command ][ | postfix-fixed-commands ]*INPUT*</i></b><br>
<br/> 
<br/>
<br/>

  <B><a href="Case1-OSCmdInjection-GenericOS-InitialCommandContext-SimpleStatement-DefaultOsCommandInput-NoValidation.jsp?target=<%=defaultFullOsCommandInputWithPrefix%>">
   Case1-OSCmdInjection-GenericOS-InitialCommandContext-SimpleStatement-DefaultOsCommandInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>initial</b> OS command context, with default OS command input (with prefix), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Full OS Command With Prefix</TD>
  <TD>ANY</TD><TD>Initial Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> cmd.exe /c dir c:\secret-directory\<br>
  <B>Independent Exploit 2 (Linux):</B> cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case2-OSCmdInjection-GenericOS-InitialCommandContext-SimpleStatement-DefaultEmptyInput-NoValidation.jsp?target=<%=defaultEmptyInput%>">
   Case2-OSCmdInjection-GenericOS-InitialCommandContext-SimpleStatement-DefaultEmptyInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>initial</b> OS command context, with default <b>EMPTY</b> input (invalid), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Initial Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> dir c:\secret-directory\<br>
  <B>Independent Exploit 2 (Linux):</B> cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
 
  <B><a href="Case3-OSCmdInjection-GenericOS-InitialCommandContext-SimpleStatement-DefaulInvalidInput-NoValidation.jsp?target=<%=defaultInvalidInput%>">
   Case3-OSCmdInjection-GenericOS-InitialCommandContext-SimpleStatement-DefaulInvalidInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>initial</b> OS command context, with default <b>INVALID</b> input (invalid), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Initial Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> dir c:\secret-directory\<br>
  <B>Independent Exploit 2 (Linux):</B> cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case4-OSCmdInjection-GenericOS-InitialCommandContext-SimpleStatement-DefaultRelativeOsCommandInput-NoValidation.jsp?target=<%=defaultFullOsCommandInputWithoutPrefix%>">
   Case4-OSCmdInjection-GenericOS-InitialCommandContext-SimpleStatement-DefaultRelativeOsCommandInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>initial</b> OS command context, with default OS command input (no prefix), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Full OS Command No Prefix</TD>
  <TD>ANY</TD><TD>Initial Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> dir c:\secret-directory\<br>
  <B>Independent Exploit 2 (Linux):</B> cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case5-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-NoValidation.jsp?target=<%=defaultPartialInput%>">
   Case5-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>PARTIAL</b> input (filename), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Partial Command (filename)</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> | dir c:\secret-directory\<br>
  <B>Independent Exploit 2 (Linux):</B> | cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case6-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultEmptyInput-NoValidation.jsp?target=<%=defaultEmptyInput%>">
   Case6-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultEmptyInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>PARTIAL</b> input (filename), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> eclipse.ini | dir c:\secret-directory\<br>
  <B>Independent Exploit 2 (Linux):</B> eclipse.ini | cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case7-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultInvalidInput-NoValidation.jsp?target=<%=defaultInvalidInput%>">
   Case7-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultInvalidInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>PARTIAL</b> input (filename), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> eclipse.ini | dir c:\secret-directory\<br>
  <B>Independent Exploit 2 (Linux):</B> eclipse.ini | cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  <B><a href="Case8-OSCmdInjection-GenericOS-PostfixCommandContext-SimpleStatement-DefaultOsCommandInputWithPrefix-NoValidation.jsp?target=<%=defaultPostfixOsCommandInputWithInitialCommand%>">
   Case8-OSCmdInjection-GenericOS-PostfixCommandContext-SimpleStatement-DefaultOsCommandInputWithPrefix-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>postfix</b> OS command context, with default OS command input (with initial postfix command), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Full OS Postfix Command</TD>
  <TD>ANY</TD><TD>Postfix Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> type c:\boot.ini <br>
  <B>Independent Exploit 2 (Linux):</B> cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case9-OSCmdInjection-GenericOS-PostfixCommandContext-SimpleStatement-EmptyInput-NoValidation.jsp?target=<%=defaultEmptyInput%>">
   Case9-OSCmdInjection-GenericOS-PostfixCommandContext-SimpleStatement-EmptyInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>postfix</b> OS command context, with default empty input, using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Postfix Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> type c:\boot.ini <br>
  <B>Independent Exploit 2 (Linux):</B> cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case10-OSCmdInjection-GenericOS-PostfixCommandContext-SimpleStatement-InvalidInput-NoValidation.jsp?target=<%=defaultInvalidInput%>">
   Case10-OSCmdInjection-GenericOS-PostfixCommandContext-SimpleStatement-InvalidInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>postfix</b> OS command context, with default invalid input, using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Postfix Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> type c:\boot.ini <br>
  <B>Independent Exploit 2 (Linux):</B> cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case11-OSCmdInjection-GenericOS-PostfixCommandContextAfterInitialPostfixCommand-SimpleStatement-DefaultOsCommandInputWithoutPrefix-NoValidation.jsp?target=<%=defaultPostfixOsCommandInputWithoutInitialCommand%>">
   Case11-OSCmdInjection-GenericOS-PostfixCommandContextAfterInitialPostfixCommand-SimpleStatement-DefaultOsCommandInputWithoutPrefix-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>postfix</b> OS command context, with default OS command input (with initial postfix command), using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Partial OS Postfix Command</TD>
  <TD>ANY</TD><TD>Postfix Statement/Command (After initial postfix command)</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> c:\boot.ini <br>
  <B>Independent Exploit 2 (Windows):</B> eclipse.ini | type c:\boot.ini <br>
  <B>Independent Exploit 3 (Linux):</B> /etc/passwd<br>
  <B>Independent Exploit 4 (Linux):</B> eclise.ini | cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
   
  <B><a href="Case12-OSCmdInjection-GenericOS-PostfixCommandContextAfterInitialPostfixCommand-SimpleStatement-DefaultEmptyInput-NoValidation.jsp?target=<%=defaultEmptyInput%>">
   Case12-OSCmdInjection-GenericOS-PostfixCommandContextAfterInitialPostfixCommand-SimpleStatement-DefaultEmptyInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>postfix</b> OS command context, with default empty input, using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Postfix Statement/Command (After initial postfix command)</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> c:\boot.ini <br>
  <B>Independent Exploit 2 (Windows):</B> eclipse.ini | type c:\boot.ini <br>
  <B>Independent Exploit 3 (Linux):</B> /etc/passwd<br>
  <B>Independent Exploit 4 (Linux):</B> eclise.ini | cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  
   
  <B><a href="Case13-OSCmdInjection-GenericOS-PostfixCommandContextAfterInitialPostfixCommand-SimpleStatement-DefaultInvalidInput-NoValidation.jsp?target=<%=defaultInvalidInput%>">
   Case13-OSCmdInjection-GenericOS-PostfixCommandContextAfterInitialPostfixCommand-SimpleStatement-DefaultInvalidInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into an <b>postfix</b> OS command context, with default invalid input, using an unrestricted input.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Postfix Statement/Command (After initial postfix command)</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> c:\boot.ini <br>
  <B>Independent Exploit 2 (Windows):</B> eclipse.ini | type c:\boot.ini <br>
  <B>Independent Exploit 3 (Linux):</B> /etc/passwd<br>
  <B>Independent Exploit 4 (Linux):</B> eclise.ini | cat /etc/passwd<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
 
  <B><a href="Case14-OSCmdInjection-GenericOS-MiddleCommandContextBeforePostfix-SimpleStatement-DefaultPartialInput-NoValidation.jsp?target=<%=defaultPartialInput%>">
   Case14-OSCmdInjection-GenericOS-MiddleCommandContextBeforePostfix-SimpleStatement-DefaultPartialInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context with predefined search postfix, with default <b>PARTIAL</b> input (filename), using an unrestricted input.<br>
  May require blind detection methods (e.g. ping, output file creation, etc)<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Partial Command (filename)</TD>
  <TD>ANY</TD><TD>Mid Statement/Command with Fixed Postfix</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent14.txt"<br>
  <B>Independent Exploit 2 (Linux):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent14.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  
  <B><a href="Case15-OSCmdInjection-GenericOS-MiddleCommandContextBeforePostfix-SimpleStatement-DefaultEmptyInput-NoValidation.jsp?target=<%=defaultEmptyInput%>">
   Case15-OSCmdInjection-GenericOS-MiddleCommandContextBeforePostfix-SimpleStatement-DefaultEmptyInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context with predefined search postfix, with default <b>EMPTY</b> input, using an unrestricted input.<br>
  May require blind detection methods (e.g. ping, output file creation, etc)<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Mid Statement/Command with Fixed Postfix</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent15.txt"<br>
  <B>Independent Exploit 2 (Linux):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent15.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
    
  <B><a href="Case16-OSCmdInjection-GenericOS-MiddleCommandContextBeforePostfix-SimpleStatement-DefaultInvalidInput-NoValidation.jsp?target=<%=defaultInvalidInput%>">
   Case16-OSCmdInjection-GenericOS-MiddleCommandContextBeforePostfix-SimpleStatement-DefaultInvalidInput-NoValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context with predefined search postfix, with default <b>INVALID</b> input, using an unrestricted input.<br>
  May require blind detection methods (e.g. ping, output file creation, etc)<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>None</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Mid Statement/Command with Fixed Postfix</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent16.txt"<br>
  <B>Independent Exploit 2 (Linux):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent16.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  
  <B><a href="Case17-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-PipeValidation.jsp?target=<%=defaultPartialInput%>">
   Case17-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-PipeValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>PARTIAL</b> input (filename), with pipe (|) input validation.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Pipe Input Validation</TD><TD>Partial Command (filename)</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - encoded & - %26):</B> eclipse.ini %26 dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent17.txt"<br>
  <B>Independent Exploit 2 (Linux - encoded & - %26):</B> eclipse.ini %26 cat /etc/passwd >> /var/www/dircontent17.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
   
  <B><a href="Case18-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-EmptyInput-PipeValidation.jsp?target=<%=defaultEmptyInput%>">
   Case18-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-EmptyInput-PipeValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>EMPTY</b> input, with pipe (|) input validation.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Pipe Input Validation</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - encoded & - %26):</B> eclipse.ini %26 dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent18.txt"<br>
  <B>Independent Exploit 2 (Linux - encoded & - %26):</B> eclipse.ini %26 cat /etc/passwd >> /var/www/dircontent18.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
     
  <B><a href="Case19-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-InvalidInput-PipeValidation.jsp?target=<%=defaultInvalidInput%>">
   Case19-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-InvalidInput-PipeValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>INVALID</b> input, with pipe (|) input validation.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Pipe Input Validation</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - encoded & - %26):</B> eclipse.ini %26 dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent19.txt"<br>
  <B>Independent Exploit 2 (Linux - encoded & - %26):</B> eclipse.ini %26 cat /etc/passwd >> /var/www/dircontent19.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
 
  
  <B><a href="Case20-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-PipeRemoval.jsp?target=<%=defaultPartialInput%>">
   Case20-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-PipeRemoval.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>PARTIAL</b> input (filename), with pipe (|) input removal.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Pipe Input Removal</TD><TD>Partial Command (filename)</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - encoded & - %26):</B> eclipse.ini %26 dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent20.txt"<br>
  <B>Independent Exploit 2 (Linux - encoded & - %26):</B> eclipse.ini %26 cat /etc/passwd >> /var/www/dircontent20.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
   
  <B><a href="Case21-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-EmptyInput-PipeRemoval.jsp?target=<%=defaultEmptyInput%>">
   Case21-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-EmptyInput-PipeRemoval.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>EMPTY</b> input, with pipe (|) input removal.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Pipe Input Removal</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - encoded & - %26):</B> eclipse.ini %26 dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent21.txt"<br>
  <B>Independent Exploit 2 (Linux - encoded & - %26):</B> eclipse.ini %26 cat /etc/passwd >> /var/www/dircontent21.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
     
  <B><a href="Case22-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-InvalidInput-PipeRemoval.jsp?target=<%=defaultInvalidInput%>">
   Case22-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-InvalidInput-PipeRemoval.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>INVALID</b> input, with pipe (|) input removal.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Pipe Input Removal</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - encoded & - %26):</B> eclipse.ini %26 dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent22.txt"<br>
  <B>Independent Exploit 2 (Linux - encoded & - %26):</B> eclipse.ini %26 cat /etc/passwd >> /var/www/dircontent22.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case23-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-AmpersandValidation.jsp?target=<%=defaultPartialInput%>">
   Case23-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-AmpersandValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>PARTIAL</b> input (filename), with ampersand (&) input validation.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Ampersand Input Validation</TD><TD>Partial Command (filename)</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - |):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent23.txt"<br>
  <B>Independent Exploit 2 (Linux - |):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent23.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case24-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-EmptyInput-AmpersandValidation.jsp?target=<%=defaultEmptyInput%>">
   Case24-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-EmptyInput-AmpersandValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>EMPTY</b> input, with ampersand (&) input validation.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Ampersand Input Validation</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - |):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent24.txt"<br>
  <B>Independent Exploit 2 (Linux - |):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent24.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case25-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-InvalidInput-AmpersandValidation.jsp?target=<%=defaultInvalidInput%>">
   Case25-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-InvalidInput-AmpersandValidation.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>INVALID</b> input, with ampersand (&) input validation.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Ampersand Input Validation</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - |):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent25.txt"<br>
  <B>Independent Exploit 2 (Linux - |):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent25.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case26-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-AmpersandRemoval.jsp?target=<%=defaultPartialInput%>">
   Case26-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-DefaultPartialInput-AmpersandRemoval.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>PARTIAL</b> input (filename), with ampersand (&) input removal.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Ampersand Input Removal</TD><TD>Partial Command (filename)</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - |):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent26.txt"<br>
  <B>Independent Exploit 2 (Linux - |):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent26.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case27-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-EmptyInput-AmpersandRemoval.jsp?target=<%=defaultEmptyInput%>">
   Case27-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-EmptyInput-AmpersandRemoval.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>EMPTY</b> input, with ampersand (&) input removal.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Ampersand Input Removal</TD><TD>Empty Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - |):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent27.txt"<br>
  <B>Independent Exploit 2 (Linux - |):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent27.txt<br>
  </TD></TR>
  </TABLE>  
  <br>
  
  
  <B><a href="Case28-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-InvalidInput-AmpersandRemoval.jsp?target=<%=defaultInvalidInput%>">
   Case28-OSCmdInjection-GenericOS-MiddleCommandContext-SimpleStatement-InvalidInput-AmpersandRemoval.jsp</a></B><br>
  OS Command Injection attack abusing string concatenation in the Runtime Class exec method: <br>
  Injection into the <b>middle</b> of an OS command context, with default <b>INVALID</b> input, with ampersand (&) input removal.<br>
  
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>OS Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>OS Type:</B></U></TD>
  <TD><U><B>Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD>
  </TR>
  <TR>
  <TD>Runtime.getRuntime().exec("[injection]").waitFor()</TD><TD>Ampersand Input Removal</TD><TD>Invalid Input</TD>
  <TD>ANY</TD><TD>Mid-End Statement/Command</TD><TD>None</TD>
  <TD>Text/Html</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  [os-command](success)<br><b> or </b>
  [time-delay os-command] (success)<br><b> vs. </b>
  [invalid OS command] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Windows/Linux: [command][attacker host OR sensitive content]<br>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Windows - |):</B> eclipse.ini | dir c:\ >> "C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\ROOT\dircontent28.txt"<br>
  <B>Independent Exploit 2 (Linux - |):</B> eclipse.ini | cat /etc/passwd >> /var/www/dircontent28.txt<br>
  </TD></TR>
  </TABLE>  
  <br>

</body>
</html>