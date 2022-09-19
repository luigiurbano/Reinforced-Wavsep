
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	trimDirectiveWhitespaces="true" pageEncoding="ISO-8859-1"%>
<%@page import="java.io.*" %>
<%@page import="java.net.*" %>
<%@page import="com.nsunina.wavsepenhancement.encoders.HtmlEncoder" %>
<%@page import="com.nsunina.wavsepenhancement.constants.SystemConstants" %>
<%@page import="com.nsunina.wavsepenhancement.constants.FileConstants" %>
<%@page import="com.nsunina.wavsepenhancement.constants.ContentConstants" %>
<%@page import="com.nsunina.wavsepenhancement.enums.VulnerabilityType" %>
<%@page import="com.nsunina.wavsepenhancement.enums.ResponseType" %>
<%@page import="com.nsunina.wavsepenhancement.enums.DefaultInputType" %>
<%@page import="com.nsunina.wavsepenhancement.enums.FileAccessMethod" %>
<%@page import="com.nsunina.wavsepenhancement.enums.FileAccessRestriction" %>
<%@page import="com.nsunina.wavsepenhancement.enums.FileInjectionContext" %>
<%@page import="com.nsunina.wavsepenhancement.enums.PrefixRequirement" %>
<%@page import="com.nsunina.wavsepenhancement.enums.OsType" %>
<%@page import="com.nsunina.wavsepenhancement.enums.PathType" %>

<%

//*******************************
//* START DEFAULT CONFIGURATION *
//*******************************

//set debug flag from main config
boolean debugMode = SystemConstants.DEBUG_FLAG_DEFAULT_STATE;

//begin setting group definitions
//--------------------------------

//*** Set Default File Access Type ***
//CONTEXT_STREAM, FILE_CLASS, URL_CLASS, FTP_CLASS, INCLUDE, REDIRECT, FORWARD
FileAccessMethod fileAccessMethod = FileAccessMethod.URL_CLASS;

//** Set File Access Restriction ***
//NONE, WHITE_LIST,	LOCAL_FOLDER_ONLY, PERMISSIONS, 
//UNIX_TRAVESAL_INPUT_VALIDATION, UNIX_TRAVESAL_INPUT_REMOVAL, 
//WINDOWS_TRAVESAL_INPUT_VALIDATION, WINDOWS_TRAVESAL_INPUT_REMOVAL,
//SLASH_INPUT_VALIDATION, SLASH_INPUT_REMOVAL,
//BACKSLASH_INPUT_VALIDATION, BACKSLASH_INPUT_REMOVAL,
FileAccessRestriction accessRestriction = FileAccessRestriction.NONE;

//** Set Default Input Format ***
//FULL_PATH_INPUT, RELATIVE_INPUT, INVALID_INPUT, EMPTY_INPUT
DefaultInputType defaultInputType = DefaultInputType.FULL_PATH_INPUT;

//*** Set Default Injection Context ***
/*
FULL_FILENAME, //filename.extension (nothing appended)
FILENAME_ONLY, //filename (fixed extension appended)
DIRECTORY, //directory (fixed filename & extension appended)
EXTENSION; //extension (nothing appended, *NOT IMPLEMENTED*)
*/
FileInjectionContext injectionContext = FileInjectionContext.FULL_FILENAME; 

//set path requirement
//ANY, NONE, SLASH_PREFIX, BACKSLASH_PREFIX,
//FTP_DIRECTIVE, HTTP_DIRECTIVE, 
PrefixRequirement prefixRequired = PrefixRequirement.ANY;							 

//*** set OS simulation (unix default) ***
//WINDOWS, UNIX
//OsType osSimulated = OsType.WINDOWS;

//*** Set Default Response Type ***
//ERROR_500, ERROR_404, REDIRECT_302, ERROR_200, VALID_200, Identical_200
ResponseType invalidResponseType = ResponseType.ERROR_200;
                                  		 
//*** Set Default Content Type ***
//CONTENT_TYPE_TEXT_HTML ("text/html"), CONTENT_TYPE_STREAM ("application/octet-stream")
String validResposeStream = ContentConstants.CONTENT_TYPE_TEXT_HTML; 

//** Set Default File Path/URL Type **
//OS_PATH, FILE_DIRECTIVE_URL, FTP_URL, HTTP_URL 
PathType pathType = PathType.HTTP_URL;

//*** Set Vulnerability Type ***
//LFI, RFI, DIRECTORY_TRAVERSAL, CODE_LFI, CODE_RFI, FALSE_POSITIVE
VulnerabilityType vulnerability = VulnerabilityType.RFI;



