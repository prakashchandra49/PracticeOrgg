trigger UpdatePrimaryContact on Contact (after update,before delete) {
  
  if(Trigger.Isupdate ){
     List<Account> accountToBeUpdated= new List<account>();
     List<Contact> ContactToBeUpdated=new List<Contact>();
    Map<id,List<Contact>> accWithContact = new  Map<id, List<Contact>>(); 
    for(Contact contact:Trigger.New){
        if(accWithContact.containsKey(contact.AccountId))
            (accWithContact.get(contact.AccountId)).add(contact);
        else
        {
             List<Contact> lstContact=new List<Contact>(); 
             lstContact.add(contact);
             accWithContact.put(contact.AccountId,lstContact); 
        }      
    }
   System.debug('___________________'+UpdatePrimaryContact.isUpdatedAgain);
   if(!UpdatePrimaryContact.isUpdatedAgain){
   List<Contact> allContact =[Select c.AccountId, c.IsPrimary__c from Contact c where (AccountId in :accWithContact.keySet() and isPrimary__c=true)];
   Map<id,account> updateacc = new  Map<id,account>([select a.id,a.PrimaryContact__c from account a where a.Id in: accWithContact.Keyset()]);
   for(Contact contact:trigger.new){
     system.debug('@@@@@@@@@@@@@@'+allContact.size());
     
       if(allContact.size()==0){
       Account acc = updateacc.get(contact.accountId);
       acc.PrimaryContact__c = null;
       accountToBeUpdated.add(acc);
      
    }
     
   else  if(allContact.size()==1){
       Account acc = updateacc.get(contact.accountId);
       acc.PrimaryContact__c = contact.Id;
       accountToBeUpdated.add(acc);
      
    }
    else {
      
     
      
      for(Contact con:allContact){
      	for(contact cont :accWithContact.get(con.AccountId)){
        if(cont.id!=con.id){
          con.IsPrimary__c=false;
          Account acc = updateacc.get(contact.accountId);
          system.debug('@@@@@@@@@'+acc.id);
          acc.PrimaryContact__c = cont.id;
          accountToBeUpdated.add(acc); 
          ContactToBeUpdated.add(con);
          UpdatePrimaryContact.isUpdatedAgain=true;
         }
      	}
      }
    }  
     //if((accWithContact.get(con.AccountId)).get(0).id==){
       
     //}
    }
   }
  update accountToBeUpdated; 
  update ContactToBeUpdated;
  }    
  
  if(Trigger.Isdelete) {
       for(Contact contact:Trigger.old){
         if(contact.IsPrimary__c){
           Trigger.old[0].addError('Primary Contact Cannot Be Deleted');
         }
       }
     }
 }