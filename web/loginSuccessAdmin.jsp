<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


        <%
        // only administrators can see this page
        if (session.getAttribute("authenticatedAdmin")==null){
             %> <jsp:forward page = "login.html" /> <%
        }
        String userId = (String) session.getAttribute("userId");
        %>
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body bgcolor="pink">
    Your ID is: <%=userId%><br/>
    You have successfully logged in as an ADMINISTRATOR<br/>
    Functions available:<br/>
    <ul>
        <li><a href="viewPaymentMade.jsp">View all payments made</a></li>
        <li><a href="viewAllAccounts.jsp">View all accounts</a></li>
        <li><a href="uploadTransactionFile.jsp">Upload and Execute transaction file</a></li>
        <li><a href="logout.jsp">Log out</a></li>
    </ul>
  </body>
</html>
