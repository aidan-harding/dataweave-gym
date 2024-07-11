/**
 * @author aidan@processity.ai
 * @date 10/07/2024
 */

public inherited sharing class DataWeaveDetectFieldChanges extends DetectFieldChangesPerformanceScenario {

    public void run() {
        DataWeave.Script detectFieldChangesScript = new DataWeaveScriptResource.detectFieldChanges();
        
        detectFieldChangesScript.execute(
                new Map<String, Object>{
                        'oldList' => contactsBefore,
                        'newList' => contactsAfter,
                        'fieldList' => FieldChangeData.fields
                }
        ).getValue();
    }
}