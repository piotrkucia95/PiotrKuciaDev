/**
 * Created by Piotr Kucia on 16.07.2018.
 */
//example trigger handler
public with sharing class ContactTriggerHandler {

    public void beforeInsert(List<Contact> newContacts){
        Map<Contact, Account> contactsWithAccounts = new Map<Contact, Account>();

        for (Contact newContact : newContacts) {
            Account acc = new Account(
                    Name = newContact.FirstName + ' ' + newContact.LastName
            );
            contactsWithAccounts.put(newContact, acc);
        }
        insert contactsWithAccounts.values();
        for (Contact newContact : contactsWithAccounts.keySet()) {
            Account acc = contactsWithAccounts.get(newContact);
            newContact.AccountId = acc.Id;
        }
    }

    public void beforeUpdate(List<Contact> newContacts, Map<Id, Contact> oldContacts) {
        Map<Id, Contact> accountIdToContact = new Map<Id, Contact>();
        for (Contact newContact : newContacts) {
            Contact oldContact = oldContacts.get(newContact.Id);
            if (newContact.FirstName != oldContact.FirstName || newContact.LastName != oldContact.LastName) {
                accountIdToContact.put(newContact.AccountId, newContact);
            }
        }

        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id = :accountIdToContact.keySet()];
        for(Account acc : accounts){
            Contact newContact = accountIdToContact.get(acc.Id);
            acc.Name = newContact.FirstName + ' ' + newContact.LastName;
        }

        update accounts;
    }

    public void afterDelete(List<Contact> oldContacts) {
        Set<Id> accountIds = new Set<Id>();
        for(Contact oldContact : oldContacts){
            accountIds.add(oldContact.AccountId);
        }
        delete [SELECT Id FROM Account WHERE Id = :accountIds];
    }
}