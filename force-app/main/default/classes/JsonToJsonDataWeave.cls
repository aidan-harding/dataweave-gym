/**
 * @author aidan@processity.ai
 * @date 11/07/2024
 */

public with sharing class JsonToJsonDataWeave extends PassThroughApexToJsonPerformanceScenario {
    
    private String contactsBeforeString;

    public override void setup(Integer size) {
        super.setup(size);
        contactsBeforeString = JSON.serialize(contactsBefore);
        contactsBefore = null;
    }

    public void run() {
        DataWeave.Script detectFieldChangesScript = new DataWeaveScriptResource.jsonToJson();
        detectFieldChangesScript.execute(
                new Map<String, Object>{
                        'inList' => contactsBeforeString
                }
        ).getValueAsString();
    }
}