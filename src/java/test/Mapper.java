package test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author kevinsteppe
 */
public class Mapper {

    /**
     * Implement this to provide the mapping function. It is STRONGLY
     * recommended that the map have no side-effects (no use of non-local
     * variables).
     *
     * @param list the data shard for this mapper
     * @return a map of key-value pairs which will be combined from all mappers
     * and given to the reducers
     */
    public HashMap map(List list) {
        HashMap<String, Object[]> map = new HashMap<String, Object[]>(1); //map to be returned

        for (int i = 0; i < list.size(); i++) {
            String[] item = (String[]) list.get(i);
            //idFrom is key
            String key = item[0];
            //store idTo and amount into an array as the value of the hash
            Object[] val = new Object[2];
            val[0] = item[1];
            val[1] = item[2];
            map.put(key, val);
        }

        return map;
    }
}
