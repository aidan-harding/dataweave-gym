set datafile separator ','
set xtics nomirror
set ytics nomirror
set fit quiet nolog
set key autotitle columnhead

set border 3 # Just bottom and left
set size ratio 0.5
set terminal png size 1200,600

dataWeave(x) = a*x + b
fit dataWeave(x) 'csv/ApexToJsonDataWeave.csv' via a,b 

apex(x) = c*x + d
fit apex(x) 'csv/ApexToJsonApex.csv' via c,d 

dataWeaveJson(x) = e*x + g
fit dataWeaveJson(x) 'csv/JsonToJsonDataWeave.csv' via e,g 

set style fill solid
set style circle radius 5

set ylabel "CPU Time (ms)"
set xlabel "# records"

set output 'graphs/passthrough1.png'
plot dataWeave(x) linecolor 1 notitle, "csv/ApexToJsonDataWeave.csv" with circle linecolor 1 title "DataWeave"

set output 'graphs/passthrough2.png'
plot dataWeave(x) linecolor 1 notitle, "csv/ApexToJsonDataWeave.csv" with circle linecolor 1 title "DataWeave", \
 apex(x) linecolor 2 notitle, "csv/ApexToJsonApex.csv" linecolor 2 with circle title "Apex"

set output 'graphs/passthrough3.png'
plot dataWeave(x) linecolor 1 notitle, "csv/ApexToJsonDataWeave.csv" with circle linecolor 1 title "DataWeave", \
 apex(x) linecolor 2 notitle, "csv/ApexToJsonApex.csv" linecolor 2 with circle title "Apex", \
  dataWeaveJson(x) linecolor 3 notitle, "csv/JsonToJsonDataWeave.csv" linecolor 3 with circle title "DataWeave JSON to JSON"
