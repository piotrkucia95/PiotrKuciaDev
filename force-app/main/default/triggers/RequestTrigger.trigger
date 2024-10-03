/**
 * Created by Piotr Kucia on 16.07.2018.
 */

trigger RequestTrigger on Request__c (after insert) {
    if(Trigger_Switch__c.getInstance().RequestTrigger__c) new RequestTriggerHandler().run();
}