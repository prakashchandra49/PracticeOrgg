/*
Question 2 :-  Create a function which returns a map where key is class 
and value is set of studentid in it.
**/
public with sharing class classAndStudents_2{
    public  Map<Id,List<Student__c>> getClassAndStudents(){
        Map<Id,List<Student__c>> studentWithClass= new Map<ID,List<Student__c>>(); 
        List<Class__c> cls=[select ID from Class__c];
        for(Class__c c:cls){
        List<Student__c> std=[select name from student__c where classSt__r.ID=:c.id];
        studentWithClass.put(c.ID,std);
        }
        return studentWithClass;
    }
}