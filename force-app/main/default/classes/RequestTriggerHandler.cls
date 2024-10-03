/**
 * Created by Piotr Kucia on 16.07.2018.
 */

public with sharing class RequestTriggerHandler extends TriggerHandler {

    public override void afterInsert() {
        for (Request__c newRequest : (List<Request__c>)Trigger.new) {
            if(newRequest.Status__c == 'New'){
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                req1.setComments('Submitting request for approval.');
                req1.setObjectId(newRequest.Id);
                Approval.ProcessResult result = Approval.process(req1);
            }
        }
    }

    public override void beforeInsert() {
        User user;
        Id userId;
        UserRole userRole;
        String role;
        Decimal value;

        for (Request__c newRequest : (List<Request__c>)Trigger.new) {
            //getting info of user submitting request
            user = newRequest.CreatedBy;
            userId = user.Id;
            userRole = user.UserRole;
            role = userRole.Name;
            value = newRequest.Value__c;
        }
        //getting info of other requests submitted by this user
        List<Request__c> requestList = [SELECT Name, Value__c FROM Request__c WHERE LastModifiedById= :userId AND Status__c= 'Accepted'];

        //checking limits for user role in custom metadata
        List<Company_Budget_Per_Role__mdt> budgetPerRoleList = [SELECT Budget__c, Role_Name__c FROM Company_Budget_Per_Role__mdt];

        for (Request__c newRequest : (List<Request__c>)Trigger.new) {
            for (Company_Budget_Per_Role__mdt budgetPerRoleMetadata : budgetPerRoleList) {
                if (budgetPerRoleMetadata.Role_Name__c == role) {
                    if (budgetPerRoleMetadata.Budget__c < value) {
                        //if budget limit in metadata is smaller than request value then error is thrown
                        newRequest.addError('Users budget limit is smaller than request value!');
                    }
                }
            }
        }
    }

    //works same as beforeInsert() but finds the user who last modified a request
    public override void beforeUpdate() {
        User user;
        Id userId;
        UserRole userRole;
        String role;
        Decimal value;

        for (Request__c newRequest : (List<Request__c>)Trigger.new) {
            //getting info of user submitting request
            user = newRequest.LastModifiedBy;
            userId = user.Id;
            userRole = user.UserRole;
            role = userRole.Name;
            value = newRequest.Value__c;
        }
        //getting info of other requests submitted by this user
        List<Request__c> requestList = [SELECT Name, Value__c FROM Request__c WHERE LastModifiedById= :userId AND Status__c= 'Accepted'];

        //checking limits for user role in custom metadata
        List<Company_Budget_Per_Role__mdt> budgetPerRoleList = [SELECT Budget__c, Role_Name__c FROM Company_Budget_Per_Role__mdt];

        for (Request__c newRequest : (List<Request__c>)Trigger.new) {
            for (Company_Budget_Per_Role__mdt budgetPerRoleMetadata : budgetPerRoleList) {
                if (budgetPerRoleMetadata.Role_Name__c == role) {
                    if (budgetPerRoleMetadata.Budget__c < value) {
                        //if budget limit in metadata is smaller than request value then error is thrown
                        newRequest.addError('Users budget limit is smaller than request value!');
                    }
                }
            }
        }
    }


}