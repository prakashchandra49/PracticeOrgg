/*
Question 5 :- In Opportunity, If the stage is changed from another value  to CLOSED_WON or CLOSED_LOST, populates the Close Date field with Today().
**/
trigger Opprtunity_State_Change_5 on Opportunity (before update) {
    for(Opportunity opp:Trigger.new){
        if(opp.StageName=='Closed Won'||opp.StageName=='Closed Lost'){
            opp.CloseDate=Date.Today();
        }
    }
}