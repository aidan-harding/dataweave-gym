%dw 2.0
input newList application/json
input oldList application/json
input fieldList application/json
output application/json

fun compareFields(record1, record2) =
    fieldList filter ((field) -> (record1[field] != record2[field])) 
        map (field) -> {
                "recordId": record1.Id,
                "field": field,
                "newValue": record1[field] as String default null,
                "oldValue": record2[field] as String default null
            } as Object {class: "FieldChange"}
            
---
flatten(newList map ((record, index) -> compareFields(record, oldList[index])))