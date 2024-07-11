/**
 * @author aidan@processity.ai
 * @date 10/07/2024
 */

public inherited sharing class ApexDetectFieldChanges extends DetectFieldChangesPerformanceScenario {
    
    public void run() {
        new DetectFieldChangesApex(FieldChangeData.fields).getChanges(contactsBefore, contactsAfter);
    }
}