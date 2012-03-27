package test;

// OpenCSV is used here: check out http://opencsv.sourceforge.net/#how-to-read
// API at http://opencsv.sourceforge.net/api/au/com/bytecode/opencsv/CSVReader.html
import au.com.bytecode.opencsv.CSVReader;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

// This class is used to run a transaction file
// dependency: uses DbBean.java
public class TransactionFileBean {

    private long startTime; // used to store the start time before the transactions start
    private DbBean dbBean;
    private PrintWriter outFile; // for logging

    // main method - can be executed independently from the Web application
    public static void main(String[] args) throws Exception {
        TransactionFileBean b = new TransactionFileBean();
        b.performTransactionsInFile();
    }

    // constructor
    public TransactionFileBean() {
        try {
            // connect to DB via DbBean
            dbBean = new DbBean();
            dbBean.connect();

            // log file path and name is hardcoded here.x : hard code fixed!
            //properties file to read url
            Properties props = new Properties();
            java.net.URL url = test.TransactionFileBean.class.getResource("../all.properties");
            props.load(new FileInputStream(url.getPath()));
            //please specify absolute path in all.properties
            String transLogUrl = props.getProperty("trans_log_output_url");
            
            outFile = new PrintWriter(new FileWriter(transLogUrl));

        } catch (IOException e) {
            System.out.println("FATAL ERROR: Unable to write to transaction log file.");
            System.exit(1);
        } catch (Exception e) {
            System.out.println("FATAL ERROR: " + e.getMessage());
            System.exit(1);
        }
    }

    // the method which actually parses the transaction file and runs the transactions.
    // returns the time taken for this process in msec.
    public long performTransactionsInFile() throws Exception {
        try {
            // again... path of source file is hardcoded here (bad idea) <-- Adrian: no worries, bad habits can be fixed ;)
            //properties file to read url, if you prefer.
            Properties props = new Properties();
            java.net.URL url = TransactionFileBean.class.getResource("../all.properties");
            props.load(new FileInputStream(url.getPath()));
            String transUrl = props.getProperty("trans_url");
         
            CSVReader reader = new CSVReader(new FileReader(transUrl));
            List<String> data = reader.readAll();
            // ---------------- you may wish to optimise this part - adrian says: ok prof :D
            Mapper mapper = new Mapper(); //create mapper object
            Reducer reducer = new Reducer(); //create reducer object
            HashMap<Object, List> results = null;

            startTimer();

            //Here we start the map reduce job on number of shards
            results = MapReduce.mapReduce(mapper, reducer, data, 2);
            //Print out results to log file
            for (Object key : results.keySet()) {
                List values = results.get(key);
                for (Object o : values) {
                    Object[] value = (Object[])o;
                    // log status of transaction
                    log("transfering $" + key + " from " + value[0] + " to " + value[1] + ". Status: " + value[2]);
                }
            }

            // ---------------- end optimise
            long stoppedTime = stopTimer();
            
            String transactionHealth = "";
            //check for validations errors in transactions
            if (dbBean.TOTAL_CASH_IN_WORLD == dbBean.getTotalBalance())
            {
                if(dbBean.getNoOfAccountsWithNegativeBalance() <= 0)
                {
                    transactionHealth += "HEALTHY: the balance matches and there are no accounts with negative balance";
                }else{
                    transactionHealth += " | there are accounts with negative balance |";
                }
            }else{
                transactionHealth += " | balance does not tally with total money in bank | ";
            }
            
            //tommi add the log for me thanks :D
            //replace this
            System.out.println(transactionHealth);
            
            return stoppedTime;
            
        } catch (IOException e) {
            log("ERROR: " + e.getMessage());
            log("Likely cause: unable to read from trans.txt ");
            throw e;
        } catch (NoSuchElementException e) {
            log("ERROR: " + e.getMessage());
            log("Likely cause: incorrect format of transaction file");
            throw e;
        } catch (ArrayIndexOutOfBoundsException e) {
            log("ERROR: " + e.getMessage());
            log("Likely cause: incorrect format of transaction file");
            throw e;
        } catch (NumberFormatException e) {
            log("ERROR: " + e.getMessage());
            log("Likely cause: incorrect format of transaction file");
            throw e;
        }
        finally {
            // clean up
            outFile.close();
            dbBean.close();
        }
    }

    // leave a String in log file
    private void log(String msg) {
        outFile.println(msg);
    }

    // sets startTime to current clock time
    private void startTimer() {
        startTime = new Date().getTime();
    }

    // returns no. of mseconds elapsed since startTimer() was called
    private long stopTimer() {
        return (new Date().getTime()) - startTime;
    }
}
