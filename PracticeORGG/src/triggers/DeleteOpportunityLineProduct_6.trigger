/*
Question 6 :- Create a new PickList  “Custom Status” in Opportunity object.(New,Open,Close,Reset) values. When this field changed and value is “Reset” 
                     now then delete all associated  products(opp. Lines) with related Opportunity.
**/
trigger DeleteOpportunityLineProduct_6 on Opportunity (after update) {
     List<Opportunity> opportunity=Trigger.new;
     List<OpportunityLineItem> items=[select id,OpportunityId from OpportunityLineItem];
     List<OpportunityLineItem> itemsToBeDeleted=new List<OpportunityLineItem>();
           for(OpportunityLineItem item:items){
               for(Opportunity opp:opportunity){
                   if(item.OpportunityId==opp.id){
                    if(opp.Custom_Status__c=='Reset'&&opp.Custom_Status__c!=Trigger.oldMap.get(opp.id).Custom_Status__c){
                        itemsToBeDeleted.add(item);
                       }
                   }
           }
         delete itemsToBeDeleted;
    }
}