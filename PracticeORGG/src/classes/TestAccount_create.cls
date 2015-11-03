@isTest
public with sharing class TestAccount_create {
	
	static testMethod void contactTest(){
	List<Contact> contactToBeCreated=new List<Contact>();
	Account acc=new Account(name='prakash',EmailAddress__c='abcde@gmail.com',IsExist__c=false);
	insert acc;
	Contact con1=new Contact(firstname='harish',lastname='kumar', Email='abcde@gmail.com');
	Contact con2=new Contact(firstname='gaurav',lastname='kumar',Email='abcdef@gmail.com');
	contactToBeCreated.add(con1);
	contactToBeCreated.add(con2);
	insert contactToBeCreated;

	Account newAcc=[select name,IsExist__c,EmailAddress__c from account where EmailAddress__c='abcde@gmail.com'];
	system.assertEquals(newAcc.IsExist__c,true);
	newAcc=[select name,EmailAddress__c from account where name='abcdef@gmail.com'];
	system.assertEquals(newAcc.name,'abcdef@gmail.com');
	}
	
}