/**
 * @author aidan@processity.ai
 * @date 27/06/2024
 */

@IsTest
private class DetectFieldChangesDataWeaveTest {

    static DataWeave.Script detectFieldChangesScript = new DataWeaveScriptResource.detectFieldChanges();
    
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
        List<Contact> oldList = new List<Contact>{
                new Contact(FirstName = 'Sebastian', LastName = 'Roberts'),
                new Contact(FirstName = 'Henry', LastName = 'Cooper')
        };
        List<Contact> newList = new List<Contact>{
                new Contact(FirstName = 'Sebastian', LastName = 'roberts'),
                new Contact(FirstName = null, LastName = 'Cooper')
        };
        
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

        Assert.areEqual('FirstName', fieldChanges[1].field);
        Assert.areEqual('Henry', fieldChanges[1].oldValue);
        Assert.areEqual(null, fieldChanges[1].newValue);
    }

    @IsTest
    static void massDataCrossCheckedWithApex() {
        FieldChangeData fieldChangeDataProvider = new FieldChangeData();
        List<Contact> contactsBefore = fieldChangeDataProvider.loadData('ContactsTestData');
        List<Contact> contactsAfter = fieldChangeDataProvider.loadData('ContactsTestData531');
        
        List<FieldChange> apexResult = new DetectFieldChangesApex(FieldChangeData.fields).getChanges(contactsBefore, contactsAfter);
        List<FieldChange> dataWeaveResult = (List<FieldChange>)detectFieldChangesScript.execute(
                new Map<String, Object>{
                'oldList' => contactsBefore,
                'newList' => contactsAfter,
                'fieldList' => FieldChangeData.fields
                }                
        ).getValue();

        Assert.areEqual(apexResult.size(), dataWeaveResult.size());
        for(Integer i=0; i < apexResult.size(); i++) {
            Assert.areEqual(apexResult[i], dataWeaveResult[i], 'Mismatch at ' + i);
        }
    }
    
}