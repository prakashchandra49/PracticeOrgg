public with sharing class ConStudent {
      ApexPages.StandardSetController setCon;
      List<Student__c> student=new List<Student__c>();
      public ID selectedStudent{ get; set; }
      public List<SelectOption> Stduents;
      public List<student__c> SingleStudent{get; set;}
      public boolean flag { get; set; }
 public ConStudent() {
        setCon=new ApexPages.StandardSetController([Select s.Age__c, s.ClassSt__c, s.DOB__c, s.EmailID__c, s.FirstName__c, s.LastName__c, s.Sex__c from Student__c s]);
        Stduents=new List<SelectOption>();
        Stduents.add(new SelectOption('Select Student','--Select Student--'));
       flag=false;
    }

    public List<SelectOption> getStduents(){
     for(Student__c std:(List<Student__c>)setCon.getRecords()){
                 if(std.LastName__c!=null){
                 Stduents.add(new SelectOption(std.id,std.LastName__c));
             }
         }
         return Stduents;
    }
    
  
    public pageReference viewStudent(){
         flag=true;
         SingleStudent=[Select s.Age__c, s.ClassSt__c, s.DOB__c, s.EmailID__c, s.FirstName__c, s.LastName__c, s.Sex__c from Student__c s where id=:selectedStudent limit 1];
         
         system.debug('#########################'+flag);
         return null;
    }
}