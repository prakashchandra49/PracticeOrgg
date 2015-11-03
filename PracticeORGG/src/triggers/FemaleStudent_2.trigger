/*
Question 2 :- Not allow delete to class if there are more then one Female students
**/
trigger FemaleStudent_2 on Class__c (before delete) {
     Set<id> stID= new Set<id>();
    Integer count=0;
    Map<id,class__c> idAndClass=new Map<id,class__c>();
 //     for(class__c cls:trigger.old){
 //         idAndClass.put(cls.id,cls);
 //     }
    Map<id,student__c> student=new Map<id,student__c>([select id,firstname__c,sex__c,ClassSt__c from student__c where classSt__c in :trigger.old]);
    for(class__c cls:trigger.old){
    for(Student__c st:student.values()){
        if(st.Sex__c=='Female'&&st.ClassSt__c==cls.Id)
            count++;
    }
        if(count>1)
            cls.addError('Cant delete the class containing for than one single student');
    }
}