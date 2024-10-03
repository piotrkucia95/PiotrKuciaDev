/**
 * Created by Piotr Kucia on 17.07.2018.
 */

global class A18_ObjectInApprovalProcessBatchClass implements Database.Batchable<sObject> {
    String query;

    public A18_ObjectInApprovalProcessBatchClass() {
        Approval_Process_Settings__c APSettings = Approval_Process_Settings__c.getInstance();
        Integer daysLimit = (Integer)APSettings.Maximum_Days_In_AP__c;
        this.query = 'SELECT ActorId FROM ProcessInstanceWorkItem WHERE ElapsedTimeInDays > ' +daysLimit;
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<ProcessInstanceWorkItem> faza = (List<ProcessInstanceWorkItem>)scope;
        List<Id> ids = new List<Id>();
        List<String> mailToAddressList = new List<String>();

        //TODO Fix the query so it can find object's approver correctly
        for(ProcessInstanceWorkitem zxc : faza){
            ids.add(zxc.ActorId);
            List<GroupMember> groupMembers = [SELECT UserOrGroupId FROM GroupMember WHERE GroupId = :zxc.ActorId];
            Set<Id> groupMbIds = new Set<Id>();
            for (GroupMember g : groupMembers) {
                groupMbIds.add(g.Id);
            }
            List<User> users = [SELECT Email FROM User WHERE Id IN :groupMbIds];
            for(User u : users){
                mailToAddressList.add(u.email);
            }
        }

        if(mailToAddressList.isEmpty()) return;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(mailToAddressList);
        mail.setCcAddresses(mailToAddressList);
        mail.setReplyTo('p.kucia@polource.com');
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Object In Approval Process For Too Long');
        mail.setPlainTextBody('You have object pending in approval process for too long');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

    global void finish(Database.BatchableContext bc) {}
}