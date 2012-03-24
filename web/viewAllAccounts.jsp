<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="db" scope="request" class="test.DbBean" />
<jsp:setProperty name="db" property="*" />


<%
    // only admins can see this page
    if (session.getAttribute("authenticatedAdmin")==null){
         %> <jsp:forward page = "login.html" /> <%
    }
%>



<%!
        ResultSet rs = null ;
        ResultSetMetaData rsmd = null ;
        int numColumns ;
        int i;
        double balanceTotal = 0;
%>


<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View All Accounts</title>
  </head>

  <body bgcolor="pink">
      View All Accounts<br/>
      <a href="loginSuccessAdmin.jsp">Back to main menu</a><br/>
    <%
    db.connect();

    try {
      db.execSQL("USE bank");
      rs = db.execSQL("SELECT * FROM accounts");
      rsmd = rs.getMetaData();
      numColumns = rsmd.getColumnCount();
    } catch (SQLException e) {
    %>An error has occurred: <%=e.getMessage()%><%
    }

    %>
    <table border="1">
      <thead>
        <tr>
          <td>ID</td>
          <td>Balance</td>
          <td>password</td>
          <td>type</td>
        </tr>
      </thead>
          <%
    while (rs.next()) {
      balanceTotal += rs.getDouble("balance");
          %>
      <tr>
        <td><%= rs.getString("id")%></td>
        <td><%= rs.getString("balance")%></td>
        <td><%= rs.getString("password")%></td>
        <td><%= rs.getString("type")%></td>
      </tr>
      <%
    }
      %>
    </table>
    <h2>Total Balance: <%=balanceTotal%></h2>
    <%
    balanceTotal = 0;
    db.close();
    %>
  </body>

</html>
