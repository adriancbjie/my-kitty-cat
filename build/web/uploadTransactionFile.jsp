<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
    // only admins can see this page
    if (session.getAttribute("authenticatedAdmin")==null){
         %> <jsp:forward page = "login.html" /> <%
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload Transaction File</title>
    </head>
    <body bgcolor="pink">
        Upload Transaction File<br/><br/>
        
        Specify the location of your transaction file (trans.txt) on your computer, and click Upload to upload it to the server.<br/>
        Note that the filename must be trans.txt.<br/>
        <br/>
        <form action="processUploadTransactionFile.jsp"
              method="post" enctype="multipart/form-data" >
            <input type="file" name="user" />
            <br />
            <input type="submit" name="Submit" value="Upload" />
        </form>
        <br/>
        <a href="loginSuccessAdmin.html">Back to main menu</a>
    </body>
</html>
