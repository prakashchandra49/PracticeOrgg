/*
Question 7 :-  Create a class and a static function which take ContactID as 
        argument. Create one Custom field in Account Object(ContactIDs), 
        it is comma separated of all related Contact IDs, check if it is Null or not:-
        IF Null, then fetch all related Account Contacts and store IDs of all Contacts in it.
        IF Not Null, then check Is Contact Id exist on this field, if not then append it on that field.
**/
public with sharing class ContactList_7_second {

    public void updateContactList(String contactID)
    {
        Contact cont=[Select c.Name,c.Account.Id from Contact c where c.Id=:contactID];
        List<Account> AccAndContact=[select a.id,Contact_IDs__c,(select id from account.contacts) from account a where  a.Id=:cont.Account.Id];
        List<Account> AccountToBeUpdated=new List<Account>();
        System.debug(AccAndContact.get(0).contacts.get(0).id);
        for(Account acc:AccAndContact){
            for(Contact con:acc.contacts){
               if(acc.Contact_IDs__c==null){
                   acc.Contact_IDs__c = con.Id;
                   }
                    else
                    { if(!acc.Contact_IDs__c.contains(con.Id))
                          acc.Contact_IDs__c = acc.Contact_IDs__c + ',' +  con.Id;
             
                    
                        }
                     }
                 AccountToBeUpdated.add(acc); 
             }
               update AccountToBeUpdated; 
        }
     
    }