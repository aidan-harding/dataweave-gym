FieldChangeData fieldChangeDataProvider = new FieldChangeData();
List<Contact> contactsBefore = fieldChangeDataProvider.loadData('ContactsTestData');

contactsBefore = Lists.slice(contactsBefore, 0, size);

LimitsMeasure limitsMeasure = new LimitsMeasure(size);
DataWeave.Script detectFieldChangesScript = new DataWeaveScriptResource.apexToJson();
String result = detectFieldChangesScript.execute(
        new Map<String, Object>{
                'inList' => contactsBefore
        }
).getValueAsString();
limitsMeasure.stopAndPrint();