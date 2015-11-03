/*****************************************************************************
* Name : MassEmailCOntact
* Created By : Prakash Chandra 
* Created Date : 24 Jan, 2012.
* Purpose : Handles the Mass Email For Contact
*****************************************************************************/

public class MassEmailContactsController{
  public String TemplateName { get; set; }//will store the name of the template
  public List<Contact> Contacts;         //will maintain the list of the contact
  public String accountName{get;set;}     //will store the name of the account that will be use for filtering purpose
  public String tmpId{get;set;}           //will store the Template ID
  private final String Data_Not_Available='Data Not Available For This View.';//will store the error message
  private final String Select_Any_Contact='Please Select Any Contact .';      //will store the error message
  public List<ContactWrapper> lstcontactWrapper =new List<ContactWrapper>() ;//will maintain the list of ContactWrapper's objects
  public String massEmailName{get;set;} //will store the name for the mass email
  public List<EmailTemplate> EmailTemplates ;//maintain the list of EmailTemplate
  public Id SelectedTmp{get;set;}//will store the id of selected template
  public String isNow{get;set;} //will specify whether the email should be send now
  public Boolean isSaveAsActivity{get;set;}//will store the SaveAsActivity value
  public Boolean isUseSignature{get;set;}//will store the UseSignature value
  public Boolean isBCCme{get;set;}//will store the BCCmevalue
  public String scheduleDate{get;set;}//will store the date for the scheduling
  public Boolean selectAll{get;set;}
  public Event ScheduleDateTime{get;set;}


 



/*
  will select all contacts
*/    
 public void checkAll()
   {
        for(ContactWrapper contactWrapper :lstcontactWrapper)
        {
            contactWrapper.isSelected=selectAll; 
        }
           
    }
   
  public void unCheck(){
     Boolean isAnycontctselectd=false;
     for(ContactWrapper contactWrapper :lstcontactWrapper)
        {
            if(contactWrapper.isSelected == false){
              selectAll=false; 
              isAnycontctselectd=true;
              }
        }
        if(!isAnycontctselectd)
          selectAll=true;
   }
   
/*
  will assign the selected template id into TmpId
*/  
  public void assignId()
   {
     TmpId=ApexPages.currentPage().getParameters().get('TmpId'); 
     system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ tmpId'+tmpId);    
   }
 
/*
  Will be used to call BatchApex and schedule class according to user selection
*/
  public PageReference SendMassEmail() {
   Set<id> ID=new Set<id>();
   String email='prakashchandraporivar@gmail.com';
   system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ EmailTemplates  lstcontactWrapper'+ lstcontactWrapper);
   system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ EmailTemplates Tmpid'+ TmpId);
   system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ isSaveAsActivity'+ isSaveAsActivity);
   system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ isNow'+ isNow);
   try
    { 
      for(ContactWrapper contactWrapper :lstcontactWrapper)
       {
         if(contactWrapper.isSelected==true &&contactWrapper.cont.Email!=null)
           ID.add(contactWrapper.cont.id);
       }
             system.debug('############################ ID'+ID);
           //  String query='Select id, Name, Phone, Fax,Email,Account.Name from Contact WHERE (IsDeleted = false) and id in :'+ID;
          //    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ query'+ query);
           //  Id batchInstanceId = Database.executeBatch(new MassEmailContacts_Batch(ID,TmpId,email));
         if(isNow=='isNow')
           {
             Database.executeBatch(new MassEmailContacts_Batch(ID,TmpId,email,isSaveAsActivity,isUseSignature,isBCCme));
             return Page.SuccessMassEmail;
           }
           else
             {  
               if(scheduleDate==null || scheduleDate=='')
                 {
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,Select_Any_Contact));
                 }
               else
                 {
                   String[] formattedDate=scheduleDate.split('/');
                   system.debug('@@@@@@@@@@@@@@@@@@@@@@ formattedDate.get(1)'+formattedDate[1]);
                   ScheduledMassEmailContacts_Batch m = new ScheduledMassEmailContacts_Batch(ID,TmpId,email,isSaveAsActivity,isUseSignature,isBCCme);
                   String schedulingDate='00'+' '+'00'+' '+'00'+' '+formattedDate.get(2)+' '+formattedDate.get(1)+' '+'?'+' '+formattedDate.get(0);
                   system.debug('@@@@@@@@@@@@@@@@@@@@@@ schedulingDate'+schedulingDate);
               //  String sch = '20 00 8 23 1 ?';
                   system.schedule(massEmailName, schedulingDate, m);
                   return Page.SuccessMassEmail;
                 }
             }   
        }
   catch(Exception ex)
     {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
     }
   return null;
    }

