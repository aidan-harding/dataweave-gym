/**
 * @author aidan@processity.ai
 * @date 04/07/2024
 */

@IsTest
private class PassThroughTest {

    @IsTest
    static void testBehavior() {
        DataWeave.Script dwScript = new DataWeaveScriptResource.apexToApex();
        
        List<Contact> contacts = new List<Contact> {
                new Contact(LastName = 'Test One'),
                new Contact(LastName = 'Test Two')
        };
        
        DataWeave.Result result = dwScript.execute(new Map<String, Object> {
                'inList' => contacts
        });
        
        List<Contact> resultList = (List<Contact>)result.getValue();

        Assert.areEqual(contacts, resultList);
    }
}