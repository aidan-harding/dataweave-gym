%dw 2.0
input inList application/apex
output application/apex
---
inList map ((x) -> x as Object{class: "Contact"})