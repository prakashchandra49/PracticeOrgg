public with sharing class OpportunityAmountClass {
    public List<AggregateResult> oppList = new List<AggregateResult>();
    oppWrapper opp ;
    List<oppWrapper> oppWrapperList = new List<oppWrapper>();
    
    public OpportunityAmountClass(ApexPages.StandardController controller) {
        oppList = [Select AccountId, SUM(Amount)avr From Opportunity GROUP BY AccountId];
       
        for(AggregateResult ar : oppList){
            opp = new oppWrapper();
            opp.id = (ID)ar.get('AccountId');
            opp.Amount = (Decimal)ar.get('avr');    //opp.Amount = (Decimal)ar.get('expr0'); 
            oppWrapperList.add(opp);        
        }
    }
    
    public List<oppWrapper> getOppValues(){
        return oppWrapperList;
    }
    public class oppWrapper{
        public ID id{get; set;}
        public Decimal Amount{get; set;}
    }

}