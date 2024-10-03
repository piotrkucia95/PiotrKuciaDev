/**
 * Created by Piotr Kucia on 16.07.2018.
 */
//example trigger
trigger AccountTrigger on Account (after insert, after update) {
    if(Trigger_Switch__c.getInstance().AccountTrigger__c) {
        AccountTriggerHandler handler = new AccountTriggerHandler();
        handler.afterInsert(Trigger.new);
    }
}