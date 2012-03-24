
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
session.setAttribute("userId", null);
session.setAttribute("authenticatedAdmin", null);
session.setAttribute("authenticatedUser", null);
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="pink">
        You have successfully logged out. <br/>
        Click <a href="login.html">here</a> to log in again.
    </body>
</html>
