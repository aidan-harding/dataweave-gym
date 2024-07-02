/**
 * @author aidan@processity.ai
 * @date 27/06/2024
 */

@IsTest
private class DetectFieldChangesDataWeaveTest {

    static DataWeave.Script detectFieldChangesScript = new DataWeaveScriptResource.detectFieldChanges();
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

        DataWeave.Result result = detectFieldChangesScript.execute(new Map<String, Object>{
                'newList' => new List<SObject>(),
                'oldList' => new List<SObject>(),
                'fieldList' => FieldChangeData.fields
        });

        List<Object> fieldChanges = (List<Object>)result.getValue();

        Assert.isTrue(fieldChanges.isEmpty());
    }

    @IsTest
    static void twoRecords() {
        DataWeave.Result result = detectFieldChangesScript.execute(new Map<String, Object>{
                'oldList' => oldList,
                'newList' => newList,
                'fieldList' => FieldChangeData.fields
        });

        List<FieldChange> fieldChanges = (List<FieldChange>)result.getValue();

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
    
    @IsTest
    static void twoRecordsJson() {
        detectFieldChangesScript = new DataWeaveScriptResource.detectFieldChangesJson();
        
        DataWeave.Result result = detectFieldChangesScript.execute(new Map<String, Object>{
                'oldList' => JSON.serialize(oldList),
                'newList' => JSON.serialize(newList),
                'fieldList' => JSON.serialize(FieldChangeData.fields)
        });

        List<FieldChange> fieldChanges = (List<FieldChange>)JSON.deserialize(result.getValueAsString(), List<FieldChange>.class);

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