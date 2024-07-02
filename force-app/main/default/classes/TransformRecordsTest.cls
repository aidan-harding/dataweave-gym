/**
 * @author aidan@processity.ai
 * @date 02/07/2024
 */

@IsTest
private class TransformRecordsTest {

    @IsTest
    static void testBehavior() {
        List<Contact> contacts = new List<Contact> {
                new Contact(FirstName = 'john', LastName = 'One', MailingState = 'ca'),
                new Contact(LastName = 'Two', MailingState = 'ca')
        };
        
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

        System.debug(result.getValue());
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