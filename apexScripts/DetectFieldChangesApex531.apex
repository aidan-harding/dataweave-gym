FieldChangeData fieldChangeData = new FieldChangeData();
List<Contact> contactsBefore = fieldChangeData.loadData('ContactsTestData');
List<Contact> contactsAfter = fieldChangeData.loadData('ContactsTestData531');
List<String> fields = new List<String> {
        'FirstName','LastName','Email','Birthdate','Description','MailingStreet','MailingCity','MailingState','MailingCountry'
};

LimitsMeasure limitsMeasure = new LimitsMeasure();
List<FieldChange> result = new DetectFieldChangesApex(fields).getChanges(contactsBefore, contactsAfter);
limitsMeasure.stopAndPrint();

Assert.areEqual(7153, result.size());
