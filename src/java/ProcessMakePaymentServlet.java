import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.*;
import java.util.concurrent.Future;

import test.DbBean;

public class ProcessMakePaymentServlet extends HttpServlet {

    private final ExecutorService executor = Executors.newFixedThreadPool(1);

    // Study this method carefully
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // initialize parameters for invoking remote method
        final String bankId = request.getParameter("bankId");
        final String bankPwd = request.getParameter("bankPwd");
        final String userId = (String) request.getSession().getAttribute("userId");
        final String payeeId = userId;
        final String referenceId = request.getParameter("referenceId");
        final double amt = Double.parseDouble(request.getParameter("amt"));

        // these 2 things need to be done.
        boolean successfulDebit = false;
        boolean successfullyInformedPaymentGateway = false;

        //submit a new executor to inform payment gateway
        Future<Boolean> future = executor.submit(new Callable() {
            public Boolean call() {
                boolean result = false;

                try {
                    // create new instances of remote Service objects
                    org.tempuri.Service service = new org.tempuri.Service();
                    org.tempuri.ServiceSoap port = service.getServiceSoap();

                    // contact payment gateway by invoking remote pay web service method here.
                    result = port.pay(bankId, bankPwd, payeeId, referenceId, amt);

                } catch (Exception e) {
                    e.printStackTrace();
                }
                return result;
            }
        });

        // actual output to the Web page
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // process debit
            successfulDebit = debitAccount(userId, amt);

            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet processMakePayment</title>");
            out.println("</head>");
            out.println("<body>");

            //wait for result from the executor
            successfullyInformedPaymentGateway = future.get();

            if (successfulDebit && successfullyInformedPaymentGateway) {
                System.out.println("Payment to gateway was successful.");
                recordPaymentMade(userId, amt, referenceId);
            } else if (!successfullyInformedPaymentGateway) {
                out.println("Payment to gateway failed, crediting amt back.");
                creditAccount(userId, amt);
            } else if (!successfulDebit) {
                out.println("Unable to debit from your account.");
            }

            if (successfulDebit) {
                out.println("<br/>-----<br/>");
                out.println("Total payment made so far to gateway: " + getTotalPaymentMade());
            }

        } catch (Exception ex) {
            // show error msg
            out.println("---<br/>");
            out.println("Unable to process payment because of an exception<br/>");
            out.println("Exception: " + ex.getMessage() + "<br/>");
            out.println("---<br/>");
        }

        // show results
        out.println("<br/>-----<br/>");
        out.println("Result of debit: " + (successfulDebit ? "Successful" : "NOT Successful") + "<br/>");
        out.println("Result of payment: " + (successfullyInformedPaymentGateway ? "Successful" : "NOT Successful") + "<br/>");


        // show hyperlinks
        out.println("<br/><br/>");
        out.println("Click <a href='loginSuccessUser.jsp'>here</a> to return to menu<br/>");
        out.println("Click <a href='makePayment.jsp'>here</a> to make another payment<br/>");
        out.println("</body></html>");
        out.close();
    }

    // records a successful payment made
    private void recordPaymentMade(String userId, double amt, String refId) throws Exception {
        DbBean db = new DbBean();
        db.connect();
        db.recordPayment(userId, amt, refId);
    }

    // records a successful payment made
    private double getTotalPaymentMade() throws Exception {
        DbBean db = new DbBean();
        db.connect();
        return db.getTotalPaymentMade();
    }

    // debits userId's balance by amt
    private boolean debitAccount(String userId, double amt) throws Exception {
        DbBean db = new DbBean();
        db.connect();

        boolean result = db.debit(userId, amt);
        return result;
    }

    // credits userId's balance by amt
    private boolean creditAccount(String userId, double amt) throws Exception {
        DbBean db = new DbBean();
        db.connect();

        boolean result = db.credit(userId, amt);
        return result;
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
