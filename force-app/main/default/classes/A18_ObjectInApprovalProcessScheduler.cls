/**
 * Created by Piotr Kucia on 17.07.2018.
 */

global class A18_ObjectInApprovalProcessScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        A18_ObjectInApprovalProcessBatchClass batchClass = new A18_ObjectInApprovalProcessBatchClass();
        Database.executeBatch(batchClass, 200);
    }

}