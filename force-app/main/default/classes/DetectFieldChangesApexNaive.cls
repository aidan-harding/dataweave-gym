/**
 * @author aidan@processity.ai
 * @date 02/07/2024
 * @description Like DetectFieldChangesApex but as you might write it without thinking too hard about performance 
 * or correctness
 */

public with sharing class DetectFieldChangesApexNaive {
    private List<String> fieldsToTrack;

    public DetectFieldChangesApexNaive(List<String> fieldsToTrack) {
        this.fieldsToTrack = fieldsToTrack;
    }

    public List<FieldChange> getChanges(List<SObject> oldRecords, List<SObject> newRecords) {
        List<FieldChange> result = new List<FieldChange>();
        for(Integer i=0; i < oldRecords.size(); i++) {
            result.addAll(getChanges(oldRecords[i], newRecords[i]));
        }
        return result;
    }

    public List<FieldChange> getChanges(SObject oldRecord, SObject newRecord) {
        List<FieldChange> result = new List<FieldChange>();
        
        for (String thisField : fieldsToTrack) {
            Object oldValue = oldRecord.get(thisField);
            Object newValue = newRecord.get(thisField);

            if (oldValue != newValue) {
                String oldValueEntry = String.valueOf(oldValue);
                String newValueEntry = String.valueOf(newValue);
                result.add(new FieldChange(thisField, oldValueEntry, newValueEntry));
            }
        }
        return result;
    }

}