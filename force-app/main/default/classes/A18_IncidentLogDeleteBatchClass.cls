/**
 * Created by Piotr Kucia on 17.07.2018.
 */

global class A18_IncidentLogDeleteBatchClass implements Database.Batchable<sObject> {
    String query;

    public A18_IncidentLogDeleteBatchClass() {
        this.query = 'SELECT Name, CreatedDate FROM Incident_Log__c';
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Incident_Log__c> logList = (List<Incident_Log__c>)scope;
        List<Incident_Log__c> logsToDelete = new List<Incident_Log__c>();
        Log_Settings__c logSettings = Log_Settings__c.getInstance();
        Integer daysLimit = (Integer)logSettings.Delete_Older_Than__c;

        for(Incident_Log__c log : logList) {
            DateTime dt = log.CreatedDate;
            Date createdDate = Date.newInstance(dT.year(), dT.month(), dT.day());
            //if log was created more days ago than the limit says it's added to list of logs to delete
            if(createdDate.daysBetween(Date.today()) > daysLimit) {
                logsToDelete.add(log);
            }
        }

        delete logsToDelete;
    }

    global void finish(Database.BatchableContext bc) {}
}