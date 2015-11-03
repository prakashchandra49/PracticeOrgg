/*****************************************************************************
* Name : MassEmailContact
* Created By : Prakash Chandra 
* Created Date : 24 Jan, 2012.
* Purpose : Handles the Mass Email For Contact
*****************************************************************************/

public class MassEmailContactsController1{
  public String TemplateName { get; set; }//will store the name of the template
  public List<Contact> Contacts;         //will maintain the list of the contact
  public String accountName{get;set;}     //will store the name of the account that will be use for filtering purpose
  public String tmpId{get;set;}           //will store the Template ID
  private final String Data_Not_Available='Data Not Available For This View.';//will store the error message
  private final String Select_Any_Contact='Please Select Any Contact .';      //will store the error message

  public String massEmailName{get;set;} //will store the name for the mass email
  public List<EmailTemplate> EmailTemplates ;//maintain the list of EmailTemplate
  public Id SelectedTmp{get;set;}//will store the id of selected template
  public String isNow{get;set;} //will specify whether the email should be send now
  public Boolean isSaveAsActivity{get;set;}//will store the SaveAsActivity value
  public Boolean isUseSignature{get;set;}//will store the UseSignature value
  public Boolean isBCCme{get;set;}//will store the BCCmevalue
  public String scheduleDate{get;set;}//will store the date for the scheduling
  public Boolean selectAll{get;set;}

  public String selectedd{get;set;}
  public String ContactId{get;set;}
  public map<id,contact> selectedContacts=new map<id,contact>();
  public List<contact> contact;
  public Integer sizeOfMap{get;set;}
  public List<String> albhabet;
  public String character{get;set;}
  public List<String> getAlbhabet(){
   return Albhabet;
  }
public boolean nameSorting{get;set;}
public boolean titleSorting{get;set;}
public boolean phoneSorting{get;set;}
public boolean emailSorting{get;set;}
public String imageName{get;set;}

public String sortDirection{get;set;} 
public String sortingElement;  
public Integer selectedPage{get;set;}
  public PageReference showContactAlphabet(){
//  system.debug('+++++++++++++++++++++'+ConWithFlag);
  if(character=='ALL'){
  character='';
  }
  List<Contact> contacts=new List<Contact>();
  contacts=database.query('select Id,Name,Title,Phone,Email,Fax,Account.Name From Contact where Name like \''+character+'%\' Limit '+selectedPage);
 
  
  con = new ApexPages.StandardSetController(contacts);
  con.setPageSize(10);      
  return null;
}
    
 public void setsortingElement(String s){
   sortingElement=s;
   if(sortDirection== 'ASC'){
     sortDirection='DESC';
   }
   else 
     sortDirection= 'ASC';    
}
public String getsortingElement(){
   return sortingElement;
}

 public PageReference sortData(){
  if(sortingElement=='Name'){
    nameSorting=true;
    titleSorting=false;
    phoneSorting=false;
    emailSorting=false;
  }
  else if(sortingElement=='Title'){
    nameSorting=false;
    titleSorting=true;
    phoneSorting=false;
    emailSorting=false;
  }
  else if(sortingElement=='Phone'){
    nameSorting=false;
    titleSorting=false;
    phoneSorting=true;
    emailSorting=false;
  }
  else if(sortingElement=='Email'){
    nameSorting=false;
    titleSorting=false;
    phoneSorting=false;
    emailSorting=true;
  }
  
  system.debug('@@@@@@@@@@@sortingElement'+sortingElement);
  system.debug('@@@@@@@@@@@sortDirection'+sortDirection);
  List<Contact> contacts=database.query('Select Id,Name,Title,Phone,Email,Fax,Account.Name from contact order by '+sortingElement+' '+sortDirection);
  if(sortDirection=='ASC'){
     imageName='Arrow/arrow-down.jpg';
  }
  else{
    imageName='Arrow/arrow-up.jpg';
  }
  con = new ApexPages.StandardSetController(contacts);
  con.setPageSize(10);
  return null;
  } 
        

    // instantiate the StandardSetController from a query locator
    public ApexPages.StandardSetController con;
    
    
    public MassEmailContactsController1(){
     con=new ApexPages.StandardSetController(Database.getQueryLocator([Select Id,Name,Title,Phone,Email,Fax,Account.Name From Contact]));
     selectedPage=10;
      con.setPageSize(selectedPage);
       con.setPageSize(5);
     albhabet=new List<String>
{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','other','ALL'};
      contact=new List<Contact>();
    }
    public List<Contact> getContact(){
  
    if(con==null)
    {
       con=new ApexPages.StandardSetController(Database.getQueryLocator([Select Id,Name,Title,Phone,Email,Fax,Account.Name From Contact]));
     //  con.setPageSize(selectedPage);
       con.setPageSize(5);
       contact =(List<Contact>)con.getRecords();
     //  noOfdisplayedRecords=contact.size();
       return contact; 
    }
    else
    {
   // con.setPageSize(selectedPage);
    contact =(List<Contact>)con.getRecords();
    system.debug('@@@@@@@@@@@@contact '+contact );
   // noOfdisplayedRecords=contact.size();
    return contact; 
       
     }
    }
  
    
public void addToMap()
    {
    Integer c=0;
    Integer c1=0;
    for(ContactWrapper displayed:lstContactWrapper)
    {
    c++;
    if(!selectedContacts.containskey(displayed.cont.Id)){
    if(displayed.isSelected==true){
    c1++;
    selectedContacts.put(displayed.cont.Id,displayed.cont);
    }
    }
    else{
     if(displayed.isSelected==false){
    selectedContacts.remove(displayed.cont.Id);
    }
    else{
    c1++;
    }
      
    }
    }
    if(c==c1){
    selectAll=true;
    }
    else{
    selectAll=false;
    }
    sizeOfMap=selectedContacts.size();
    
    } 

public List<ContactWrapper>  lstContactWrapper ;
public List<ContactWrapper> getlstContactWrapper(){

lstContactWrapper=new List<ContactWrapper>();
system.debug('@@@@@@@@@@@@@@@@@getContact()'+getContact());
for(Contact c:getContact()){

if(c==selectedContacts.get(c.Id))
{
ContactWrapper co=new ContactWrapper(c,true);
lstContactWrapper.add(co);
}
else{
ContactWrapper co=new ContactWrapper(c,false);
lstContactWrapper.add(co);
 }
}
system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@lstContactWrapper'+lstContactWrapper);
//pageNumber=con.getPageNumber();
return lstContactWrapper;
}
 

                    
  
  
  
// indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
 
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
 
    // returns the first page of records
    public void first() {
        con.first();
    }
 
    // returns the last page of records
    public void last() {
        con.last();
    }
 
    // returns the previous page of records
    public void previous() {
       
        con.previous();
       
    }
 
    // returns the next page of records
    public void next() {
           
           
        con.next();
       
    }
  
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
  will query Contact from the database and will add it to List lstcontactWrapper 
*/ 

  
   
/**
  will maintain the contact and it's selected boolean value
*/
public class ContactWrapper
 {
   public Contact cont{get;set;}
   public Boolean isSelected{get;set;}
   
   public ContactWrapper(contact con,Boolean isSelectedd)
   {  
     cont=new Contact(); 
     cont=con;
     isSelected=isSelectedd;
   }
 }
 
 
}