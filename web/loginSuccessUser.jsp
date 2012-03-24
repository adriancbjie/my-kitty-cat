
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


        <%
        // only users can see this page
        if (session.getAttribute("authenticatedUser")==null){
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
    You have successfully logged in as a USER<br/>
    Functions available:<br/>
    <ul>
        <li><a href="transferFunds.jsp">Transfer funds</a></li>
        <li><a href="makePayment.jsp">Make payment</a></li>
        <li><a href="logout.jsp">Log out</a></li>
    </ul>

  </body>
</html>
