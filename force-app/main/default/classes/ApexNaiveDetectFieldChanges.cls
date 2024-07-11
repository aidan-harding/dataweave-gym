/**
 * @author aidan@processity.ai
 * @date 10/07/2024
 */

public inherited sharing class ApexNaiveDetectFieldChanges extends DetectFieldChangesPerformanceScenario {

    public void run() {
        new DetectFieldChangesApexNaive(FieldChangeData.fields).getChanges(contactsBefore, contactsAfter);
    }
}