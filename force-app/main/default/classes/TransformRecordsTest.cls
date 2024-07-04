/**
 * @author aidan@processity.ai
 * @date 02/07/2024
 */

@IsTest
private class TransformRecordsTest {

    static List<Contact> contacts = new List<Contact> {
            new Contact(FirstName = 'john', LastName = 'One', MailingState = 'ca'),
            new Contact(LastName = 'Two', MailingState = 'ca')
    };

    @IsTest
    static void contactToObject() {
        List<Transform> transforms = new List<TransformRecordsTest.Transform>{
                new Transform('FirstName', 'first_name', 'capitalize'),
                new Transform('MailingState', 'state', 'upper'),
                new Transform('LastName', 'last_name')
        };

        DataWeave.Script transformScript = new DataWeaveScriptResource.transform();

        DataWeave.Result result = transformScript.execute(new Map<String, Object>{
                'records' => contacts,
                'transforms' => transforms
        });
        List<Object> results = (List<Object>)JSON.deserializeUntyped(result.getValueAsString());

        for(Integer i=0; i < results.size(); i++) {
            Map<String, Object> resultMap = (Map<String, Object>)results[i];

            Assert.areEqual(contacts[i].FirstName?.capitalize(), resultMap.get(transforms[0].targetField));
            Assert.areEqual(contacts[i].MailingState.toUpperCase(), resultMap.get(transforms[1].targetField));
            Assert.areEqual(contacts[i].LastName, resultMap.get(transforms[2].targetField));
        }
    }
    
    @IsTest
    static void contactToLead() {
        List<Transform> transforms = new List<TransformRecordsTest.Transform>{
                new Transform('FirstName', 'FirstName', 'capitalize'),
                new Transform('MailingState', 'State', 'upper'),
                new Transform('LastName', 'LastName')
        };

        DataWeave.Script transformScript = new DataWeaveScriptResource.transform();

        DataWeave.Result result = transformScript.execute(new Map<String, Object>{
                'records' => contacts,
                'transforms' => transforms
        });
        List<Lead> results = (List<Lead>)JSON.deserialize(result.getValueAsString(), List<Lead>.class);

        for(Integer i=0; i < results.size(); i++) {
            Lead resultMap = results[i];

            Assert.areEqual(contacts[i].FirstName?.capitalize(), resultMap.FirstName);
            Assert.areEqual(contacts[i].MailingState.toUpperCase(), resultMap.State);
            Assert.areEqual(contacts[i].LastName, resultMap.LastName);
        }
    }
    
    private class Transform {
        public String sourceField;
        public String targetField;
        public String transformation;

        private Transform(String sourceField, String targetField, String transformation) {
            this.sourceField = sourceField;
            this.targetField = targetField;
            this.transformation = transformation;
        }

        private Transform(String sourceField, String targetField) {
            this.sourceField = sourceField;
            this.targetField = targetField;
        }
    }
}