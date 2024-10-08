/**
 * Created by Piotr Kucia on 17.07.2018.
 */

public with sharing class A18_IncidentLogDeleteSchedulerClass {

    public A18_IncidentLogDeleteSchedulerClass() {
        A18_IncidentLogDeleteScheduler scheduler = new A18_IncidentLogDeleteScheduler();

        String cronExpression = '0 0 0 1W * ?';

        String jobID = System.schedule('Incident Log Deletion', cronExpression, scheduler);
    }

}