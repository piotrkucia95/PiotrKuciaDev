/**
 * Created by Piotr Kucia on 17.07.2018.
 */

public with sharing class A18_ObjectInApprovalProcessSchedulerExec {

    public A18_ObjectInApprovalProcessSchedulerExec() {
        A18_ObjectInApprovalProcessScheduler scheduler = new A18_ObjectInApprovalProcessScheduler();
        String cronExpression = '0 0 6 ? * MON-FRI';
        String jobID = System.schedule('Approval Process E-mail Notification', cronExpression, scheduler);
    }
}