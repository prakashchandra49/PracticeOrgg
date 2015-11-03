trigger CityPopulate on Loan__c (before insert) {
    List<Loan__c> listOfLoan=new  List<Loan__c>();
    Set<String> SetCity=new Set<String>();  
    Map<String,String> mapCM=new  Map<String,String>();
    for(Loan__c l:trigger.new){
           listOfLoan.add(l);
           SetCity.add(l.city__c);
    }
    List<CityManager__c> llMan=new List<CityManager__c>([Select c.City__c, c.Id, c.Manager__c from CityManager__c c where city__c in: SetCity]);
    for(CityManager__c mgr:llMan){
        mapCM.put(mgr.city__c,mgr.Manager__c);
    }
    for(Loan__c ll:listOfLoan){
        ll.Manager__c=mapCM.get(ll.city__c);
        }
   }