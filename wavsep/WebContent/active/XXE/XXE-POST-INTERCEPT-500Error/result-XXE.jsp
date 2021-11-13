<%@page import="java.io.InputStream"%>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.w3c.dom.Node" %>

<%
	InputStream stream=request.getInputStream();
	String empDetails="";
	try
	{
		DocumentBuilderFactory factory=DocumentBuilderFactory.newInstance();
		DocumentBuilder builder=factory.newDocumentBuilder();
		
		Document document=builder.parse(stream);
		Element root=document.getDocumentElement();
		System.out.println(root.getNodeName());
		NodeList list=document.getElementsByTagName("employee");
	 
		for(int index=0; index<list.getLength(); index++)
		{
			Node node=list.item(index);
			Element element=(Element) node;
			empDetails=empDetails+element.getTextContent()+"<br>";
		}
		out.print(empDetails);
	} 
	catch (Exception e) 
	{
		response.sendError(500, e.getMessage());
	}
%>
