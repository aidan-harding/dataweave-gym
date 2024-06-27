/**
 * @author aidan@processity.ai
 * @date 27/06/2024
 * @description List utilities that are missing from the standard list class
 */

public class Lists {

    /**
     * Returns a shallow copy of a portion of a List, as a new List. Selected from starIndex to endIndex (endIndex not 
     * included) where starIndex and endIndex represent the index of items in that List. The original List will not 
     * be modified.
     * 
     * @param input a List to slice 
     * @param startIndex index to start copying from in the input List
     * @param endIndex index to stop copying in the input List. The last copied value is the one before this
     *
     * @return a new List portion taken from startIndex to endIndex in the input List
     */
    public static List<SObject> slice(List<SObject> input, Integer startIndex, Integer endIndex) {
        List<SObject> result = new List<SObject>(endIndex - startIndex);
        for(Integer i=startIndex; i < endIndex; i++) {
            result[i-startIndex] = input[i];
        }   
        return result;
    }
}