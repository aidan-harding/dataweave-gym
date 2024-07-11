%dw 2.0
input newList application/apex
input oldList application/apex
input fieldList application/apex
output application/apex

fun compareFields(oldRecord, newRecord) =
   fieldList filter ((field) -> (oldRecord[field] != newRecord[field]))
       map (field) -> {
               "recordId": newRecord.Id,
               "field": field,
               "oldValue": oldRecord[field] as String default null,
               "newValue": newRecord[field] as String default null
           } as Object {class: "FieldChange"}
          
---
flatten(oldList map ((oldRecord, index) -> compareFields(oldRecord, newList[index])))