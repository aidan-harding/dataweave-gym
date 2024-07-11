/**
 * @author aidan@processity.ai
 * @date 11/07/2024
 */

public with sharing class ApexToJsonDataWeave extends PassThroughApexToJsonPerformanceScenario {
    
    public void run() {
        DataWeave.Script dataWeaveScript = new DataWeaveScriptResource.apexToJson();
        dataWeaveScript.execute(
                new Map<String, Object>{
                        'inList' => contactsBefore
                }
        ).getValueAsString();
    }
}