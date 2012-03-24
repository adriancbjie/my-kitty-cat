<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

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
        <title>Transfer Funds</title>
    </head>
    <BODY OnLoad="document.myform.transfereeId.focus();" bgcolor="pink">

        <FORM name="myform" METHOD=POST ACTION="processTransferFunds.jsp">
            <table border="1">
                <thead>
                    <tr>
                        <th>Transfer Funds</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Your User ID</td>
                        <td><INPUT TYPE=TEXT NAME=userId SIZE=10 value='<%=userId%>' disabled readonly></td>
                    </tr>
                    <tr>
                        <td>Transferee's User ID</td>
                        <td><INPUT TYPE=TEXT NAME=transfereeId SIZE=10></td>
                    </tr>
                    <tr>
                        <td>Amount to transfer</td>
                        <td><INPUT TYPE=TEXT NAME=amt SIZE=10 value="10"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><INPUT TYPE=SUBMIT value="Transfer"></td>
                    </tr>
                </tbody>
            </table>

        </FORM>

    </BODY>
</html>
