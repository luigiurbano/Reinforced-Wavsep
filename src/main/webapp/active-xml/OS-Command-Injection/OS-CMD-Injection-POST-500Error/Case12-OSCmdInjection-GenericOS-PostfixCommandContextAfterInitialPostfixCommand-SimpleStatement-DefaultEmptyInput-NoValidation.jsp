<%@page import="com.nsunina.wavsepenhancement.enums.VulnerabilityType"%>
<%@page import="com.nsunina.wavsepenhancement.constants.FileConstants"%>
<%@page import="com.nsunina.wavsepenhancement.validators.InputValidator"%>
<%@ page language="java" import="org.json.JSONObject"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	trimDirectiveWhitespaces="true" pageEncoding="ISO-8859-1"%>
<%@ include file="include.jsp"%>

	<%
		//*** Re-define Default Exposure Variables - Per Page ***

		//FULL_COMMAND_WITH_OS_PREFIX, FULL_COMMAND_WITHOUT_OS_PREFIX, INVALID_INPUT , EMPTY_INPUT
		//COMMAND_POSTFIX,PARTIAL_COMMAND
		defaultInputType = DefaultInputType.EMPTY_INPUT;

		//ANY, NONE, SLASH_PREFIX, BACKSLASH_PREFIX, 
		//FTP_DIRECTIVE, HTTP_DIRECTIVE, 
		prefixRequired = PrefixRequirement.NONE;

		//WINDOWS, UNIX
		osSimulated = OsType.ANY;

		//Use the default defined in include.jsp
		//ERROR_500, ERROR_404, REDIRECT_302, ERROR_200, VALID_200, Identical_200
		//invalidResponseType = ResponseType.ERROR_200;

		//Use the default defined in include.jsp
		//CONTENT_TYPE_TEXT_HTML ("text/html"), CONTENT_TYPE_STREAM ("application/octet-stream")
		//validResposeStream = ContentConstants.CONTENT_TYPE_TEXT_HTML;

		//OS_PATH, FILE_DIRECTIVE_URL, FTP_URL, HTTP_URL 
		//pathType = PathType.OS_PATH;

	%>
	<%
		String defaultFileName = "eclipse.ini";
	
		boolean isWindows = System.getProperty("os.name").contains("Win");
		String windowsPrefix = "cmd.exe /c type " + defaultFileName + " | findstr ";
		String linuxPrefix = "cat " + defaultFileName + " | grep ";
		String osCommand = "";
		String defaultInput = "";
		prefix = "";
		postfix = "";
		boolean isCommandError = false;
	%>
	<%
		//First set the prefix according to the path type
		if (isWindows) { //If OS Type = Windows Add the cmd prefix
			prefix = windowsPrefix;
		} else {
			prefix = linuxPrefix;
		}

		if(debugMode == true) {
			System.out.println("*****Initial Prefix*****: " + prefix);
		}
		
		if (defaultInputType == DefaultInputType.FULL_COMMAND_WITH_OS_PREFIX) {
			if (isWindows) { //If OS Type = Windows Add the cmd prefix
				defaultInput = "findstr Java";
			} else {
				defaultInput = "grep Java";
			}
		} else if (defaultInputType == DefaultInputType.FULL_COMMAND_WITHOUT_OS_PREFIX) {
			if (isWindows) {
				defaultInput = "Java";
			} else {
				defaultInput = "Java";
			}
		} else if (defaultInputType == DefaultInputType.PARTIAL_COMMAND) {
			//Statement structure: command [input] | postfix command
			defaultInput = "Java";
		} else if (defaultInputType == DefaultInputType.COMMAND_POSTFIX) {
			//Statement structure: command fixed-value | postfix command [input]
			defaultInput = "Build"; //keyword in content.ini file for findstr/grep
		} else if (defaultInputType == DefaultInputType.EMPTY_INPUT) {
			defaultInput = ""; //intentionally flawd/empty input
		} else if (defaultInputType == DefaultInputType.INVALID_INPUT) {
			defaultInput = "fsdfsas"; //intentionally flawd/empty input
		}

		
		if(debugMode == true) {
			System.out.println("*****default input*****: " + defaultInput);
		}
	%>
	
	<%
	if ("GET".equalsIgnoreCase(request.getMethod())) {
	//Present Web Form
%>
<%@ include file="include-send-input.jsp"%>
	<%
		} else { //Ajax
			
			String input = null;
	%>
<%@ include file="include-get-input.jsp"%>
	<%

			boolean inputValidationFailure = false;

			//***************************
			//* Flawed Input Validation *
			//***************************
			//Potential Input Validation / Removal
			if (accessRestriction == FileAccessRestriction.UNIX_TRAVESAL_INPUT_VALIDATION) {
				if (InputValidator.validateUnixTraversal(input)) {
					inputValidationFailure = true;
				}
			} else if (accessRestriction == FileAccessRestriction.UNIX_TRAVESAL_INPUT_REMOVAL) {
				input = InputValidator.removeUnixTraversal(input);
			} else if (accessRestriction == FileAccessRestriction.WINDOWS_TRAVESAL_INPUT_VALIDATION) {
				if (InputValidator.validateWindowsTraversal(input)) {
					inputValidationFailure = true;
				}
			} else if (accessRestriction == FileAccessRestriction.WINDOWS_TRAVESAL_INPUT_REMOVAL) {
				input = InputValidator
						.removeWindowsTraversal(input);
			} else if (accessRestriction == FileAccessRestriction.SLASH_INPUT_VALIDATION) {
				if (InputValidator.validateSlash(input)) {
					inputValidationFailure = true;
				}
			} else if (accessRestriction == FileAccessRestriction.SLASH_INPUT_REMOVAL) {
				input = InputValidator.removeSlash(input);
				System.out.println("alskjalsdkjalsdkjalsdkj file: " + input);
			} else if (accessRestriction == FileAccessRestriction.BACKSLASH_INPUT_VALIDATION) {
				if (InputValidator.validateBackSlash(input)) {
					inputValidationFailure = true;
				}
			} else if (accessRestriction == FileAccessRestriction.BACKSLASH_INPUT_REMOVAL) {
				input = InputValidator.removeBackSlash(input);
			} else if (accessRestriction == FileAccessRestriction.HTTP_INPUT_VALIDATION) {
				if (InputValidator.validateHttp(input)) {
					inputValidationFailure = true;
				}
			} else if (accessRestriction == FileAccessRestriction.HTTP_INPUT_REMOVAL) {
				input = InputValidator.removeHttp(input);
			} else if (accessRestriction == FileAccessRestriction.WHITE_LIST) {
				if (!(input.equals("content.ini") || input.equals("content")
					|| input.equals("content2.ini") || input.equals("content2")
					)) {
					inputValidationFailure = true;
				}
			}

			//***********************
			//* Vulnerability Logic *
			//***********************
			BufferedInputStream bis = null;
			
			try {

				if (inputValidationFailure == true) {
					throw new Exception("Input Validation Failure");
				}

				
				if (debugMode == true) {
					System.out.println("File:" + input);
					System.out.println("prefix:" + prefix);
					System.out.println("postfix:" + postfix);
					System.out.println("Command to run:" + prefix
							+ input + postfix);
					File f = new File(".");
					System.out
							.println("Current Absultoe File Path: "
									+ f.getAbsolutePath());
					System.out
							.println("Current Canonical Dir Path: "
									+ f.getCanonicalPath());
				}
				
				java.lang.Process tempProcess = null;
				//run the command
				try {
					tempProcess = Runtime.getRuntime().exec(prefix + input + postfix);
					tempProcess.waitFor();
				} catch (Exception e) {
					isCommandError = true;
				}

				if (!isCommandError) {

					//$$$set valid response content type$$$
					response.setContentType(validResposeStream);

					//out.println("<br><b><u>Error Stream:</u></b><br>");
					bis = new BufferedInputStream(tempProcess.getInputStream());
					ServletOutputStream ouputStream = response
							.getOutputStream();
					byte byteBuffer[] = new byte[8192];
					while (true) {
						int bytesRead = bis.read(byteBuffer);
						if (bytesRead < 0)
							break;
						ouputStream.write(byteBuffer, 0, bytesRead);
					}
					
					//out.println("<br><b><u>Error Stream:</u></b><br>");
					bis = new BufferedInputStream(tempProcess.getErrorStream());
					while (true) {
						int bytesRead = bis.read(byteBuffer);
						if (bytesRead < 0)
							break;
						ouputStream.write(byteBuffer, 0, bytesRead);
					}

					ouputStream.flush();
					ouputStream.close();
					
					byteBuffer = null;
					
				} else {
					//set errorneous response content type
					//response.setContentType(validResposeStream);

					if (invalidResponseType == ResponseType.ERROR_500) {
						response.sendError(500, "Invalid Input");
					} else if (invalidResponseType == ResponseType.ERROR_404) {
						response.sendError(404, "Content Not Found");
					} else if (invalidResponseType == ResponseType.REDIRECT_302) {
						response.sendRedirect("MissingResource.html");
					} else if (invalidResponseType == ResponseType.ERROR_200) {
						out.println("Invalid Input");
					} else if (invalidResponseType == ResponseType.VALID_200) {
						out.println("The information is unavailable at this time.<BR>"
								+ "Please try again later.");
					} else if (invalidResponseType == ResponseType.IDENTICAL_200) {
						//return a default empty value (found in the default file)
						//if(validResposeStream.equals(ContentConstants.CONTENT_TYPE_TEXT_HTML) ) {
						out.println("'input' is not recognized as an internal or external command, operable program or batch file.");
					}
					out.flush();
				}

			} catch (Exception e) {
				//set errorneous response content type
				//response.setContentType(validResposeStream);
				
				if (invalidResponseType == ResponseType.ERROR_500) {
					response.sendError(500, "Exception details: " + e);
				} else if (invalidResponseType == ResponseType.ERROR_404) {
					response.sendError(404, "File Not Found");
				} else if (invalidResponseType == ResponseType.REDIRECT_302) {
					response.sendRedirect("MissingResource.html");
				} else if (invalidResponseType == ResponseType.ERROR_200) {
					out.println("Exception details: " + e);
				} else if (invalidResponseType == ResponseType.VALID_200) {
					out.println("The information is unavailable at this time.<BR>"
							+ "Please try again later.");
				} else if (invalidResponseType == ResponseType.IDENTICAL_200) {
					//return a default empty value (found in the default file)
					//if(validResposeStream.equals(ContentConstants.CONTENT_TYPE_TEXT_HTML) ) {
					out.println("'input' is not recognized as an internal or external command, operable program or batch file.");
				}
				out.flush();
			} finally {
				try {
					bis.close();
				} catch(Exception e) {
					//do nothing
				}
			}

		} //end of if/else block
	%>