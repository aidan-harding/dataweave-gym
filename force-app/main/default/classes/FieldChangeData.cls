/**
 * @author aidan@processity.ai
 * @date 25/06/2024
 */

public with sharing class FieldChangeData {
    
    public final static List<String> fields = new List<String> {
            'FirstName','LastName','Email','Birthdate','Description','MailingStreet','MailingCity','MailingState','MailingCountry'
    };


    public List<Contact> loadData(String filename) {
        return (List<Contact>)JSON.deserialize(
                [SELECT Body FROM StaticResource WHERE Name = :filename].Body.toString(),
                List<Contact>.class);
    }
}