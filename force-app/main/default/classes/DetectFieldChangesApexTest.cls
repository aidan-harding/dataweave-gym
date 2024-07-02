/**
 * @author aidan@processity.ai
 * @date 02/07/2024
 */

@IsTest
private class DetectFieldChangesApexTest {
    static IdGenerator contactIdGenerator = IdGenerator.getIdGenerator(Contact.SObjectType);
    static List<Contact> oldList = new List<Contact>{
            new Contact(Id = contactIdGenerator.next(), FirstName = 'Sebastian', LastName = 'Roberts'),
            new Contact(Id = contactIdGenerator.next(), FirstName = 'Henry', LastName = 'Cooper')
    };
    static List<Contact> newList = new List<Contact>{
            new Contact(Id = oldList[0].Id, FirstName = 'Sebastian', LastName = 'roberts'),
            new Contact(Id = oldList[1].Id, FirstName = null, LastName = 'Cooper')
    };

    @IsTest
    static void emptyLists() {

        DetectFieldChangesApex detectFieldChanges = new DetectFieldChangesApex(FieldChangeData.fields);

        List<FieldChange> fieldChanges = detectFieldChanges.getChanges(new List<SObject>(), new List<SObject>());

        Assert.isTrue(fieldChanges.isEmpty());
    }

    @IsTest
    static void twoRecords() {
        DetectFieldChangesApex detectFieldChanges = new DetectFieldChangesApex(FieldChangeData.fields);

        List<FieldChange> fieldChanges = detectFieldChanges.getChanges(oldList, newList);

        System.debug(JSON.serialize(fieldChanges));

        Assert.areEqual(2, fieldChanges.size());
        Assert.areEqual('LastName', fieldChanges[0].field);
        Assert.areEqual('Roberts', fieldChanges[0].oldValue);
        Assert.areEqual('roberts', fieldChanges[0].newValue);
        Assert.areEqual(newList[0].Id, fieldChanges[0].recordId);

        Assert.areEqual('FirstName', fieldChanges[1].field);
        Assert.areEqual('Henry', fieldChanges[1].oldValue);
        Assert.areEqual(null, fieldChanges[1].newValue);
        Assert.areEqual(newList[1].Id, fieldChanges[1].recordId);
    }

}