set datafile separator ','
set xtics nomirror
set ytics nomirror
set fit quiet nolog
set key autotitle columnhead

set border 3 # Just bottom and left
set size ratio 0.5
set terminal png size 1200,600

apexNaive(x) = a*x + b
fit apexNaive(x) 'csv/ApexNaiveDetectFieldChanges.csv' via a,b 

apex(x) = c*x + d
fit apex(x) 'csv/ApexDetectFieldChanges.csv' via c,d 

dataWeave(x) = e*x + f
fit dataWeave(x) 'csv/DataWeaveDetectFieldChanges.csv' via e, f

dataWeaveJson(x) = g*x + h
fit dataWeaveJson(x) 'csv/DataWeaveJsonDetectFieldChanges.csv' via g, h

set style fill solid
set style circle radius 15

set ylabel "CPU Time (ms)"
set xlabel "# records"

set output 'graphs/fieldChangesNaiveApex.png'
plot [900:6100] [0:*] apexNaive(x) linecolor 1 notitle, "csv/ApexNaiveDetectFieldChanges.csv" with circle linecolor 1 title "Naïve Apex"

set output 'graphs/fieldChangesBothApex.png'
plot [900:6100] [0:*] apexNaive(x) linecolor 1 notitle, "csv/ApexNaiveDetectFieldChanges.csv" with circle linecolor 1 title "Naïve Apex", \
 apex(x) linecolor 2 notitle, "csv/ApexDetectFieldChanges.csv" linecolor 2 with circle title "Apex"

set output 'graphs/fieldChangesApexAndDataWeave.png'
plot [900:6100] [0:*] apexNaive(x) linecolor 1 notitle, "csv/ApexNaiveDetectFieldChanges.csv" with circle linecolor 1 title "Naïve Apex", \
 apex(x) linecolor 2 notitle, "csv/ApexDetectFieldChanges.csv" linecolor 2 with circle title "Apex", \
  dataWeave(x)  linecolor 3 notitle, "csv/DataWeaveDetectFieldChanges.csv" with circle linecolor 3 title "DataWeave"
  
set output 'graphs/fieldChangesApexAndDataWeaveWithJson.png'
plot [900:6100] [0:*] apexNaive(x) linecolor 1 notitle, "csv/ApexNaiveDetectFieldChanges.csv" with circle linecolor 1 title "Naïve Apex", \
 apex(x) linecolor 2 notitle, "csv/ApexDetectFieldChanges.csv" linecolor 2 with circle title "Apex", \
  dataWeave(x)  linecolor 3 notitle, "csv/DataWeaveDetectFieldChanges.csv" with circle linecolor 3 title "DataWeave", \
     dataWeaveJson(x)  linecolor 4 notitle, "csv/DataWeaveJsonDetectFieldChanges.csv" with circle linecolor 4 title "DataWeave (JSON input)" 