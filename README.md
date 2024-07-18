# DataWeave Gym

An exploration of DataWeave in Apex: Its flexibility and performance compared to Apex alone. 

## Running performance test

The performance tests are wrapped up in two Apex classes. Each of these start a chain of Queueable Apex that will run 
multiple iterations at multiple sizes. You can start them with anonymous Apex like this:

```apex
DetectFieldChangesPerformanceSuite.run();
```

And (once the first one has finished):

```apex
PassThroughPerformanceSuite.run();
```

The tests create `PerformanceMeasureResult__c`, grouped by `ExperimentName__c`.

## Analysing the data

You can extract and analyse the data however you want. But, here's how I do it...

### Requirements

jq and gnuplot

### Method

Create empty directories for the CSV files and the graphs:

```zsh
mkdir csv
mkdir graphs
```

Then extract all the data to CSV files:

```zsh
sf data query --query 'SELECT ExperimentName__c FROM PerformanceMeasureResult__c GROUP BY ExperimentName__c' --json | jq -r '.result.records[].ExperimentName__c' | xargs -I {} zsh -c "sf data query --query \"SELECT Size__c, CpuTimeInMs__c FROM PerformanceMeasureResult__c WHERE ExperimentName__c = '{}' AND Result__c = 'SUCCESS' ORDER BY Size__c\" --result-format csv > csv/{}.csv"
```

This gets all the experiment names, processes the result with jq, then feeds them into xargs so that they can be queried individually and put into 
CSV files with the experiment name.

Then use `gnuplot` to plot the data. There are scripts included here in the repository. There is one script for each type 
(detecting changes, and pass-through). Each of these script generate multiple graphs:

```zsh
gnuplot -d gnuplot/fieldChanges.gnuplot
gnuplot -d gnuplot/passThrough.gnuplot
```

You will see the results in the graphs/ directory.
