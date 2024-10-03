/**
 * Created by Piotr Kucia on 18.07.2018.
 */

trigger AssetTrigger on Asset__c (after insert, after update) {

    static AssetTriggerHandler handler = new AssetTriggerHandler();

    switch on Trigger.operationType {
        when AFTER_INSERT {
            AssetTriggerHandler.afterInsert(Trigger.new);
        }
        when AFTER_UPDATE {
            handler.afterUpdate(Trigger.new);
        }
    }
}