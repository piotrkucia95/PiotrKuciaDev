/**
 * Created by Piotr Kucia on 16.07.2018.
 */

trigger IncidentLogTrigger on Incident_Log__c (after insert) {
    if(Trigger_Switch__c.getInstance().IncidentLogTrigger__c) new IncidentLogTriggerHandler().run();
}