<%@page import="org.apache.log4j.Logger"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<% Logger logger = Logger.getLogger( "processLogin.jsp" ); %>

<jsp:useBean id="db" scope="request" class="test.DbBean" />
<jsp:setProperty name="db" property="*" />

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Process Login</title>
    </head>
    <body bgcolor="pink">
        <%
            db.connect();
            String id = (String) request.getParameter("id");
            String password = (String) request.getParameter("password");

            if (id == null || password == null || id.trim() == "" || password.trim()=="") {
        %>
        <jsp:forward page = "errorInvalidInputs.jsp"/>
        <%
            } else {
                try {
                    int status = db.login(id, password);
                    // login returns -1 for failure, 0 for admin, 1 for user
                    db.close();
                    if (status==-1) {
                        session.setAttribute("userId",null);
                        session.setAttribute("authenticatedUser",null);
                        session.setAttribute("authenticatedAdmin",null);
        %> <jsp:forward page = "loginFailure.html" /> <%
                    } else if (status==0){
                        session.setAttribute("userId",id);
                        session.setAttribute("authenticatedAdmin",true);
                        logger.info("Admin has logon");
        %> <jsp:forward page = "loginSuccessAdmin.jsp" /> <%
                    } else if (status==1){
                        session.setAttribute("userId",id);
                        session.setAttribute("authenticatedUser",true);
                        logger.info(id + " has logon");
        %> <jsp:forward page = "loginSuccessUser.jsp" /> <%
                    }
                 } catch (SQLException e) {
        %>
        <h1>An error has occurred: <%=e.getMessage()%></h1>
        <%
                }
            }
        %>
    </body>
</html>
