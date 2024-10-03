/**
 * Created by Piotr Kucia on 16.07.2018.
 */
//example trigger handler test
@IsTest
private class AccountTriggerHandlerTest {
    public static testMethod void shouldCreateTwoSameAccounts() {
        //Prepare test data
        Account acc = new Account(
                Name = 'NewName'
        );
        Trigger_Switch__c triggerSwitch = new Trigger_Switch__c(
                AccountTrigger__c = true
        );
        insert triggerSwitch;

        //Perform test
        Test.startTest();
        insert acc;
        Test.stopTest();

        //Verify
        List<Account> accounts = [SELECT Name, Id FROM Account WHERE Name = :acc.Name];
        System.assertEquals(2, accounts.size(), 'There should be 2 accounts with same name');
    }
}