/*
Question 3 :- Not allow insert student if class already reached MaxLimit.
**/
trigger StudentMaxLimit_3 on Student__c (before insert) {
    List<class__c> listOfClsasses=new List<class__c>();
    for(Student__c student:Trigger.new)
    listOfClsasses.add(new class__c(id=student.classSt__c));
    List<class__c> classes=[select c.id,c.NoOfStudent__c,c.MaxSize__c from class__c c where id in :listOfClsasses];
    for(class__c cls:classes){
       for(Student__c std:Trigger.new){
           if(std.classSt__c==cls.id){
               system.debug('*********** '+cls.NoOfStudent__c+ ' &&&&&&&&&& '+cls.MaxSize__c);
               if(cls.NoOfStudent__c==cls.MaxSize__c){
                   std.addError('Cant Add More Student Maximum Limit Reach');
                   }
               }
           }
          
       }
   
   }