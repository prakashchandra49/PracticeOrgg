/*
Question 4 :- When insert/update any student’s in class then  update MyCount Accordingly.
**/
trigger StudentMyCount_4 on Student__c (after insert,after delete,after undelete) {
 List<class__c> classToBeUpdated=new List<class__c>();
 if(trigger.isinsert){
   List<Student__c> students=trigger.new;
   List<class__c> classes=[select c.id ,c.MyCount__c,c.NoOfStudent__c  from class__c c];
      for(class__c cls:classes){
       for(Student__c student:students){
        if(student.classSt__c==cls.id){
        cls.MyCount__c= cls.NoOfStudent__c+1;
                }
        
            }
             classToBeUpdated.add(cls);
        }
    }
   if(trigger.isdelete){
   List<Student__c> students=trigger.old;
   List<class__c> classes=[select c.id ,c.MyCount__c,c.NoOfStudent__c  from class__c c];
   for(class__c cls:classes){
       for(Student__c student:students){
        if(student.classSt__c==cls.id){
        cls.MyCount__c= cls.NoOfStudent__c-1;
                }
        
            }
             classToBeUpdated.add(cls);
        }
      

  }
  
   if(trigger.isundelete){
   List<Student__c> students=trigger.new;
   List<class__c> classes=[select c.id ,c.MyCount__c,c.NoOfStudent__c  from class__c c];
   for(class__c cls:classes){
       for(Student__c student:students){
        if(student.classSt__c==cls.id){
        cls.MyCount__c= cls.NoOfStudent__c+1;
                }
        
            }
             classToBeUpdated.add(cls);
        }
     }
  update classToBeUpdated;
}