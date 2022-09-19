<%
	//*************
	//* GET INPUT *
	//*************
	//READ Input from String
	StringBuffer jb = new StringBuffer();
	String line = null;
	try {
		BufferedReader reader = request.getReader();
		while ((line = reader.readLine()) != null) {
			jb.append(line);
		}
	} catch (Exception e) {
		out.println("Error" + e);
		out.flush();
		return;
	} finally {
	}

	try {
		JSONObject jsonObj = new JSONObject(jb.toString());
		input = (String) jsonObj.get("userinput");
		//out.println("target"); //DO *NOT* Use with getOutputStream
		out.flush();
	} catch (Exception e) {
		out.println("Error" + e);
		out.flush();
		return;
	} finally {
	}
	//####################
	//# END OF GET INPUT #
	//####################
%>