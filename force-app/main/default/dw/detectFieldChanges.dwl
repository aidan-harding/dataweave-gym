%dw 2.0
input newList application/apex
input oldList application/apex
input fieldList application/apex
output application/apex

fun compareFields(record1, record2) =
    fieldList filter ((field) -> (record1[field] != record2[field])) 
        map (value) -> {
                recordId: record1.Id,
                field: value,
                newValue: record1[value] as String default null,
                oldValue: record2[value] as String default null
            } as Object {class: "FieldChange"}
            
---
flatten(newList map ((record, index) -> compareFields(record, oldList[index])))