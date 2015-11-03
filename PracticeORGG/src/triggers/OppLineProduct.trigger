/*********************************************************************************************
		Created By : Prakash Chandra
		Purpose		 : Deleting the Opportunity Line Item When Opportunity's Custom Status Changed To Reset
		Pusedo		 : Iterating over Opportunity and checking which Opportunity's Custom Status Changed To Reset	
*********************************************************************************************/
trigger OppLineProduct on Opportunity (After Update) {
	Map<Id,Opportunity> mapOpportunity=new Map<Id,Opportunity>();
	List<OpportunityLineItem> lstOpprtunityLineItemToBeDeleted=new List<OpportunityLineItem>();
	for(Opportunity opp:Trigger.New){
		if(isStateChange(opp))
			mapOpportunity.put(opp.id,opp);
	}
	lstOpprtunityLineItemToBeDeleted=[Select o.Id, o.OpportunityId from OpportunityLineItem o where OpportunityId in:mapOpportunity.keySet()];
//*********************************************************************************************
//	Indicating Whether the custom status change or set to reset	
//*********************************************************************************************	
	public Boolean isStateChange(Opportunity opp){
	if((opp.Custom_Status__c!=Trigger.oldMap.get(opp.id).Custom_Status__c)&&opp.Custom_Status__c=='Reset')
		return true;
		else
		return false;
	}	
	delete lstOpprtunityLineItemToBeDeleted;
}