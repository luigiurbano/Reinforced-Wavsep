<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="org.json.JSONObject"%>
<%@ page language="java" import="java.io.BufferedReader"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-2.2.4.min.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Case 1 - RXSS via tag injection into the scope of an HTML page</title>
</head>
<body>
<%
if ("GET".equalsIgnoreCase(request.getMethod())) {
%>
  Enter your input:<br><br>
  <form name="frmInput" id="frmInput" method="POST">
    <input type="text" name="userinput" id="userinput"><br>
    <input type="submit" value="submit">
  </form>
  <br><br>
  Response:<button type="button" onclick="javascript: $('#response').val('');">Clear</button><br><br>
  <textarea id="response" style="width:800px; height:600px;"></textarea>
  
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
<%
} //end of if/else block
else {
  StringBuffer jb = new StringBuffer();
  String line = null;
  try {
    BufferedReader reader = request.getReader();
    while ((line = reader.readLine()) != null)
      jb.append(line);
    } catch (Exception e) {
    out.println("Error" + e);
    out.flush();
    }
    try {
        JSONObject jsonObj = new JSONObject(jb.toString());
        out.println(jsonObj.get("userinput"));
        out.flush();
      } catch (Exception e) {
      out.println("Error" + e);
      out.flush();
      }
} //end of if/else block
%>
