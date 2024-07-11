/**
 * @author aidan@processity.ai
 * @date 10/07/2024
 * @description Runs the CPU tests for detecting field changes
 */

public with sharing class DetectFieldChangesPerformanceSuite {

    public static void run() {
        List<PerformanceScenario> experimentsToRun = new List<PerformanceScenario> {
                new ApexDetectFieldChanges(),
                new ApexNaiveDetectFieldChanges(),
                new DataWeaveDetectFieldChanges(),
                new DataWeaveJsonDetectFieldChanges()
        };
        
        new PerformanceSuite(experimentsToRun)
                .setStartSize(1000)
                .setStepSize(1000)
                .setEndSize(6000)
                .setRepetitions(20)
                .run();
    }
}