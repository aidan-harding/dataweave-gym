/**
 * @author aidan@processity.ai
 * @date 17/06/2024
 * @description Detect the list of changes in two lists of records
 */

public class DetectFieldChangesApex {
    
    private Integer fieldsToTrackSize;
    private List<String> fieldsToTrack;

    public DetectFieldChangesApex(List<String> fieldsToTrack) {
        this.fieldsToTrack = fieldsToTrack;
        fieldsToTrackSize = fieldsToTrack.size();
    }
    
    public List<FieldChange> getChanges(List<SObject> oldRecords, List<SObject> newRecords) {
        List<FieldChange> result = new List<FieldChange>();
        for(Integer i=0, size = oldRecords.size(); i < size; i++) {
            result.addAll(getChanges(oldRecords[i], newRecords[i]));
        }
        return result;
    }

    public List<FieldChange> getChanges(SObject oldRecord, SObject newRecord) {
        List<FieldChange> result = new List<FieldChange>();

        if (oldRecord == newRecord) {
            return result;
        }

        for (Integer i = 0; i < fieldsToTrackSize; i++) {
            String thisField = fieldsToTrack[i];
            Object oldValue = oldRecord.get(thisField);
            Object newValue = newRecord.get(thisField);

            // String equality for strings that are run-time typed as Object is not case-sensitive so this more complex
            // than you might want
            if (
                    !(oldValue == null && newValue == null) &&
                            (oldValue != newValue || (oldValue instanceof String && !((String) oldValue).equals((String) newValue)))
            ) {
                String oldValueEntry = JSON.serialize(String.valueOf(oldValue));
                String newValueEntry = JSON.serialize(String.valueOf(newValue));
                result.add(new FieldChange(thisField, oldValueEntry, newValueEntry));
            }
        }
        return result;
    }
}