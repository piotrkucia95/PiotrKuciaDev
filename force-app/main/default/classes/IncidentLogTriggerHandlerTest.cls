/**
 * Created by Piotr Kucia on 16.07.18.
 */

@IsTest
private class IncidentLogTriggerHandlerTest {

    static testMethod void shouldSendEmail() {
        //Prepare test data
        Incident_Log__c log = new Incident_Log__c(
                Name = 'New Log',
                Message__c = 'FirstName',
                Stack_Trace__c = 'LastName'
        );

        Trigger_Switch__c triggerSwitch = new Trigger_Switch__c(
                IncidentLogTrigger__c = true
        );
        insert triggerSwitch;

        //Perform test
        Test.startTest();
        insert log;
        Test.stopTest();
    }
}