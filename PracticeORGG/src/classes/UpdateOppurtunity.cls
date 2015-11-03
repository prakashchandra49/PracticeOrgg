/*
Question 8 :- Create 2 new Fields of type Lookup in Opportunity named 
        ( BillToContact(Contact) and Manager(Account). 
        Create a function in Class which take List<Oppty> as argument and in function check BillToContact Field if it 
        is not Blank and Manager is Blank then populate Manager Field by related account.
**/
public with sharing class UpdateOppurtunity {

public static void updateField(List<Opportunity> oppList){
System.debug('*****************oppList List Size = ' + oppList.size());
Map<Opportunity,Contact> accountMap = new Map<Opportunity,Contact>();
for(Opportunity opp : oppList){
if(opp.BillToContact__c!=null){
Contact contact = [select c.Account.Id from Contact c where c.Id = :opp.BillToContact__c];
accountMap.put(opp , contact);
}
}

System.debug('******************* accountMap MapSize = ' + accountMap.size());
Set<Opportunity> keySet = accountMap.keySet();
List<Opportunity> opportunityToBeUpdate = new List<Opportunity>();

for(Opportunity opp : keySet){
if(opp.BillToContact__c!=null && opp.Manager__c == null){
opp.Manager__c = accountMap.get(opp).Account.Id;
opportunityToBeUpdate.add(opp);

}
}
System.debug('******************* oopUpdateSize= ' + opportunityToBeUpdate .size());
update opportunityToBeUpdate;
}

}