<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evaluation of Directory Traversal / Local File Inclusion Detection Accuracy - HTTP GET Method</title>
</head>
<body>

<%@ include file="include.jsp"%>

<center><font size="5">Directory Traversal/LFI Test Cases - HTTP 500 Responses with Erroneous Text:</font></center><br><br>


  
  
  <B><a href="Case01-LFI-Superfluous-URL-Decode-FileClass-FilenameContext-Unrestricted-OSPath-DefaultRelativeInput-AnyPathReq-Read.jsp?target=<%=FileConstants.DEFAULT_TARGET_FILE_NOT_LOCAL%>">
   Case01-LFI-Superfluous-URL-Decode-FileClass-FilenameContext-Unrestricted-OSPath-DefaultRelativeInput-AnyPathReq-Read.jsp</a></B><br>
  LFI attack abusing the File class: injection into a filename context, using an unrestricted OS path, default relative input, without path requirements, and in the scope of a page with erroneous 500 responses.<br>
  <TABLE border=1 cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'>
  <TD><U><B>File Access Method:</B></U></TD><TD><U><B>Barriers:</B></U><br></TD>
  <TD><U><B>Default Input:</B></U></TD><TD><U><B>Path Type:</B></U></TD>
  <TD><U><B>File Injection Context:</B></U></TD><TD><U><B>Prefix Requirement:</B></U></TD>
  <TD><U><B>Valid Response Stream:</B></U></TD><TD><U><B>Erroneous Response Type:</B></U></TD>
  </TR>
  <TR>
  <TD>File Class (Read)</TD><TD>None</TD><TD>Relative Input</TD>
  <TD>Local OS Path (URL)</TD><TD><B>Injection Into:</B> Full Filename<br><B>Relative Path:</B> Execution Folder<BR><B>Full Path:</B> Supported</TD><TD>Any Prefix<BR>(Full path / Relative path/ None)</TD>
  <TD>Text/Html</TD><TD>500 Error</TD>
  </TR>
  </TABLE>
  <TABLE cellspacing=0 cellpadding=2>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Detection Structures:</B></U>
  </TD></TR>
  <TR><TD>
  ./[original-file-name] (success)<br><b> vs. </b>
  ../[original-file-name] (failure)
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Sample Exploit Structures:</B></U>
  </TD></TR>
  <TR><TD>
  Web: <B>..%2F[target-file]</B><br>
  Windows: <B>..%2Fboot.ini</B><br>
  Unix/Linux: <B>..%2F..%2Fetc%2Fpasswd</B>
  </TD></TR>
  <TR bgcolor='#1AC6FF'><TD>
  <U><B>Examples of Exploits:</B></U>
  </TD></TR>
  <TR><TD>
  <B>Independent Exploit 1 (Win):<B>..%2Fboot.ini</B><br>
  <B>Independent Exploit 2 (Linux):</B> <B>..%2F..%2Fetc%2Fpasswd</B>
  </TD></TR>
  </TABLE>  
  <br>
</body>
</html>