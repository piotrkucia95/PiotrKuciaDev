/**
 * Created by Piotr Kucia on 17.07.2018.
 */

public with sharing class A18_RequestOverviewSchedulerExec {

    public A18_RequestOverviewSchedulerExec() {
        A18_RequestOverviewScheduler scheduler = new A18_RequestOverviewScheduler();
        String cronExpression = '0 00 17 ? * FRI';
        String jobID = System.schedule('Request Overview', cronExpression, scheduler);
    }
}