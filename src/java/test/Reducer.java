package test;

import java.util.HashMap;
import java.util.List;

public class Reducer {

    /**
     * Implement this to provide the reducer function. It is STRONGLY
     * recommended that the reducer have no side-effects (no use of non-local
     * variables).
     *
     * @param key the key given to this reducer to work on; only one key is
     * given, all values for that key are given
     * @param data a list of all values for this key
     * @return a map of key-value pairs which will be placed in the final
     * output. Normally this will be a one entry map, with the provided key and
     * the results of the reduce
     */
    public HashMap reduce(Object key, List data) {
        HashMap<String, Object[]> result = new HashMap<String, Object[]>(1);
        //for each key, do the transfer of funds
        DbBean dbBean = new DbBean();
        try{
            dbBean.connect();
            
            int sumValue = 0;
            for (Object item : data) {
                Object[] val = (Object[]) item;
                String idFrom = (String) key;
                String idTo = (String) val[0];
                int amt = Integer.parseInt((String)val[1]);
                boolean success = dbBean.transferFunds(idFrom, idTo, amt);
                
                Object[] resultValue = {idTo,amt,success};
                
                result.put(idFrom,resultValue);
            }
        
            dbBean.close();
        }catch(Exception e){
            e.printStackTrace();
            System.out.println("reducer failed");
            
        }
       
        return result;
    }
}
