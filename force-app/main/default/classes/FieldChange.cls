/**
 * @author aidan@processity.ai
 * @date 17/06/2024
 */

public class FieldChange {
    public String field;
    public String oldValue;
    public String newValue;

    public FieldChange(String field, String oldValue, String newValue) {
        this.field = field;
        this.oldValue = oldValue;
        this.newValue = newValue;
    }
}