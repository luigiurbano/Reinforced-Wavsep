<%@page import="java.util.List"%>
<%@page import="org.jdom2.Element"%>
<%@page import="org.jdom2.input.SAXBuilder"%>
<%@page import="org.jdom2.Document"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>OS Command Injection Test Case</title>
</head>
<body>

<script src="../../../js/jquery-3.1.1.min.js" type="text/javascript"></script>
	
	<%
		if (validResposeStream.equals(ContentConstants.CONTENT_TYPE_TEXT_HTML)) {
	%>

	Show Log:
	<br>
	<br>
	<form name="frmInput" id="frmInput" method="POST">
		<input type="text" name="userinput" id="userinput"
			value="<%=defaultInput%>"><br> 
		<input type=submit value="Get It!">
	</form>
	<br><br>
  	Response:<button type="button" onclick="javascript: $('#response').val('');">Clear</button><br><br>
  	<textarea id="response" style="width:800px; height:600px;"></textarea>

	<%
		} else if (validResposeStream.equals(ContentConstants.CONTENT_TYPE_STREAM)) {
	%>

	Get Content:
	<br>
	<br>
	<form name="frmInput" id="frmInput" method="POST">
		<input type="text" name="userinput" id="userinput"
			value="<%=defaultInput%>"><br> <input type=submit
			value="Get It!">
	</form>
	<br><br>
  	Response:<button type="button" onclick="javascript: $('#response').val('');">Clear</button><br><br>
  	<textarea id="response" style="width:800px; height:600px;"></textarea>

	<%
		} else {
	%>

	Get Content:
	<br>
	<br>
	<form name="frmInput" id="frmInput" method="POST">
		<input type="text" name="userinput" id="userinput"
			value="<%=defaultInput%>"><br> <input type=submit
			value="Get It!">
	</form>
	<br><br>
  	Response:<button type="button" onclick="javascript: $('#response').val('');">Clear</button><br><br>
  	<textarea id="response" style="width:800px; height:600px;"></textarea>
	
	<%
		} //end of form presentation if-else block
	%>
	
	<script type="text/javascript">
	$.fn.xmlizeObject = function()
	{
   		var o = '<?xml version="1.0" encoding="UTF-8"?>\n';
   		o += "<input>\n";
   		var a = this.serializeArray();
   		$.each(a, function() {
    		o += "<target>" + this.value + "</target>\n";
   		});
   		o += "</input>";
   		return o;
	};
	$(document).on("submit", "#frmInput", function(event) {
	/* encodeURIComponent() */
	var formObject = $("form#frmInput").xmlizeObject();

	$.ajax({
        accepts: {xml: "text/xml", text: "text/plain"},
        type: "POST",
		contentType: "text/xml",
        url: $("form#frmInput").attr('action'),
        async: true,
        cache: false,
        converters: {"text xml": jQuery.parseXML},
        data: formObject,
        dataType: "text",
        timeout: "5000",
        success : function(result) {
            document.getElementById('response').value = result;
            $('textarea#result').val(result)
        },
        error: function(xhr, resp, text) {
            document.getElementById('response').value = xhr.responseText;
        }
    	});
    event.preventDefault();
	});
	</script>

</body>
</html>