<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
  "http://www.w3.org/TR/html4/loose.dtd">

<%
    // only admins can see this page
    if (session.getAttribute("authenticatedAdmin")==null){
         %> <jsp:forward page = "login.html" /> <%
    }
%>

<jsp:useBean id="transactBean" scope="request" class="test.TransactionFileBean" />

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Run Transaction File</title>
  </head>
  <body bgcolor="pink">
    <%
    //properties file to read url
    Properties props = new Properties();
    java.net.URL url = test.TransactionFileBean.class.getResource("../all.properties");
    props.load(new FileInputStream(url.getPath()));
    String transUrl = props.getProperty("trans_url");

    File f = new File(transUrl);
    if (!f.exists()) {
    %><h1>File does not exist!</h1><%      } else {
      try {
        long timeElapsed = transactBean.performTransactionsInFile();
    %><h1>Completed processing in <%=timeElapsed%> ms.</h1><%
      } catch (IOException e) {
    %><h1>IOException occurred:<%=e.getMessage()%></h1><%
      } catch (NoSuchElementException e) {
    %>
    <h1>NoSuchElementException occurred:<%=e.getMessage()%></h1><%
      } catch (NumberFormatException e) {
    %>
    <h1>NumberFormatException occurred:<%=e.getMessage()%></h1><%
      } catch (SQLException e) {
    %>
    <h1>SQLException occurred:<%=e.getMessage()%></h1><%
      }
    %>Please see trans.log<%
    }
    %>
        <br/>
        <a href="loginSuccessAdmin.jsp">Back to main menu</a>
  </body>
</html>
