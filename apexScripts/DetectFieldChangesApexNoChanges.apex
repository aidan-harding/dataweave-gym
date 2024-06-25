FieldChangeData fieldChangeData = new FieldChangeData();
List<Contact> contacts = fieldChangeData.loadData('ContactsTestData');
List<String> fields = new List<String> {
        'FirstName','LastName','Email','Birthdate','Description','MailingStreet','MailingCity','MailingState','MailingCountry'
};

LimitsMeasure limitsMeasure = new LimitsMeasure();
List<FieldChange> result = new DetectFieldChangesApex(fields).getChanges(contacts, contacts);
limitsMeasure.stopAndPrint();

Assert.isTrue(result.isEmpty());