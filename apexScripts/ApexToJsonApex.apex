FieldChangeData fieldChangeDataProvider = new FieldChangeData();
List<Contact> contactsBefore = fieldChangeDataProvider.loadData('ContactsTestData');

contactsBefore = Lists.slice(contactsBefore, 0, size);

LimitsMeasure limitsMeasure = new LimitsMeasure(size);
String result = JSON.serialize(contactsBefore);
limitsMeasure.stopAndPrint();