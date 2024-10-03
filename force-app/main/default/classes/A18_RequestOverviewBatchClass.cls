/**
 * Created by Piotr Kucia on 17.07.2018.
 */

global class A18_RequestOverviewBatchClass implements Database.Batchable<sObject> {
    String query;

    public A18_RequestOverviewBatchClass() {
        this.query = 'SELECT Name, Status__c, Value__c FROM Request__c WHERE CreatedDate > LAST_WEEK';
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Request__c> requestList = (List<Request__c>)scope;
        Integer approvedRequests = 0;
        Integer rejectedRequests = 0;
        Integer pendingRequests = 0;
        Decimal totalRequestValue = 0;

        for(Request__c request : requestList) {
            if(request.Status__c == 'Approved') approvedRequests++;
            else if(request.Status__c == 'Rejected') rejectedRequests++;
            else pendingRequests++;
            totalRequestValue += request.Value__c;
        }

        List<String> mailToAddressList = new List<String>();
        List<User> users = [SELECT Email FROM User WHERE Id IN (
                SELECT UserOrGroupId FROM GroupMember WHERE Group.DeveloperName = 'Fixed_asset_coordinators'
        )];

        for(User u : users) mailToAddressList.add(u.email);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(mailToAddressList);
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Request Overview');
        mail.setPlainTextBody('Request Overview for Last Week: \n'
                                + 'Total Requests: ' +requestList.size() +'\n'
                                + 'Requests Approved: ' +approvedRequests +'\n'
                                + 'Requests Rejected: ' +rejectedRequests +'\n'
                                + 'Requests Pending: ' +pendingRequests +'\n'
                                + 'Total Value of Requests: ' +totalRequestValue +'$');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

    global void finish(Database.BatchableContext bc) {}
}