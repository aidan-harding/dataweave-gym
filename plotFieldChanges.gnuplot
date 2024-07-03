set datafile separator ','
set xtics nomirror
set ytics nomirror
set fit quiet nolog

set border 3 # Just bottom and left
set size ratio 0.5
set terminal png size 1200,600

apexNaive(x) = a*x + b
fit apexNaive(x) 'apexNaive531.csv' via a,b 

apex(x) = c*x + d
fit apex(x) 'apex531.csv' via c,d 

dataWeave(x) = e*x + f
fit dataWeave(x) 'dataWeave531.csv' via e, f

dataWeaveJson(x) = g*x + h
fit dataWeaveJson(x) 'dataWeaveJson531.csv' via g, h

set style fill solid
set style circle radius 15

set ylabel "CPU Time (ms)"
set xlabel "# records"

set output 'naiveApex.png'
plot [900:6100] [0:*] apexNaive(x) linecolor 1 notitle, "apexNaive531.csv" with circle linecolor 1 title "Naïve Apex"

set output 'bothApex.png'
plot [900:6100] [0:*] apexNaive(x) linecolor 1 notitle, "apexNaive531.csv" with circle linecolor 1 title "Naïve Apex", \
 apex(x) linecolor 2 notitle, "apex531.csv" linecolor 2 with circle title "Apex"

set output 'apexAndDataWeave.png'
plot [900:6100] [0:*] apexNaive(x) linecolor 1 notitle, "apexNaive531.csv" with circle linecolor 1 title "Naïve Apex", \
 apex(x) linecolor 2 notitle, "apex531.csv" linecolor 2 with circle title "Apex", \
  dataWeave(x)  linecolor 3 notitle, "dataWeave531.csv" with circle linecolor 3 title "DataWeave"
  
 set output 'apexAndDataWeave2.png'
  plot [900:6100] [0:*] apexNaive(x) linecolor 1 notitle, "apexNaive531.csv" with circle linecolor 1 title "Naïve Apex", \
   apex(x) linecolor 2 notitle, "apex531.csv" linecolor 2 with circle title "Apex", \
    dataWeave(x)  linecolor 3 notitle, "dataWeave531.csv" with circle linecolor 3 title "DataWeave", \
     dataWeaveJson(x)  linecolor 4 notitle, "dataWeaveJson531.csv" with circle linecolor 4 title "DataWeave JSON" 