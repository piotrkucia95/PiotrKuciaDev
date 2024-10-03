/**
 * Created by Piotr Kucia on 16.07.2018.
 */
//example trigger handler test
@IsTest
private class ContactTriggerHandlerTest {
    public static testMethod void shouldCreateAccountForContact() {
        //Prepare test data
        Contact c = new Contact(
                FirstName = 'FirstName',
                LastName = 'LastName'
        );

        Trigger_Switch__c triggerSwitch = new Trigger_Switch__c(
            ContactTrigger__c = true
        );
        insert triggerSwitch;

        //Perform test
        //Test.startTest();
        insert c;
        //Test.stopTest();

        //Verify
        c = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE Id = :c.Id];
        System.assertNotEquals(NULL, c.AccountId, 'Account ID shouldnt be null');
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :c.AccountId];
        System.assertEquals(acc.Name, c.FirstName + ' ' + c.LastName, 'Name should be the same');
    }
}