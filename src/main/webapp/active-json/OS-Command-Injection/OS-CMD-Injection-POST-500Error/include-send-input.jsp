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
$.fn.serializeObject = function()
{
   var o = {};
   var a = this.serializeArray();
   $.each(a, function() {
       if (o[this.name]) {
           if (!o[this.name].push) {
               o[this.name] = [o[this.name]];
           }
           o[this.name].push(this.value || '');
       } else {
           o[this.name] = this.value || '';
       }
   });
   return o;
};
$(document).on("submit", "#frmInput", function(event) {
    var formObject = JSON.stringify($("form#frmInput").serializeObject());
    $.ajax({
        url: $("form#frmInput").attr('action'),
        type : "POST",
        dataType : 'json',
        async: true,
        data : formObject,
        contentType : "application/json",
        success : function(result) {
            document.getElementById('response').value = result;
            $('textarea#result').val(result)
        },
        error: function(xhr, resp, text) {
          //response has to be fully on json
          //content type of this doc must be changed to "application/json"
          document.getElementById('response').value = xhr.responseText;
        }
    });
  event.preventDefault();
});
</script>

</body>
</html>