//final String URL_TYPE_FTP = "ftp://"; //new URL(new String("ftp://"+user+":"+password+"@"+host+"/"+remotefile+";type=i"));
//*** Set Default Prefix String ***
String prefix = ""; //"",[FULLPATH], "http://","file:/","ftp://"

//obtain deliminters and path information
String fileDelimiter = System.getProperty("file.separator");
String lineDelimiter = System.getProperty("line.separator");

//Initial Path/URL:
String DefaultInitialPath = ""; //Empty
//Current User Directory File Object
File directory = new File (".");
//User Directory Path - Absolute
String userPath = System.getProperty("user.dir");
///Deployement Path Root - Absolute
String documentRootPath =
	getServletConfig().getServletContext().getRealPath("");
//Relative path of current file - Absolute
String currentFilePath = request.getRealPath(request.getServletPath());
//Relative path of current directory - Absolute - No Final Line Delimiter
String currentDirPath = request.getRealPath(
		(request.getServletPath()).split("/Case")[0]);
//Web Path of Root - Relative
String contextPath = this.getServletContext().getContextPath();
//Web Path of File - Relative and *NOT* including ROOT (!)
String contextPathFile = request.getServletPath();
//Web Path of Dir - Relative and *NOT* including ROOT or File Delimiter(!)
String contextRelativeDirPath = (request.getServletPath()).split("/Case")[0];

if (debugMode == true) {
	String BR = "<BR>";
	String FontStart = "<B>";
	String FontEnd = "</B>";
	
	System.out.println ("File delimiter: " + fileDelimiter);
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "File delimiter: " + FontEnd + fileDelimiter + BR);
	}
	System.out.println ("Line delimiter (encoded):" + HtmlEncoder.htmlEncode(lineDelimiter));
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "Line delimiter (encoded): " + FontEnd 
			+ HtmlEncoder.htmlEncode(HtmlEncoder.htmlEncode(lineDelimiter)) + BR);
	}
	
	//User Directory Path - Absolute
	System.out.println ("User Directory Path (Absolute): " + userPath);
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "User Directory Path (Absolute): " + FontEnd + userPath + BR);
	}
	
	///Deployement Path Root - Absolute
	System.out.println ("Deployment Path Root (Absolute): " + documentRootPath);
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "Deployment Path Root (Absolute): " + FontEnd + documentRootPath + BR);
	}
	
	//Relative path of current file - Absolute
	System.out.println ("Deployment Path Current File (Absolute): " + currentFilePath);
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "Deployment Path Current File (Absolute): " + FontEnd + currentFilePath + BR);
	}
	
	//Relative path of current directory - Absolute
	System.out.println ("Deployment Path Current Directory (Absolute): " + currentDirPath);
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "Deployment Path Current Directory (Absolute): " + FontEnd + currentDirPath + BR);
	}
	
	//Web Path of Root - Relative
	System.out.println ("Web Path Root (Relative): " + contextPath);
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "Web Path Root (Relative): " + FontEnd + contextPath + BR);
	}
	
	//Web Path of File - Relative and *NOT* including ROOT (!)
	System.out.println ("Web Path of File (Relative-no-root): " + contextPathFile);
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "Web Path of File (Relative-no-root): " + FontEnd + contextPathFile + BR);
	}
	
	//Web Path of Dir - Relative and *NOT* including ROOT or File Delimiter(!)
	System.out.println ("Web Path of Dir (Relative-no-root): " + contextRelativeDirPath);
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println (FontStart + "Web Path of Dir (Relative-no-root): " + FontEnd + contextRelativeDirPath + BR);
	}
	
	//Full URL:
	System.out.println("request URL: " + request.getRequestURL());
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println(FontStart + "request URL: " + FontEnd + request.getRequestURL() + BR);
	}
	
	//System.out.println(request.getRealPath("/"));
	
	try {
		System.out.println ("Current directory's canonical path: " 
  			+ directory.getCanonicalPath()); 
		if ("GET".equalsIgnoreCase(request.getMethod())) {
			out.println (FontStart + "Current directory's canonical path: " 
			    + FontEnd + directory.getCanonicalPath() + BR);
		}
	   	System.out.println ("Current directory's absolute path: " 
	   		+ directory.getAbsolutePath());
	   	if ("GET".equalsIgnoreCase(request.getMethod())) {
	   		out.println (FontStart + "Current directory's absolute  path: " 
		   	    + FontEnd + directory.getAbsolutePath() + BR);
	   	}
	} catch(Exception e) {
		System.out.println("Exceptione is =" + e.getMessage());
	}
	
	if ("GET".equalsIgnoreCase(request.getMethod())) {
		out.println(BR + BR);
	}
} // end of debug if

