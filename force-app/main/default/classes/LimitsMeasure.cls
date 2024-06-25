/**
 * @author aidan@processity.ai
 * @date 25/06/2024
 * @description Measures CPU usage and prints to debug so that it can be recorded externally
 */

public class LimitsMeasure {

    private Integer startCpu = Limits.getCpuTime();
    
    public void stopAndPrint() {
        System.debug((Limits.getCpuTime() - startCpu) + '+');
    }
}