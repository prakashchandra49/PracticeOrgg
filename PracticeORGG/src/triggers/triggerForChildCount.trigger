trigger triggerForChildCount on Account (after delete, after insert, after update,after undelete) {
List<Account> accountListToUpdate = new List<Account>();
List<Account> parentAccount = new List<Account>();
Set<Id> parentIds = new Set<Id>();
 
if(Trigger.isinsert||Trigger.isupdate||Trigger.isUnDelete){
    for(Account acc:Trigger.new){
          if((Trigger.isupdate && acc.ParentId!= Trigger.oldMap.get(acc.Id ).ParentId)||Trigger.isinsert||Trigger.isUnDelete){
             parentIds.add(acc.ParentId);
           }
         if((Trigger.isupdate && acc.ParentId!= Trigger.oldMap.get(acc.Id ).ParentId)){
             parentIds.add( Trigger.oldMap.get(acc.Id ).ParentId);
        }
    }
}
 
if(Trigger.isDelete){
   for( Account acc : Trigger.old){
     parentIds.add( acc.ParentId );
   }
 }
 
 parentAccount = [Select a.id, a.ChildCount__c from Account a where id in : parentIds];
 AggregateResult[] accountAggResult = [Select ParentId, Count(id)chidCount from Account GROUP BY ParentId];
 
 for( AggregateResult res : accountAggResult ){
   for( Account pAcc : parentAccount ){
     if( pAcc.Id == res.get('ParentId') ){
       pAcc.ChildCount__c = (Integer) res.get('chidCount');
       accountListToUpdate.add( pAcc );
     }
   }
 }
 
 update accountListToUpdate;
}