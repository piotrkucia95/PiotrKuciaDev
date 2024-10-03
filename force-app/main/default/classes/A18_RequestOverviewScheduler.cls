/**
 * Created by Piotr Kucia on 17.07.2018.
 */

global class A18_RequestOverviewScheduler implements Schedulable{

    global void execute(SchedulableContext sc) {
        A18_RequestOverviewBatchClass batchClass = new A18_RequestOverviewBatchClass();
        Database.executeBatch(batchClass, 200);
    }
}