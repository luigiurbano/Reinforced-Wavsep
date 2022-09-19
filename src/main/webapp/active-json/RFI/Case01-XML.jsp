<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
if (request.getParameter("userinput") == null) {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-2.2.4.min.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Case 1 - RXSS via tag injection into the scope of an HTML page</title>
</head>
<body>


	Enter your input:<br><br>
	<form name="frmInput" id="frmInput" method="POST">
		<input type="text" name="userinput" id="userinput"><br>
		<input type="submit" value="submit">
	</form>
	<br><br>
	Response:<button type="button" onclick="javascript: $('#response').val('');">Clear</button><br><br>
	<textarea id="response" style="width:800px; height:600px;"></textarea>



<script type="text/javascript">
$.fn.xmlizeObject = function()
{
   var o = '<?xml version="1.0" encoding="UTF-8" ?>\n<xml>';
   var a = this.serializeArray();
   $.each(a, function() {
    o += "\n    <" + this.name + ">" + this.value + "<" + this.name + ">";
   });
   o += "\n</xml>";
   return o;
};
$(document).on("submit", "#frmInput", function(event) {
/* encodeURIComponent() */
var formObject = $("form#frmInput").xmlizeObject();

$.ajax({
        accepts: {xml: "text/xml", text: "text/plain"}
        ,type: "POST"
        ,contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        ,url: $("form#frmInput").attr('action')
        ,async: true
        ,cache: false
        ,converters: {"text xml": jQuery.parseXML}
        ,data: formObject
        ,dataType: "xml"
        ,timeout: "5000"
        ,success : function(result) {
            document.getElementById('response').value = result;
            $('textarea#result').val(result)
        }
        ,error: function(xhr, resp, text) {
            document.getElementById('response').value = xhr.responseText;
        }
    });
    event.preventDefault();
});
</script>
</body>
</html>
<%
} 
else {
    try {
	  	    String userinput = request.getParameter("userinput"); 
     		out.println("The reflected value: " + userinput);
	  	    out.flush();
    } catch (Exception e) {
        out.println("Exception details: " + e);
    }
} //end of if/else block
%>
