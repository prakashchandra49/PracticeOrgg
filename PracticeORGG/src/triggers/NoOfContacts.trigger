trigger NoOfContacts on Contact(after insert,after update,after delete) {
       
         Integer num=0;
         List<Account> accountToBeUpdated=new List<Account>();
         Set<ID> SetID=new Set<ID>();
         List<Account> accs=new List<Account>();
         
    if(trigger.isinsert){   
        for(Contact con:trigger.new){
              SetID.add(con.AccountId);
             }
          Map<Id,Account> accmap=new Map<Id,Account>([Select a.id,a.NoOfContact__c From Account a where a.id in :SetID]);    
   
              for(Contact cons:trigger.new){
             if(cons.AccountId==accmap.get(cons.AccountId).id){
    
               if(accmap.get(cons.AccountId).NoOfContact__c==null)
                   accmap.get(cons.AccountId).NoOfContact__c=1;
                   else
                    accmap.get(cons.AccountId).NoOfContact__c+=1;
                    accountToBeUpdated.add(accmap.get(cons.AccountId));  
            }
        }
  }
  
/*
  if(trigger.isdelete){   
  for(Contact con:trigger.old){
              SetID.add(con.AccountId);
             }
       
        Map<Id,Account> accmap=new Map<Id,Account>([Select a.id,a.NoOfContact__c From Account a where a.id in :SetID]);    
        for(Contact cons:trigger.old){
        if(cons.AccountId==accmap.get(cons.AccountId).id){
        accmap.get(cons.AccountId).NoOfContact__c-=1;
        accountToBeUpdated.add(accmap.get(cons.AccountId));  
            }
        }
      }
  
 
 if(trigger.isupdate){
      for(Contact con:trigger.new){
              SetID.add(con.AccountId);
             }
        
           Map<Id,Account> accmap=new Map<Id,Account>([Select a.id,a.NoOfContact__c From Account a where a.id in :SetID]);    
  
        for(Contact cons:trigger.new){
        if(cons.AccountId!=Trigger.oldMap.get(cons.Id).AccountId){
     
            if(cons.AccountId==accmap.get(cons.AccountId).id){
                accmap.get(cons.AccountId).NoOfContact__c+=1;
                accountToBeUpdated.add(accmap.get(cons.AccountId));  
                }
             }
        }
        SetID.clear();
        accmap.clear();
        for(Contact con:trigger.old){
              SetID.add(con.AccountId);
             }
        accmap=new Map<Id,Account>([Select a.id,a.NoOfContact__c From Account a where a.id in :SetID]);    
          for(Contact cons:trigger.old){
            if(Trigger.oldMap.get(cons.Id).AccountId==accmap.get(cons.AccountId).id){
              if(cons.AccountId==accmap.get(cons.AccountId).id){
                  accmap.get(cons.AccountId).NoOfContact__c-=1;
                  accountToBeUpdated.add(accmap.get(cons.AccountId)); 
                }
              }
           }
        }
  */
 update accountToBeUpdated;
}