//****ways to get the file ****
//1)context.getRequestDispatcher("/").forward(request, response);
//2)File file = new File (currentDirPath + targetFile);
//3)is = getServletContext().getResourceAsStream(contextRelativeDirPath + targetFile);
//4)is = new FileInputStream(currentDirPath + targetFile);
//5)URL url = new URL(URLInitialPath + targetFile);
//   URLConnection urlconn = url.openConnection();
//6)FORWARD (FP)
//6)REDIRECT (FP)

//#############################
//# End Default Configuration #
//#############################

%>
	
<%
//===============================================
%>

<%

	//******************************
	//* START PAGE SPECIFIC CONFIG *
	//******************************

	//*** Re-define Default Exposure Variables - Per Page ***

	//CONTEXT_STREAM, FILE_CLASS, URL_CLASS, FTP_CLASS, INCLUDE, REDIRECT, FORWARD
	fileAccessMethod = FileAccessMethod.URL_CLASS;

	//NONE, WHITE_LIST,	LOCAL_FOLDER_ONLY, PERMISSIONS, 
	//UNIX_TRAVESAL_INPUT_VALIDATION, UNIX_TRAVESAL_INPUT_REMOVAL, 
	//WINDOWS_TRAVESAL_INPUT_VALIDATION, WINDOWS_TRAVESAL_INPUT_REMOVAL,
	//SLASH_INPUT_VALIDATION, SLASH_INPUT_REMOVAL,
	//BACKSLASH_INPUT_VALIDATION, BACKSLASH_INPUT_REMOVAL,
	//HTTP_INPUT_VALIDATION,HTTP_INPUT_REMOVAL
	accessRestriction = FileAccessRestriction.NONE;

	//FULL_PATH_INPUT, RELATIVE_INPUT, INVALID_INPUT , EMPTY_INPUT
	defaultInputType = DefaultInputType.FULL_PATH_INPUT;
	//FULL_FILENAME, FILENAME_ONLY, DIRECTORY, EXTENSION
	injectionContext = FileInjectionContext.FULL_FILENAME;

	//ANY, NONE, SLASH_PREFIX, BACKSLASH_PREFIX, 
	//FTP_DIRECTIVE, HTTP_DIRECTIVE, 
	prefixRequired = PrefixRequirement.ANY;

	//WINDOWS, UNIX
	//osSimulated = OsType.WINDOWS;

	//Use the default defined in include.jsp
	//ERROR_500, ERROR_404, REDIRECT_302, ERROR_200, VALID_200, Identical_200
	//invalidResponseType = ResponseType.ERROR_200;

	//Use the default defined in include.jsp
	//CONTENT_TYPE_TEXT_HTML ("text/html"), CONTENT_TYPE_STREAM ("application/octet-stream")
	//validResposeStream = ContentConstants.CONTENT_TYPE_TEXT_HTML;

	//OS_PATH, FILE_DIRECTIVE_URL, FTP_URL, HTTP_URL 
	pathType = PathType.HTTP_URL;

	//LFI, RFI, DIRECTORY_TRAVERSAL, CODE_LFI, CODE_RFI, FALSE_POSITIVE
	vulnerability = VulnerabilityType.RFI;
	
	
	//############################
	//# End PAGE SPECIFIC CONFIG #
	//############################

%>
	
<%
//===============================================
%>

