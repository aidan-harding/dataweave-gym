/**
 * @author aidan@processity.ai
 * @date 11/07/2024
 * @description Runs the CPU tests for pass-through in DataWeave and Apex
 */

public with sharing class PassThroughPerformanceSuite {

    public static void run() {
        List<PerformanceScenario> experimentsToRun = new List<PerformanceScenario> {
                new ApexToJsonApex(),
                new ApexToJsonDataWeave(),
                new JsonToJsonDataWeave()
        };

        new PerformanceSuite(experimentsToRun)
                .setStartSize(10)
                .setStepSize(10)
                .setEndSize(1000)
                .setRepetitions(10)
                .run();
    }
}