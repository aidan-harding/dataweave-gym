%dw 2.0
input records application/apex
input transforms application/apex
import * from dw::core::Strings

fun transformValue(value, transformation) = do {
  var functionMap = {
    "capitalize": capitalize,
    "upper": upper,
    "lower": lower,
    "identity": (x) -> x
  }
  ---
  (functionMap[transformation] default functionMap.identity)(value)
}

fun transformRecord(record) = 
    transforms reduce ((item, acc = {}) -> acc ++ { 
        (item.targetField): transformValue((record[item.sourceField]), item.transformation)
    })

---
records map (record) -> transformRecord(record)