<%@page import="com.nsunina.wavsepenhancement.enums.VulnerabilityType"%>
<%@page import="com.nsunina.wavsepenhancement.constants.FileConstants"%>
<%@page import="com.nsunina.wavsepenhancement.validators.InputValidator"%>
<%@ page language="java" import="org.json.JSONObject"%>

	
<%
	//@@@@@@@@@@@@@@@@@@@@@@@
	//@ GLOBAL LOGIC MODULE @
	//@@@@@@@@@@@@@@@@@@@@@@@
	
	//global definitions
	String targetFile = null;
	
	//First set the prefix according to the path type
	if (pathType == PathType.OS_PATH) { //LFI-TRAVERSAL
		if (fileAccessMethod == FileAccessMethod.FILE_CLASS) {
			prefix = currentDirPath; //current application directory
		} else {
			prefix = contextRelativeDirPath; //current application directory
		}
	} else if (pathType == PathType.FILE_DIRECTIVE_URL) { //LFI-TRAVERSAL
		prefix = currentDirPath;
		//file:/ will be added later to the URL, according to req
		//support "file:/" in windows by replacing \ to / 
		if (fileDelimiter.equals("\\")) {
			try {
				prefix = prefix.replaceAll("\\", "/");
			} catch (Exception e) {
			} finally {}
		}
	} else if (pathType == PathType.FTP_URL) { //RFI
		prefix = (prefixRequired == PrefixRequirement.ANY ? "" : FileConstants.FTP_PREFIX);
	} else if (pathType == PathType.HTTP_URL) { //RFI
		//refix = request.getContextPath() + "/"; //current application directory
		prefix = (prefixRequired == PrefixRequirement.ANY ? "" : FileConstants.HTTP_PREFIX);
	}
		
	if(debugMode == true) {
		System.out.println("*****Initial Prefix*****: " + prefix);
	}
	
	String defaultTargetFile = null;
	String defaultBasePath = null;
	//set the default base path of the default input
	if (defaultInputType == DefaultInputType.FULL_PATH_INPUT
			|| defaultInputType == DefaultInputType.INVALID_INPUT) {
		if (fileAccessMethod == FileAccessMethod.FILE_CLASS) {
			//current eclipse/web server directory
			defaultBasePath = currentDirPath /*directory.getCanonicalPath()*/
					+ fileDelimiter;
			if (pathType == PathType.FILE_DIRECTIVE_URL) {
				defaultBasePath = FileConstants.FILE_PREFIX
						+ defaultBasePath;
			}
		} else if (fileAccessMethod == FileAccessMethod.INCLUDE) {
			//current application directory
			defaultBasePath = currentDirPath + fileDelimiter;
		} else if (fileAccessMethod == FileAccessMethod.CONTEXT_STREAM) {
			//current application directory
			defaultBasePath = contextRelativeDirPath + "/";
		} else if (fileAccessMethod == FileAccessMethod.URL_CLASS
				|| fileAccessMethod == FileAccessMethod.REDIRECT
				|| fileAccessMethod == FileAccessMethod.FORWARD) {
			defaultBasePath = (prefixRequired == PrefixRequirement.ANY ? FileConstants.HTTP_PREFIX : "")
			        + request.getServerName() + ":" +
					request.getServerPort() + request.getContextPath() + 
					contextRelativeDirPath + "/";
				//request.getContextPath() + "/"; //current application directory
		} else if (fileAccessMethod == FileAccessMethod.FTP_CLASS) {
			defaultBasePath = (prefixRequired == PrefixRequirement.ANY ? FileConstants.FTP_PREFIX : "")
					+ request.getServerName() + ":"
					+ FileConstants.FTP_PORT/*21*/+ "/"
					+ contextRelativeDirPath;
		} else {
			throw new Exception(
					"Unsupported FileAccessMethod for Default URL Base Path");
		}
	} else if (defaultInputType == DefaultInputType.RELATIVE_INPUT
		|| defaultInputType == DefaultInputType.EMPTY_INPUT) {
		//relative to current dir path
		defaultBasePath = FileConstants.EMPTY_PREFIX;
	} else {
		throw new Exception(
				"Unsupported DefaultInputType for Default URL Base Path");
	}

	//****************************************************************
	//* alter default filename according to the FileInjectionContext *
	//****************************************************************
	switch (injectionContext) {
	case FULL_FILENAME:
		if (defaultInputType == DefaultInputType.FULL_PATH_INPUT) {
			//file in web application directory
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE;
		} else if (defaultInputType == DefaultInputType.RELATIVE_INPUT) {
			//file in eclipse directory
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_NOT_LOCAL;
			if (pathType == PathType.FILE_DIRECTIVE_URL) {
				defaultTargetFile = FileConstants.FILE_PREFIX
						+ FileConstants.DEFAULT_TARGET_FILE_ROOT_DIR;
			}
			if(vulnerability == VulnerabilityType.RFI) {
					defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE;
			}
		} else {
			//empty or invalid default input types: override at the end for all cases
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_ROOT_DIR;
		}
		/*
		if(fileAccessMethod == FileAccessMethod.FILE_CLASS && 
		   pathType == PathType.OS_PATH && prefixRequired != PrefixRequirement.ANY) {
		    
		} else if (pathType == PathType.FILE_DIRECTIVE_URL){
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_ROOT_DIR;
		} else {
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_NOT_LOCAL;
		}*/

		if (prefixRequired == PrefixRequirement.BACKSLASH_PREFIX) {
			defaultTargetFile = "\\" + defaultTargetFile; //serve as a directory
		} else if (prefixRequired == PrefixRequirement.SLASH_PREFIX) {
			defaultTargetFile = "/" + defaultTargetFile; //serve as a directory
		}

		break;

	case FILENAME_ONLY:
		if (defaultInputType == DefaultInputType.FULL_PATH_INPUT) {
			//file in web application directory
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_NAME_ONLY;
		} else if (defaultInputType == DefaultInputType.RELATIVE_INPUT) {
			//file in eclipse directory
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_NAME_ONLY_NOT_LOCAL;
			if (pathType == PathType.FILE_DIRECTIVE_URL) {
				defaultTargetFile = FileConstants.FILE_PREFIX
						+ FileConstants.DEFAULT_TARGET_FILE_NAME_ONLY_ROOT_DIR;
			}
			if(vulnerability == VulnerabilityType.RFI) {
				defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE;
			}
		} else {
			//empty or invalid default input types: override at the end for all cases
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_NAME_ONLY_ROOT_DIR;
		}
		/*
		if(fileAccessMethod == FileAccessMethod.FILE_CLASS && 
		   pathType == PathType.OS_PATH && prefixRequired != PrefixRequirement.ANY) {
		} else if (pathType == PathType.FILE_DIRECTIVE_URL){
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_NAME_ONLY_ROOT_DIR;
		} else {
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_NAME_ONLY_NOT_LOCAL;
		}*/
		if (prefixRequired == PrefixRequirement.BACKSLASH_PREFIX) {
			defaultTargetFile = "\\" + defaultTargetFile; //serve as a directory
		} else if (prefixRequired == PrefixRequirement.SLASH_PREFIX) {
			defaultTargetFile = "/" + defaultTargetFile; //serve as a directory
		}

		break;

	case EXTENSION:
		defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_EXTENSION;
		break;

	case DIRECTORY:
		//only test cases for directories in app are supported (so far)
		defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_DIRECTORY;

		if (prefixRequired == PrefixRequirement.BACKSLASH_PREFIX) {
			defaultTargetFile = "\\" + defaultTargetFile + "\\"; //serve as a directory
		} else if (prefixRequired == PrefixRequirement.SLASH_PREFIX) {
			defaultTargetFile = "/" + defaultTargetFile + "/"; //serve as a directory
		} else if (pathType == PathType.OS_PATH
				&& fileDelimiter.equals("\\")
				&& fileAccessMethod == FileAccessMethod.FILE_CLASS) {
			defaultTargetFile = defaultTargetFile + "\\"; //serve as a directory
		} else {
			defaultTargetFile = defaultTargetFile + "/"; //serve as a directory;
		}
		break;
	default:
		break;
	}

	//************************************************************
	//* alter prefixRequired according to the PrefixRequirement *
	//************************************************************
	switch (prefixRequired) {
	case ANY: //Don't Add Any Prefix
		prefix = FileConstants.EMPTY_PREFIX;
		break;
	case NONE: //Add Full Path Prefix
		if (pathType == PathType.OS_PATH) {
			prefix = prefix + fileDelimiter; //OS specific
		} else if (pathType == PathType.FILE_DIRECTIVE_URL) { //File Directive
			prefix = prefix + "/";
		}
		//add nothing in FTP, HTTP
		break;
	case SLASH_PREFIX: //leave prefix intact, already missing /
		break;
	case BACKSLASH_PREFIX: //leave prefix intact, already missing \
		break;
	case FTP_DIRECTIVE: //require ftp:// and optional fullpath
		prefix = FileConstants.EMPTY_PREFIX;
		if (pathType != PathType.FTP_URL) {
			throw new Exception(
					"Requirement Mismatch - FTP directive can only be used with FTP URL");
		}
		break;
	case HTTP_DIRECTIVE: //require http:// and optional fullpath
		prefix = FileConstants.EMPTY_PREFIX;
		if (pathType != PathType.HTTP_URL) {
			throw new Exception(
					"Requirement Mismatch - HTTP directive can only be used with HTTP URL");
		}
		break;
	default:
		break;
	}
		if (debugMode == true) {
		//#####Debug#####
		System.out.println("\n");
		System.out.println("Default Target File (Prior to Concat): "
				+ defaultTargetFile);
		System.out.println("Default Base Path (Prior to Concat): "
				+ defaultBasePath);
	}
		if (prefixRequired == PrefixRequirement.ANY || prefixRequired == PrefixRequirement.NONE) {
		//default file: concat with base directory
		defaultTargetFile = defaultBasePath + defaultTargetFile;
	}
		//if default input is empty/invalid,
	//make sure it will be so in post forms as well
	if (defaultInputType == DefaultInputType.INVALID_INPUT) {
		//overrun with invalid input (content not found)
		switch (injectionContext) {
		case FULL_FILENAME:
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_INVALID;
			break;
		case FILENAME_ONLY:
			defaultTargetFile = FileConstants.DEFAULT_TARGET_FILE_NAME_ONLY_INVALID;
		case EXTENSION:
			defaultTargetFile = FileConstants.DEFAULT_EXTENSION_INVALID;
		case DIRECTORY: //same as default
		default:
			defaultTargetFile = FileConstants.DEFAULT_DIRECTORY_INVALID
					+ fileDelimiter;
			break;
		}
		defaultTargetFile = defaultBasePath + defaultTargetFile;//concat with base directory
	} else if (defaultInputType == DefaultInputType.EMPTY_INPUT) {
		//overrun with empty input
		defaultTargetFile = FileConstants.EMPTY_INPUT;
	}
	if (pathType == PathType.FILE_DIRECTIVE_URL) {
		defaultTargetFile = defaultTargetFile.replace("\\", "/");
	}

	if (debugMode == true) {
		//#####Debug#####
		System.out.println("Default Target File: " + defaultTargetFile);
		System.out.println("Default Base Path: " + defaultBasePath);
	}
