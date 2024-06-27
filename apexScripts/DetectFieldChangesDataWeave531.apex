FieldChangeData fieldChangeDataProvider = new FieldChangeData();
List<Contact> contactsBefore = fieldChangeDataProvider.loadData('ContactsTestData');
List<Contact> contactsAfter = fieldChangeDataProvider.loadData('ContactsTestData531');

contactsBefore = Lists.slice(contactsBefore, 0, size);
contactsAfter = Lists.slice(contactsAfter, 0, size);

LimitsMeasure limitsMeasure = new LimitsMeasure(size);
DataWeave.Script detectFieldChangesScript = new DataWeaveScriptResource.detectFieldChanges();
List<FieldChange> dataWeaveResult = (List<FieldChange>)detectFieldChangesScript.execute(
        new Map<String, Object>{
                'oldList' => contactsBefore,
                'newList' => contactsAfter,
                'fieldList' => FieldChangeData.fields
        }
).getValue();
limitsMeasure.stopAndPrint();