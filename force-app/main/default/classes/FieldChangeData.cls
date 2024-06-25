/**
 * @author aidan@processity.ai
 * @date 25/06/2024
 */

public with sharing class FieldChangeData {
    public List<Contact> loadData(String filename) {
        return (List<Contact>)JSON.deserialize(
                [SELECT Body FROM StaticResource WHERE Name = :filename].Body.toString(),
                List<Contact>.class);
    }
}