/**
 * Created by Piotr Kucia on 16.07.2018.
 */
//example trigger handler
public with sharing class AccountTriggerHandler {

    private static Boolean bypassTrigger = false;

    public void afterInsert(List<Account> newAccounts) {
        if(!bypassTrigger) {
            List<Account> accountsToInsert = new List<Account>();

            for (Account newAccount : newAccounts) {
                Account cloneAccount = newAccount.clone(false, true, true, false);
                accountsToInsert.add(cloneAccount);
            }
            bypassTrigger = true;
            insert accountsToInsert;
            bypassTrigger = false;
        }
    }
}