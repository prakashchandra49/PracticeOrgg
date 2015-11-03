/*
Question 1 :- Create a class and a static function which take classid as argument
and returns all names of the students in that class as a list.
**/
public with sharing class studentBasedOnClassID_1{
    public static List<Student__c> studentBasedOnClassId(ID id){
        List<Student__c> std=[select name from student__c where classSt__r.ID=:id]; 
        return std;
    }
}