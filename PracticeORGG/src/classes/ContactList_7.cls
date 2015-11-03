/*
Question 7 :-  Create a class and a static function which take ContactID as 
        argument. Create one Custom field in Account Object(ContactIDs), 
        it is comma separated of all related Contact IDs, check if it is Null or not:-
        IF Null, then fetch all related Account Contacts and store IDs of all Contacts in it.
        IF Not Null, then check Is Contact Id exist on this field, if not then append it on that field.
**/
public with sharing class ContactList_7 {

    public void updateContactList(String contactID)
    {
        Contact cont=[Select c.Name,c.Account.Id from Contact c where c.Id=:contactID];
        Account acc=[Select a.Contact_IDs__c From Account a where a.Id=:cont.Account.Id];
        if(acc.Contact_IDs__c==null) {
            List<Contact> contacts=[Select c.Id,c.Name,c.Account.Id From Contact c where c.Account.Id=:acc.Id];
            for(Contact contact:contacts)
            {
                if(acc.Contact_IDs__c==null)
                    acc.Contact_IDs__c = contact.Id;
                else
                    acc.Contact_IDs__c = acc.Contact_IDs__c + ',' + contact.Id;
                    
                update acc; 
            }
            
        } else {    
            if(!acc.Contact_IDs__c.contains(contactID))
                acc.Contact_IDs__c = acc.Contact_IDs__c + ',' + contactID;
            update acc;
        }   
    }   
}