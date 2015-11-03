@isTest
public with sharing class Last_Opp_Activity_Test {
	    
			static testMethod void Last_Opp_Activity(){
				 Opportunity opp=new Opportunity();
				 Account acc=new Account(Name='Test Account');
				 insert acc;
				 List<Opportunity> oppToBeInserted=new  List<Opportunity>();
		//		 for(Integer i=0;i<200; i++){
				 	  Opportunity o = new Opportunity();
            o.AccountId = acc.id;
            o.Name = 'Test Opportunity';
            o.CloseDate = date.today();
            o.StageName = 'Qualified';
            o.Description = 'Test Opportunity Description';
        		oppToBeInserted.add(o);
			//	 }
				insert oppToBeInserted;
			System.debug('****************Testing Opportunity');	
				for(Opportunity opp1:oppToBeInserted){
					  System.assertEquals(acc.Last_Opp_Activity_Date__c,opp1.LastModifiedDate);
					 
				}
				delete oppToBeInserted;
			}
}