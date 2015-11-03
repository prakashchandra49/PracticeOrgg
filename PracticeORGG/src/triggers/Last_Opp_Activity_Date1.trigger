trigger Last_Opp_Activity_Date1 on Opportunity (after delete, after update, after insert) {
     Set<ID> AccountID=new Set<ID>();
        List<account> accountToBeUpdated=new List<account>();
      if(Trigger.isInsert||trigger.isUpdate){  
        for(Opportunity opp:Trigger.new){
                AccountID.add(opp.accountid);
        }
      }
    if(trigger.isdelete){
        for(Opportunity opp:Trigger.old){
                AccountID.add(opp.accountid);
        }
       }
        Map<Id,Account> accounts=new Map<Id,Account>([select id,Last_Opp_Activity_Date__c   from account where id in :accountId]);
        AggregateResult[] aggregateResult=[select o.AccountId,max(LastModifiedDate)max from Opportunity o group by o.accountid having AccountId in :accountId];
        for(AggregateResult ag:aggregateResult)
        {
                        system.debug('####################### account id'+ accounts.get(((Id)ag.get('AccountId')))+'#################### corrensponding man value'+ag.get('max'));
                        accounts.get(((Id)ag.get('AccountId'))).Last_Opp_Activity_Date__c=(DateTime)ag.get('max');
                        accountToBeUpdated.add( accounts.get(((Id)ag.get('AccountId'))));
                        
        }
                update accountToBeUpdated;   
}