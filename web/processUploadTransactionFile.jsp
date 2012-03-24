<%@ page import="javazoom.upload.*" %>
<%@ page import="java.util.*,java.io.*" %>
<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean">
    
  <!-- set the path where trans.txt will be uploaded to on the server machine using the next statement -->
  <jsp:setProperty name="upBean" property="folderstore" value="c:\\temp\\aaproj" />
</jsp:useBean>

<%
    // only admins can see this page
    if (session.getAttribute("authenticatedAdmin")==null){
         %> <jsp:forward page = "login.html" /> <%
    }
%>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Process upload</title>
  </head>
  <body bgcolor="pink">
    <%
    try {
      // decode source request:
      MultipartFormDataRequest data = new MultipartFormDataRequest(request);

      // get the files uploaded:
      Hashtable files = data.getFiles();

      if (!files.isEmpty()) {
        upBean.store(data);
        %>        
        <a href="runTransactionFile.jsp">Run transaction file</a>
           <%
      } else {
    %>
    <h1>Error: no file selected for uploading.</h1>
    <%      }
    } catch (RuntimeException error) {
      // throw its further to print in error-page:
      throw error;
    }
    %>


  </body>
</html>