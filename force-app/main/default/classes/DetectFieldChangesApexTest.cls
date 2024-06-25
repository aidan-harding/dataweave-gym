/**
 * @author aidan@processity.ai
 * @date 17/06/2024
 */

@IsTest
private class DetectFieldChangesApexTest {

    
    
    @IsTest
    static void noChange() {
        List<Contact> contacts = loadData('ContactsTestData');
        List<String> fields = new List<String> {
                'FirstName','LastName','Email','Birthdate','Description','MailingStreet','MailingCity','MailingState','MailingCountry'
        };
        Test.startTest();
        List<FieldChange> result = new DetectFieldChangesApex(fields).getChanges(contacts, contacts);
        Test.stopTest();

        Assert.isTrue(result.isEmpty());
    }

    @IsTest
    static void changes531() {
        List<Contact> contactsBefore = loadData('ContactsTestData');
        List<Contact> contactsAfter = loadData('ContactsTestData531');
        List<String> fields = new List<String> {
                'FirstName','LastName','Email','Birthdate','Description','MailingStreet','MailingCity','MailingState','MailingCountry'
        };
        Test.startTest();
        List<FieldChange> result = new DetectFieldChangesApex(fields).getChanges(contactsBefore, contactsAfter);
        Test.stopTest();

        Assert.areEqual(7151, result.size());
    }
    
    private static List<Contact> loadData(String filename) {
        return (List<Contact>)JSON.deserialize(
                [SELECT Body FROM StaticResource WHERE Name = :filename].Body.toString(), 
                List<Contact>.class);
    }
}