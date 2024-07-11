/**
 * @author aidan@processity.ai
 * @date 11/07/2024
 * @description Setup and teardown for pass-through tests
 */

public abstract inherited sharing class PassThroughApexToJsonPerformanceScenario implements PerformanceScenario {

    protected List<Contact> contactsBefore;
    
    public virtual void setup(Integer size) {
        contactsBefore = new FieldChangeData().loadData('ContactsTestData', size);
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    public void teardown() {
    }
}