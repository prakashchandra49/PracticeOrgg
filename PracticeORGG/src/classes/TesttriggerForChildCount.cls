@isTest
public with sharing class TesttriggerForChildCount {
		static testMethod void myTest(){
			List<Account> childAccToBeInserted=new List<Account>();
			List<Account> childAccToBeUpdated=new List<Account>();
			List<Account> childAccToBeInsertedRetrive=new List<Account>();
			Account parentAcc1=new Account();
			parentAcc1.name='prakash';
			parentAcc1.childCount__c=0;
			insert parentAcc1;
			

	for(Integer i=0;i<100;i++){
		Account acc=new Account(name='Test'+i);
		acc.ParentId=parentAcc1.id;
		childAccToBeInserted.add(acc);
	}
	insert childAccToBeInserted;

			
			
			Account acc = [select id,childCount__c from Account where id=:parentAcc1.id];
			
		
		//verify the child Count for the parent account after insert
		  system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+acc.childCount__c);
			system.assertEquals(acc.childCount__c,100);
			
			
			Account parentAcc2=new Account();
			parentAcc2.name='arun';
			parentAcc2.childCount__c=0;
			insert parentAcc2;
			
		  for(Account accc:childAccToBeInserted){
		  //	acc = [select id,childCount__c from Account where id=:accc.id];
		  	accc.ParentId=parentAcc2.id;
		  	childAccToBeUpdated.add(accc);
		  	}
			update childAccToBeUpdated;
			update parentAcc1 ;
			
			//verify the child Count for the parent account after update
		  acc = [select id,childCount__c from Account where id=:parentAcc2.id];
			system.assertEquals(acc.childCount__c,100);
		  acc = [select id,childCount__c from Account where id=:parentAcc1.id];
			system.assertEquals(acc.childCount__c,0);
			
			delete childAccToBeUpdated;
			update parentAcc2 ;
			//verify the child Count for the parent account after deletion
			acc = [select id,childCount__c from Account where id=:parentAcc2.id];
			system.assertEquals(acc.childCount__c,0);
			
	//		undelete childAccToBeUpdated;
	//		update parentAcc2 ;
			
			//verify the child Count for the parent account after undeletion
	//		acc = [select id,childCount__c from Account where id=:parentAcc2.id];
	//		system.assertEquals(acc.childCount__c,100);
			
			
		}
}