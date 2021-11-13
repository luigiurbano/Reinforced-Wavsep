<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evaluation of Web Application Scanners Detection Accuracy</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/style.css" />
</head>
<body>
<p style="text-align:center;"><img src="${pageContext.request.contextPath}/images/wavsep-logo.jpeg" class="center" width="500" height="100"></p>
<h1>Welcome to WAVSEP - The Web Application Vulnerability Scanner Evaluation Project</h1>
<h2><span>Version: 2.0</span></h2>
	<nav class="nav">
	  	<ul class=list>
    				<li>
					      <a>INDEX</a>
        					<ul>
          						<li>
							            <a href="active/index-main.jsp">ACTIVE</a>
							              <ul>
								              <li>
									                  <a href="active/index-xss.jsp">Reflected Cross Site Scripting (RXSS)</a>
								              </li>
								        <li>
                						<a href="active/index-sql.jsp">SQL Injection</a>
                							<ul>
                								<li><a href="active/index-sql-blind.jsp">BLIND SQL Injection</a>
                							</li>
                						</ul>
              							</li>
							            
							            <li>
                						<a href="active/index-lfi.jsp">Local File Inclusion/Directory Traversal/Path Traversal</a>
              							</li>
              							
              							<li>
                						<a href="active/index-rfi.jsp">Remote File Inclusion</a>
              							</li>
              							
              							<li>
                						<a href="active/index-redirect.jsp">Unvalidated Redirect</a>
              							</li>
              							
              							<li>
                						<a href="active/index-false.jsp">False Positive Test Cases </a>
              							</li>
							            
							            <li>
							            <a href="active/index-os-command.jsp">OS Command Injection</a>
							            </li>
							            
							            <li>
							            <a href="active/index-xxe.jsp">XML External Entity</a>
							            </li>
							            </ul>

						          </li>
						          <li>
            							<a href="passive/index.jsp">PASSIVE</a>
							            <ul>
              					<li>
    
     
									                 <a href="passive/index-info.jsp">Information Leakage</a>
									                 
								               </li>
								               <li>
                						<a href="passive/index-session.jsp">Session</a>
              							</li>
             							</ul>
						           </li>
						           <li>
							             <a href="#">UTIL</a>
							             <ul>
								               <li>
                 									<a href="wavsep-install/install.jsp">Install</a>
               								</li>
								               <li>
									                 <a href="https://github.com/NS-unina/Reinforced-Wavsep">Github Repo</a>
								               </li>
             							</ul>
            						</li>
					         </ul>
				       </li>
     			</ul>
   </nav>
<p style="color:rgb(11, 33, 74)"><b><u>Notes:</u></b></p>
<p> Make sure you install the database using the auto-installer.</p><br>
<p style="color:rgb(11, 33, 74)"><b><u>Open issues:</u></b><br></p>
<p syle="color:rgb(144, 160, 188)"> Previous versions of wavsep might require the web server to run with admin/root permissions (for the database installation script),<br>
due to the usage of a derby database created in a default location.</p><br>


<p style="color:rgb(11, 33, 74)"><b><u>Authors:</u></b></p>
<p><I><b>Luigi Urbano - <a href="https://github.com/NS-unina/Reinforced-Wavsep">https://github.com/NS-unina/Reinforced-Wavsep</a></b></I></p>
<p><I><b>Say Chen - <a href="http://github.com/sectooladdict/wavsep">http://github.com/sectooladdict/wavsep</a></b></I></p>
</body>
</html>