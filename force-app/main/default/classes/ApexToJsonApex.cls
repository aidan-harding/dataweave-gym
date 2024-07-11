/**
 * @author aidan@processity.ai
 * @date 11/07/2024
 */

public inherited sharing class ApexToJsonApex extends PassThroughApexToJsonPerformanceScenario {
    
    public void run() {
        JSON.serialize(contactsBefore);
    }
}