%>


<%
	if ("GET".equalsIgnoreCase(request.getMethod())) {
	//Present Web Form
%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remote File Inclusion Test Case</title>
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
			value="<%=defaultTargetFile%>"><br> 
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
			value="<%=defaultTargetFile%>"><br> <input type=submit
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
			value="<%=defaultTargetFile%>"><br> <input type=submit
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

	<%
	} else { //NOT a GET Request - Ajax Call
		
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
		} finally {}
		
		try {
		    JSONObject jsonObj = new JSONObject(jb.toString());
		    targetFile = (String)jsonObj.get("userinput");
		    out.println("target"); //=========================================
		    out.flush();
		} catch (Exception e) {
		    out.println("Error" + e);
		    out.flush();
		} finally {}
		//####################
		//# END OF GET INPUT #
		//####################
	

		//***************
		//* Validations *
		//***************
		boolean inputValidationFailure = false;

		//Potential Input Validation / Removal
		if (accessRestriction == FileAccessRestriction.UNIX_TRAVESAL_INPUT_VALIDATION) {
			if (InputValidator.validateUnixTraversal(targetFile)) {
				inputValidationFailure = true;
			}
		} else if (accessRestriction == FileAccessRestriction.UNIX_TRAVESAL_INPUT_REMOVAL) {
			targetFile = InputValidator.removeUnixTraversal(targetFile);
		} else if (accessRestriction == FileAccessRestriction.WINDOWS_TRAVESAL_INPUT_VALIDATION) {
			if (InputValidator.validateWindowsTraversal(targetFile)) {
				inputValidationFailure = true;
			}
		} else if (accessRestriction == FileAccessRestriction.WINDOWS_TRAVESAL_INPUT_REMOVAL) {
			targetFile = InputValidator
					.removeWindowsTraversal(targetFile);
		} else if (accessRestriction == FileAccessRestriction.SLASH_INPUT_VALIDATION) {
			if (InputValidator.validateSlash(targetFile)) {
				inputValidationFailure = true;
			}
		} else if (accessRestriction == FileAccessRestriction.SLASH_INPUT_REMOVAL) {
			targetFile = InputValidator.removeSlash(targetFile);
			System.out.println("alskjalsdkjalsdkjalsdkj file: " + targetFile);
		} else if (accessRestriction == FileAccessRestriction.BACKSLASH_INPUT_VALIDATION) {
			if (InputValidator.validateBackSlash(targetFile)) {
				inputValidationFailure = true;
			}
		} else if (accessRestriction == FileAccessRestriction.BACKSLASH_INPUT_REMOVAL) {
			targetFile = InputValidator.removeBackSlash(targetFile);
		} else if (accessRestriction == FileAccessRestriction.HTTP_INPUT_VALIDATION) {
			if (InputValidator.validateHttp(targetFile)) {
				inputValidationFailure = true;
			}
		} else if (accessRestriction == FileAccessRestriction.HTTP_INPUT_REMOVAL) {
			targetFile = InputValidator.removeHttp(targetFile);
		} else if (accessRestriction == FileAccessRestriction.WHITE_LIST) {
			if (!(targetFile.equals("content.ini") || targetFile.equals("content")
				|| targetFile.equals("content2.ini") || targetFile.equals("content2")
				|| targetFile.equals(defaultBasePath + "content.ini") 
				|| targetFile.equals(defaultBasePath + "content"))) {
				inputValidationFailure = true;
			}
		}
		//add initial prefix to target file
		//targetFile = prefix + targetFile; 

		if (debugMode == true) {
			//#####Debug#####
			System.out.println("\n\n");
			System.out.println("Final Relative Access:"
					+ contextRelativeDirPath + "/" + targetFile);
			System.out.println("Final Full Access:" + currentDirPath
					+ "/" + targetFile);
			System.out.println("Target File: " + targetFile + "\n");
		}
		//######################
		//# End of Validations #
		//######################
		
		
		//*********************************************************
		//* alter targeFile according to the FileInjectionContext *
		//*********************************************************
		switch (injectionContext) {
		case FULL_FILENAME:
			//leave intact - full control over the filename 
			break;
		case FILENAME_ONLY:
			//add the default extension to the file
			//(limit control to name and not the extention)
			targetFile = targetFile + "."
					+ FileConstants.DEFAULT_TARGET_FILE_EXTENSION;
			break;
		case EXTENSION:
			//###NOT implemented in mainstream tests###
			throw new Exception(
					"EXTENSION injection context not implemented");
		case DIRECTORY:
			//input should include slash/backslash suffix
			//to simplify the test cases, all dir cases must be fullpath
			targetFile = targetFile /*serve as a directory*/
					+ FileConstants.DEFAULT_TARGET_FILE;
			break;
		default:
			break;
		}

		
		//***********************
		//* Vulnerability Logic *
		//***********************
		InputStream is = null;
		File file = null; //Unnecessary
	
		try {

			if (inputValidationFailure == true) {
				throw new Exception("Input Validation Failure");
			}
	
			if (vulnerability == VulnerabilityType.LFI
					|| vulnerability == VulnerabilityType.DIRECTORY_TRAVERSAL) {
				//Local File Inclusion / Directory Traversal
		
				//choose file access method
				if (fileAccessMethod == FileAccessMethod.CONTEXT_STREAM
						&& pathType == PathType.OS_PATH) {
					//Vulnerable to LFI / Traversal
	
					is = getServletContext().getResourceAsStream(
							prefix /*contextPathDir*/+ targetFile);

					//FileInjectionContext
				} else if (fileAccessMethod == FileAccessMethod.FILE_CLASS
						&& pathType == PathType.FILE_DIRECTIVE_URL) {
					//Vulnerable to LFI / Traversal					
					if (prefixRequired == PrefixRequirement.ANY) {
						//Effectively Requires FILE_DIRECTIVE
						//Do nothing - leave file intact
						//Represents input in the format of file:/file.ext
						//without any real restriction
					} else if (prefixRequired == PrefixRequirement.NONE) {
						targetFile = FileConstants.FILE_PREFIX
								+ currentDirPath + "/" + targetFile; //should work even with full path since file:// works
					} else if (prefixRequired == PrefixRequirement.SLASH_PREFIX) {
						//targetFile = (FileConstants.FILE_PREFIX).substring(0,FileConstants.FILE_PREFIX.length()-1)
						//+ targetFile; //should work even with full path since file:// works
						targetFile = FileConstants.FILE_PREFIX
								+ currentDirPath + targetFile; // without / between path & file 
					} else if (prefixRequired == PrefixRequirement.BACKSLASH_PREFIX) {
						targetFile = FileConstants.FILE_PREFIX
								+ currentDirPath + targetFile; // without / between path & file 
					} else {
						targetFile = FileConstants.FILE_PREFIX
								+ targetFile; //should work even with full path since file:// works
					}
					if (debugMode == true) {
						System.out.println("File:" + targetFile);
						System.out.println("prefix:" + prefix);
						System.out.println("File to access:" + prefix
								+ targetFile);
						File f = new File(".");
						System.out
								.println("Current Absultoe File Path: "
										+ f.getAbsolutePath());
						System.out
								.println("Current Canonical Dir Path: "
										+ f.getCanonicalPath());
					}
					URL url = new URL(targetFile);
					try {
						file = new File(url.toURI());
					} catch (URISyntaxException e) {
						file = new File(url.getPath());
					} finally {}
					is = new FileInputStream(file);

				} else if (fileAccessMethod == FileAccessMethod.FILE_CLASS
						&& pathType == PathType.OS_PATH) {
					//file = new File(currentDirPath + targetFile);
					//is = new FileInputStream(file);
					if (debugMode == true) {
						System.out.println("File to access:" + prefix
								+ targetFile);
						File f = new File(".");
						System.out.println("Current Absultoe File Path: "
										+ f.getAbsolutePath());
						System.out.println("Current Canonical Dir Path: "
										+ f.getCanonicalPath());
					}
					//f = new File(prefix + targetFile);
					//is = new FileInputStream(f);
					is = new FileInputStream(prefix + targetFile);
				} else {
					//In the future - Forward
					throw new Exception(
							"Unsupported file access method");
				}
	
			} else if (vulnerability == VulnerabilityType.RFI) {
			//Remote File Inclusion (Not Including Code Inclusion)

				//choose file access method
				if (fileAccessMethod == FileAccessMethod.FTP_CLASS
					&& pathType == PathType.FTP_URL) {
					//NOT Implemented
					throw new Exception(
						"Unsupported file access method");
				//code sample: http://www.kodejava.org/examples/357.html
				//is = new FileInputStream(targetFile);
				} else if (fileAccessMethod == FileAccessMethod.URL_CLASS
					&& pathType == PathType.HTTP_URL) {
				//$$$$$For RFI or unauthorized localhost access$$$$$
					URL url = null;
					URLConnection urlconn = null;
					if(prefixRequired == PrefixRequirement.ANY) {
						if(defaultInputType == DefaultInputType.RELATIVE_INPUT) {
							if(!(targetFile.toLowerCase()).contains(FileConstants.HTTP_PREFIX)) {
								//If it's a relative input and it does not contain current dir path - add it
								//Logic: simulate the behaviour of development languages that use a common class for
								//relative and remote file access
								//Supports both remote and relative input in this case
								targetFile = FileConstants.HTTP_PREFIX + request.getServerName() 
						             + ":" + request.getServerPort() 
		 				  			 + request.getContextPath() 
		 				  			 + (contextRelativeDirPath.replace("index.jsp","")) + "/"
		 				  			 + targetFile;	
							}
						}
						url = new URL(targetFile);
						urlconn = url.openConnection();
					} else if(prefixRequired == PrefixRequirement.NONE) {
						url = new URL(prefix + targetFile);
						urlconn = url.openConnection();
					} else {
						throw new Exception(
							"Unsupported prefix in RFI test case");
					}
					is = urlconn.getInputStream();
				} else {
					throw new Exception(
						"Unsupported file access method");
				}

			} else if (vulnerability == VulnerabilityType.CODE_RFI
				|| vulnerability == VulnerabilityType.CODE_LFI) {
				//Code Inclusion
				throw new Exception("Unsupported vulnerability type");

			} else if (vulnerability == VulnerabilityType.FALSE_POSITIVE) {
				//False Positive
				if (fileAccessMethod == FileAccessMethod.FORWARD) {
					getServletConfig().getServletContext()
							.getRequestDispatcher(targetFile)
							.forward(request, response);
					return;
				} else if (fileAccessMethod == FileAccessMethod.REDIRECT) {
					//might be vulnerable to open redirect, but not rfi/lfi
					response.sendRedirect(targetFile);
					return;
				} else {
					//In the future - Forward
					throw new Exception(
							"Unsupported file access method");
				}

				//Implement for File / URL / Stream
			} else {
				throw new Exception("Unsupported vulnerability type");
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
				out.println("<xml><fileContent><user>Kuekuatsu</user><role>manager</role></fileContent></xml>");
			}
			out.flush();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (Exception ignored) {
					//do nothing
				} finally {}
			}
		}
		//##############################
		//# End of Vulnerability Logic #
		//##############################

		
		//******************
		//* PRESENT OUTPUT *
		//******************
		//try catch block for presenting the output (file/url/etc)
		try {
		
			//access the local/remote file
			if (is != null) {

				//$$$set valid response content type$$$
				response.setContentType(validResposeStream);

				BufferedInputStream bis = new BufferedInputStream(is);
				ServletOutputStream ouputStream = response
						.getOutputStream();
				byte byteBuffer[] = new byte[8192];
				while (true) {
					int bytesRead = is.read(byteBuffer);
					if (bytesRead < 0) {
						break;
					}
					ouputStream.write(byteBuffer, 0, bytesRead);
				}
	
				ouputStream.flush();
				ouputStream.close();
				
				byteBuffer = null;
	
			} else {
				//set errorneous response content type
				//response.setContentType(validResposeStream);
	
				if (invalidResponseType == ResponseType.ERROR_500) {
					response.sendError(500, "Invalid File Name");
				} else if (invalidResponseType == ResponseType.ERROR_404) {
					response.sendError(404, "File Not Found");
				} else if (invalidResponseType == ResponseType.REDIRECT_302) {
					response.sendRedirect("MissingResource.html");
				} else if (invalidResponseType == ResponseType.ERROR_200) {
					out.println("Invalid File Name");
				} else if (invalidResponseType == ResponseType.VALID_200) {
					out.println("The information is unavailable at this time.<BR>"
							+ "Please try again later.");
				} else if (invalidResponseType == ResponseType.IDENTICAL_200) {
					//return a default empty value (found in the default file)
					//if(validResposeStream.equals(ContentConstants.CONTENT_TYPE_TEXT_HTML) ) {
					out.println("<xml><fileContent><user>Kuekuatsu</user><role>manager</role></fileContent></xml>");
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
				out.println("<xml><fileContent><user>Kuekuatsu</user><role>manager</role></fileContent></xml>");
			}
			out.flush();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (Exception ignoredEx) {
					//do nothing
				} finally {
					//do nothing
				}
			}
		}
		//#################
		//# END OF OUTPUT #
		//#################
	%>
				
				
<%
	}//end of outer if GET else POST block
%>