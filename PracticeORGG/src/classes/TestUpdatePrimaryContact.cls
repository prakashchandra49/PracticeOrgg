@isTest
public with sharing class TestUpdatePrimaryContact {

  static testMethod void runPositiveTestCases1(){
    Account account=new Account(name='prakash');
    insert account;
    Contact contact=new Contact(LastName='gaurav2',AccountId=account.id);
    insert contact;
    contact.Isprimary__c=true;
    update  contact;
    Account accc=[select primaryContact__c from account where id=:account.id];
    system.assertEquals(contact.id, accc.primaryContact__c);
  }
  
  static testMethod void runPositiveTestCases2(){
    Account account=new Account(name='prakash');
    insert account;
    Contact contact1=new Contact(LastName='gaurav2',AccountId=account.id,Isprimary__c=true);
    insert contact1;
    Contact contact2=new Contact(LastName='gaurav3',AccountId=account.id,Isprimary__c=false);
    insert contact2;
    contact2.Isprimary__c=true;
    update contact2;
  
    Account accc=[select primaryContact__c from account where id=:account.id];
    system.assertEquals(contact2.id, accc.primaryContact__c);
    Contact con=[select isPrimary__c from Contact where id=:contact1.id];
    system.assertEquals(false, con.isPrimary__c);
  }
  
  static testMethod void runPositiveTestCases3(){
  	 Account account=new Account(name='prakash');
     insert account;
     Contact contact=new Contact(LastName='gaurav2',AccountId=account.id,Isprimary__c=true);
     insert contact;
     contact.Isprimary__c=false;
     update  contact;
     Account accc=[select primaryContact__c from account where id=:account.id];
     system.assertEquals(null, accc.primaryContact__c);
  }
}