public with sharing class myOppCon {
    public List<Opportunity> opp {get; private set;}
    public myOppCon(){
        opp=[select id,name from opportunity];
    }
    public  List<Opportunity> getOpp(){
        return (List<Opportunity>)opp;
    }
    
}