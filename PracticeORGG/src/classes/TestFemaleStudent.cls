@isTest
public with sharing class TestFemaleStudent{
        static testMethod void myTest(){
              Contact con=new Contact(LastName='prakash');
                class__c cls=new class__c(Name__c='I');
                insert cls;
                
                student__c st1=new student__c();
                st1.LastName__c='smith';
                st1.FirstName__c='will';
                st1.classSt__c=cls.id;
                st1.sex__c='Female';
                insert st1;
                
                student__c st2=new student__c();
                st2.LastName__c='kumar';
                st2.FirstName__c='narendra';
                 st2.sex__c='Female';
                st2.classSt__c=cls.id;
                insert st2;
                
                try{
                    delete cls;
                }
                catch(System.DMLException e){
                     system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@'+e.getMessage());
                     System.assert(e.getMessage().contains('Cant delete the class containing for than one single student'));
                }
                
        }
}