trigger OppActivityDate on Opportunity (before Update) {
    for(Opportunity opp:Trigger.new){
        if(isStageChange(opp)){
            if(opp.StageName=='Closed Won'||opp.StageName=='Closed Lost'){
                opp.CloseDate=Date.today();
            }
        }
    }
        
public Boolean isStageChange(Opportunity opp){
    if(opp.StageName!=Trigger.oldMap.get(opp.id).StageName){
            return true;
        }
        else{
            return false;
        }
  }
}