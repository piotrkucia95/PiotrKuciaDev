/**
 * Created by Piotr Kucia on 16.07.2018.
 */

public with sharing class IncidentLogTriggerHandler extends TriggerHandler {

    public override void afterInsert() {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        for (Incident_Log__c newIncidentLog : (List<Incident_Log__c>)Trigger.new) {
            List<String> mailToAddressList = new List<String>();
            List_Custom_Settings__c mailListSettings = List_Custom_Settings__c.getInstance();
            if(mailListSettings.Email_List__c == NULL){
                mailToAddressList.add('p.kucia@polsource.com');
            } else {
                mailToAddressList = mailListSettings.Email_List__c.split(';');
            }
            mail.setToAddresses(mailToAddressList);
            mail.setCcAddresses(mailToAddressList);
            mail.setReplyTo('p.kucia@polource.com');
            mail.setSenderDisplayName('Salesforce Support');
            mail.setSubject('New Incident Log');
            mail.setPlainTextBody('New Incident Log created. \n'
                    + 'Message: ' +newIncidentLog.Message__c+ '\n'
                    + 'Stack Trace: ' +newIncidentLog.Stack_Trace__c);
        }

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}