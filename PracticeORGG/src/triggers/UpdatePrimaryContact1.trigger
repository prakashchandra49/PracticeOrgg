trigger UpdatePrimaryContact1 on Contact (after update,before delete) {
  
  if(Trigger.Isupdate){  
    List<Account> accountToBeUpdated= new List<account>();
    Map<id,contact> updatemap = new  Map<id,contact>();
    Map<id,contact> accWithContact = new  Map<id,contact>();
    List<Contact> ContactToBeUpdated=new List<Contact>();
    for(Contact con: Trigger.new){
        updatemap.put(con.accountID, con);
       
    }
    List<Contact> lstContact=[Select c.id ,c.AccountId, c.IsPrimary__c from Contact c where c.IsPrimary__c=true];
    for(contact con:lstContact){
      accWithContact.put(con.accountID, con);
    }
    system.debug('@@@@@@@@@@@'+accWithContact);
     Map<id,account> updateacc = new  Map<id,account>([select a.PrimaryContact__c from account a where a.Id in: updatemap.Keyset()]);
     
     for(Contact contact:updatemap.Values()){
         if(contact.IsPrimary__c){
             Account acc = updateacc.get(contact.accountId);
             acc.PrimaryContact__c = contact.Id;
             accountToBeUpdated.add(acc);
             system.debug('@@@@@@@@@@@@@@@'+(accWithContact.get(contact.accountId)).id+'@@@@'+(updatemap.get(contact.accountId)).id);
             if((accWithContact.get(contact.accountId)).id!=(updateacc.get(contact.accountId)).id){
               accWithContact.get(contact.accountId).IsPrimary__c=false;
               update accWithContact.get(contact.accountId);
               system.debug('@@@@@@@@@@@@@@@@@@'+accWithContact.get(contact.accountId));
             }
         }
        else{
             Account acc = updateacc.get(contact.accountId);
             acc.PrimaryContact__c = null;
             accountToBeUpdated.add(acc);
        }
         
     }
    
     update accountToBeUpdated;
    
 }   
     if(Trigger.Isdelete) {
       for(Contact contact:Trigger.old){
         if(contact.IsPrimary__c){
           contact.addError('Primary Contact Cannot Be Deleted');
         }
       }
     }
 }