/**
 * Created by Piotr Kucia on 16.07.2018.
 */
//example trigger
trigger ContactTrigger on Contact (before insert, before update, after delete) {

    if(Trigger_Switch__c.getInstance().ContactTrigger__c) {
        ContactTriggerHandler handler = new ContactTriggerHandler();

        switch on Trigger.operationType {
            when BEFORE_INSERT {
                handler.beforeInsert(Trigger.new);
            }
            when BEFORE_UPDATE {
                handler.beforeUpdate(Trigger.new, Trigger.oldMap);
            }
            when AFTER_DELETE {
                handler.afterDelete(Trigger.old);
            }
        }
    }
}