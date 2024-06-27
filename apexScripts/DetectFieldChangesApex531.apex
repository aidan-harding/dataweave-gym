FieldChangeData fieldChangeData = new FieldChangeData();
List<Contact> contactsBefore = fieldChangeData.loadData('ContactsTestData');
List<Contact> contactsAfter = fieldChangeData.loadData('ContactsTestData531');

contactsBefore = Lists.slice(contactsBefore, 0, size);
contactsAfter = Lists.slice(contactsAfter, 0, size);

LimitsMeasure limitsMeasure = new LimitsMeasure(size);
List<FieldChange> result = new DetectFieldChangesApex(FieldChangeData.fields).getChanges(contactsBefore, contactsAfter);
limitsMeasure.stopAndPrint();