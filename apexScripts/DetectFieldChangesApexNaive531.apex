FieldChangeData fieldChangeDataProvider = new FieldChangeData();
List<Contact> contactsBefore = fieldChangeDataProvider.loadData('ContactsTestData');
List<Contact> contactsAfter = fieldChangeDataProvider.loadData('ContactsTestData531');

contactsBefore = Lists.slice(contactsBefore, 0, size);
contactsAfter = Lists.slice(contactsAfter, 0, size);

LimitsMeasure limitsMeasure = new LimitsMeasure(size);
List<FieldChange> result = new DetectFieldChangesApexNaive(FieldChangeData.fields).getChanges(contactsBefore, contactsAfter);
limitsMeasure.stopAndPrint();