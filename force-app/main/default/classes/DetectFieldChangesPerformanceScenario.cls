/**
 * @author aidan@processity.ai
 * @date 11/07/2024
 * @description Setup and teardown for detect field changes performance tests
 */

public inherited sharing abstract class DetectFieldChangesPerformanceScenario implements PerformanceScenario {

    protected List<Contact> contactsBefore;
    protected List<Contact> contactsAfter;
    
    public virtual void setup(Integer size) {
        FieldChangeData fieldChangeDataProvider = new FieldChangeData();
        contactsBefore = fieldChangeDataProvider.loadData('ContactsTestData', size);
        contactsAfter = fieldChangeDataProvider.loadData('ContactsTestData531', size);
    }
    
    @SuppressWarnings('PMD.EmptyStatementBlock')
    public void teardown() {
    }
}