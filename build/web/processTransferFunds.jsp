<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="db" scope="request" class="test.DbBean" />
<jsp:setProperty name="db" property="*" />

        <%
        // only users can see this page
        if (session.getAttribute("authenticatedUser")==null){
             %> <jsp:forward page = "login.html" /> <%
        }
        String userId = (String) session.getAttribute("userId");
        %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Process Transfer</title>
    </head>
    <body bgcolor="pink">
        <%
            db.connect();
            String transfereeId = (String) request.getParameter("transfereeId");
            String amtString = request.getParameter("amt");

            boolean amtFormatCorrect = true;
            double amt = 0;
            try {
                amt = Double.parseDouble(amtString);
            } catch (NumberFormatException e) {
                amtFormatCorrect = false;
            }
            boolean status = false;

            if (amtFormatCorrect && transfereeId!= null && transfereeId.trim() != "" && amt <= 0) {
                %><jsp:forward page = "errorTransferFunds.html"/><%
            } else {
                try {
                    status = db.transferFunds(userId, transfereeId, amt);
                    db.close();
                    if (status) {
                        %> <jsp:forward page = "transferSucceeded.jsp" /> <%
                    } else {
                        %> <jsp:forward page = "transferFailed.jsp" /> <%                
                    }
                } catch (SQLException e) {
                    %>An error has occurred: <%=e.getMessage()%><%
                }
            }
        %>
    </body>
</html>
