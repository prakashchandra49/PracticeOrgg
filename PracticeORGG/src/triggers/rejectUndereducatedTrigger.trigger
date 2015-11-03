trigger rejectUndereducatedTrigger on Job_ApplicationS__c (before insert, before update) {
   
   //fetch all ID of the records that are going to update
 
   for(Job_ApplicationS__c JA : trigger.new){
     PositionS__c postion = [select reject_undereducated__c from PositionS__c where ID = :JA.PositionS__c ];         
     
     if(postion.reject_undereducated__c && JA.candidate_qualified__c == 'Not qualified' ){
       JA.addError('You are not allowed to apply without proper educational requirements.');
     } 
   }
}