<%
//*************
		//* GET INPUT *
		//*************
		 //READ Input from String
		StringBuffer xb = new StringBuffer();
	    String line = null;
		try {
		    BufferedReader reader = request.getReader();
		    while ((line = reader.readLine()) != null) {
		      xb.append(line);
		    }
		} catch (Exception e) {
		    out.println("Error" + e);
		    out.flush();
		    return;
		} finally {}
		
		try {
			SAXBuilder saxBuilder = new SAXBuilder();
			Document document = saxBuilder.build(new StringReader(xb.toString()));
			input = document.getRootElement().getChildText("target");
		    //out.println("target"); //DO *NOT* Use with getOutputStream
		    out.flush();
		} catch (Exception e) {
		    out.println("Error" + e);
		    out.flush();
		    return;
		} finally {}
		//####################
		//# END OF GET INPUT #
		//####################
%>