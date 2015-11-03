public with sharing class ContactListForAccount {
    List<Account> acc;
    public void updateContactList()
    {
       
        acc=[Select a.Id, a.NoOfContact__c from Account a];
        
     }       
}