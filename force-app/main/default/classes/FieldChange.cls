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

    public Boolean equals(Object obj) {
        FieldChange other = (FieldChange)obj;
        if(field == 'Birthdate') {
            oldValue = oldValue?.replace('T', ' ');
            newValue = newValue?.replace('T', ' ');
            other.oldValue = other.oldValue?.replace('T', ' ');
            other.newValue = other.newValue?.replace('T', ' ');
            
        }
        return field.equals(other.field)
                && ((oldValue == null && other.oldValue == null) || oldValue?.equals(other.oldValue) == true)
                && ((newValue == null && other.newValue == null) || newValue?.equals(other.newValue) == true);
    }

    public override Integer hashCode() {
        return field.hashCode() ^ (oldValue?.hashCode() ?? 0) ^ (newValue?.hashCode() ?? 0);
    }
}