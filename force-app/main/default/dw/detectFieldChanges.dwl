%dw 2.0
input newList application/apex
input oldList application/apex
input fieldList application/apex
output application/apex

fun compareFields(record1, record2, fields) =
    fields filter ((field) -> (record1[field] != record2[field])) map (value, index) -> {
            field: value,
            newValue: record2[value] as String default null,
            oldValue: record1[value] as String default null
        } as Object {class: "FieldChange"}
        
fun compareLists(list1, list2, fields) =
    flatten(list1 map ((record, index) -> compareFields(record, list2[index], fields)))
---
compareLists(oldList, newList, fieldList)