/*
  Will redirect to EmailTemplates page
*/
  public PageReference EmailTemplates() 
   {
     return Page.EmailTemplates;
   }

/*
   Will redirect to https://ap1.salesforce.com/003/o page
*/

 public PageReference Cancel() 
   {
    Schema.DescribeSObjectResult r = Contact.sObjectType.getDescribe();
    system.debug('##########################describeSObjectResult '+r.keyPrefix);
     
    PageReference mainPage=new PageReference('/'+r.keyPrefix+'/o'); 
     mainPage.setRedirect(true);
   return mainPage;
      // return null;
   }
/*
  Will return the list of EmailTemplate
*/   
 public List<EmailTemplate> getEmailTemplates()
   {
     return EmailTemplates ;
   }
/*
  Will check whether any contact selected and will redirect to EmailTemplates page 
*/     
 public PageReference SelectTeamplate() 
   {
     Boolean isAnyContactSelected=false;
     for(ContactWrapper contactWrapper :lstcontactWrapper)
       {
         if(contactWrapper.isSelected==true)
           isAnyContactSelected=true;
           
         
       }
        if(!isAnyContactSelected)
          {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,Select_Any_Contact));
             return null;
          }
        else
          {    
            EmailTemplates =[Select e.Description, e.Id, e.Name, e.TemplateType from EmailTemplate e];
            return Page.EmailTemplates;
          }
         
   }
 
/*
  will filter the template via it's name
*/   
 public PageReference FilterTemp() 
   {
     try
      {
        String TemplateName= '%' +this.TemplateName+ '%';
        if(EmailTemplates==null)
        EmailTemplates=new List<EmailTemplate>();
        EmailTemplates =[Select e.Description, e.Id, e.Name, e.TemplateType from EmailTemplate e where e.Name like :TemplateName];
        if (EmailTemplates .size()<= 0)
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,Data_Not_Available));
     }
   catch(Exception ex)
    {
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
    }
        return null;
 }
     
   public PageReference ScheduleMassEmail()
     {
       return Page.ScheduleMassEmail;
     } 
     
   public PageReference massEmailTmp() {
        return Page.MassEmailContacts;
    }  


/*
  will return the lstcontactWrapper 
*/ 
  public List<ContactWrapper> getlstcontactWrapper()
  {
    return lstcontactWrapper;
  }
 
/*
  will return the list of Contacts
*/ 
   
  public List<Contact> getContacts()
   {
    return Contacts;
   }

  public PageReference ViewData()
  {
   Contacts = null;
  BindData();
   return null;
  }
  
/*
  will query Contact from the database and will add it to List lstcontactWrapper 
*/ 

  public void BindData()
  {
   try
   {
    if (Contacts == null){
     lstcontactWrapper=new List<ContactWrapper>();
     String accountName = '%' + this.accountName + '%';
     Contacts = [Select id, Name, Phone, Fax,Email,Account.Name from Contact WHERE (IsDeleted = false and Account.Name like :accountName)];
 
    }

   
 for(contact con: Contacts)
 { 
    ContactWrapper contactWrapper=new ContactWrapper();
    contactWrapper.cont=con;
    contactWrapper.isSelected=false;
    lstcontactWrapper.add(contactWrapper); 
   }
  
  
  if (Contacts== null || Contacts.size()<= 0)
  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,Data_Not_Available));
  }
  catch(Exception ex)
  {
   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
  }
 }

/**
  will maintain the contact and it's selected boolean value
*/
public class ContactWrapper
 {
   public Contact cont{get;set;}
   public Boolean isSelected{get;set;}
   
 }
 
 
}