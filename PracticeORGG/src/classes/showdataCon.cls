public with sharing class showdataCon {
     public ApexPages.StandardSetController setCon{get;set;}
      public List<Student__c> student;
      public Integer pageNum{get;set;}
      
      public String sortType{get;set;}   
    public showdataCon (){
       
       setCon=new  ApexPages.StandardSetController(Database.query('Select s.FirstName__c, s.LastName__c, s.WifeName__c,  s.Age__c, s.DOB__c  from Student__c s'));
       setCon.setPageSize(5);
        //pageNum='sadfsd';
    }  
   
    public void sortList(){
        setCon=new  ApexPages.StandardSetController(Database.query('Select s.FirstName__c, s.LastName__c, s.WifeName__c,  s.Age__c, s.DOB__c  from Student__c s order by '+sortType));
        setCon.setPageSize(5);
      }
   public List<Student__c> getstudent(){
       return (List<Student__c>)setCon.getRecords();
   }
   
      public Pagereference next(){
        setCon.next();
        return null;
    }
    
      public Pagereference first(){
        setCon.first();
        return null;
    }
        public Pagereference last(){
        setCon.last();
        return null;
    }
        public Pagereference previous(){
        setCon.previous();
        return null;
    }
        
        public Boolean hasNext{
        get{
            return setCon.getHasNext();
        }
        set;
        
    }

    public Boolean hasPrevious{
        get{
                return setCon.getHasPrevious();
        }       
        set;
        
    }
    
    public Integer pageNumber{
        get{
                return setCon.getPageNumber();
        }
        set {
                setCon.setPageNumber(1);
        }
    }
    
    public Integer pageSize{
        get {
                return setCon.getPageSize();
        }
        set {
                //setCon.setPageSize(1);
        }
    }
    
     public void go(){
         
        setCon.setpageNumber(pageNum);
    }
}