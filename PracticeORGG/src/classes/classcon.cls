/*Question 8 :- Create VF Page Manage Class , On this Page show list of available classes with Edit and Del Link. When will user click on Edit a small
                Area displayed just below the same page with some fields (4-5 fields). User can save and return back to same Page. (You can use ajax 
                funcionality for same).  **/
public class classcon {
   public  class__c classes{get;set;}
   public boolean flag{get;set;}
   public ID id1 {get;set;}
   public classcon(ApexPages.StandardSetController controller) {
       flag=false;
    }
//This method will add the functionality to edit particular class
   public void editClass(){
       
      classes=[select id,name,MaxSize__c,Fees__c from class__c where id=:id1];
       flag=true;
   }
    public PageReference save(){
       update classes;
       PageReference acctPage = Page.Manageclass_8;
       acctPage.setRedirect(true);
       return acctPage;
   }
   
    public PageReference deleteClass(){
        classes=[select id,name,MaxSize__c,Fees__c from class__c where id=:id1];
       delete classes;
       PageReference acctPage = Page.Manageclass_8;
       acctPage.setRedirect(true);
       return acctPage;
   }
   public PageReference  cancel(){
       PageReference acctPage = Page.Manageclass_8;
       acctPage.setRedirect(true);
       return acctPage;
}
public PageReference  clear(){ 
      classes.name='';
      classes.MaxSize__c=null;
      classes.Fees__c=null;
      return null;
}
public PageReference  del(){
      classes=[select id,name,MaxSize__c,Fees__c from class__c where id=:id1];
      delete classes;
      PageReference acctPage = Page.Manageclass_8;
      acctPage.setRedirect(true);
      return acctPage;
}
public boolean getFlag(){
    return flag;
    }
     
}