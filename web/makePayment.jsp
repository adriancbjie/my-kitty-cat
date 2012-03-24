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
        <title>Make Payment</title>
    </head>
    <BODY OnLoad="document.myform.amt.focus();" bgcolor="pink">
            <%-- form is posted to ProcessMakePaymentServlet --%>
            <FORM name="myform" METHOD=POST ACTION="processMakePayment">
            <table border="1">
                <thead>
                    <tr>
                        <th>Make Payment</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Bank Id (please use the Bank Id provided to your team)</td>
                        <td><INPUT TYPE=TEXT NAME=bankId value="" SIZE=10></td>
                    </tr>
                    <tr>
                        <td>Bank Password</td>
                        <td><INPUT TYPE=TEXT NAME=bankPwd value="" SIZE=10></td>
                    </tr>
                    <tr>
                        <td>Your User Id</td>
                        <td><INPUT TYPE=TEXT NAME=userId value='<%=userId%>' SIZE=10 disabled readonly></td>
                    </tr>
                    <tr>
                        <td>Reference Id</td>
                        <td><INPUT TYPE=TEXT NAME=referenceId value="0000-0000" SIZE=10></td>
                    </tr>
                    <tr>
                        <td>Amount to pay</td>
                        <td><INPUT TYPE=TEXT NAME=amt value="10" SIZE=10></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><INPUT TYPE=SUBMIT value="Pay"></td>
                    </tr>
                </tbody>
            </table>

        </FORM>

    </body>
</html>
