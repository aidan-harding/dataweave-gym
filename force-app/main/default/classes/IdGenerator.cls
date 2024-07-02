/**
 * @author aidan@processity.ai
 * @date 02/07/2024
 * @description Generates synthetic ids
 */

public class IdGenerator implements Iterator<Id> {
    private final String keyPrefix;
    private Integer count;
    private static Map<SObjectType, IdGenerator> idGenerators = new Map<SObjectType, IdGenerator>();

    private IdGenerator(SObjectType sObjectType) {
        this.keyPrefix = sObjectType.getDescribe(SObjectDescribeOptions.DEFERRED).getKeyPrefix();
        this.count = 0;
    }

    public Boolean hasNext() {
        return true;
    }

    public Id next() {
        return keyPrefix + '00' + String.valueOf(count++).leftPad(10, '0');
    }

    public static IdGenerator getIdGenerator(SObjectType sObjectType) {
        IdGenerator result = idGenerators.get(sObjectType);
        if (result == null) {
            result = new IdGenerator(sObjectType);
            idGenerators.put(sObjectType, result);
        }
        return result;
    }
}
