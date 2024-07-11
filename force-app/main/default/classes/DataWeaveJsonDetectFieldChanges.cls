/**
 * @author aidan@processity.ai
 * @date 11/07/2024
 */

public with sharing class DataWeaveJsonDetectFieldChanges extends DetectFieldChangesPerformanceScenario {
    
    private String contactsBeforeString;
    private String contactsAfterString;

    public override void setup(Integer size) {
        super.setup(size);
        contactsBeforeString = JSON.serialize(contactsBeforeString);
        contactsAfterString = JSON.serialize(contactsAfter);
        
        contactsBefore = null;
        contactsAfter = null;
    }

    public void run() {
        DataWeave.Script detectFieldChangesScript = new DataWeaveScriptResource.detectFieldChangesJson();
        detectFieldChangesScript.execute(
                new Map<String, Object> {
                        'oldList' => JSON.serialize(contactsBefore),
                        'newList' => JSON.serialize(contactsAfter),
                        'fieldList' => JSON.serialize(FieldChangeData.fields)
                }
        ).getValueAsString();
    }
}