public class ConExtension 
{

public boolean nameSorting{get;set;}
public boolean titleSorting{get;set;}
public boolean phoneSorting{get;set;}
public boolean emailSorting{get;set;}
public CampaignMember cMember;

Set<Id> ids{get;set;}
String Para{get;set;}

public PageReference cancel(){
  PageReference page1=new PageReference('/apex/ContactPage');
  return page1;
}


public PageReference add(){
  String queryParam =ApexPages.CurrentPage().getParameters().get('ids');
  if(queryParam!=''){
    List<Id> idList = queryParam.split(',');
    List<Contact> SelContacts = [select Id,Name from contact where id in : idList];
    List<CampaignMember> campaignMembers=new List<CampaignMember>();

  for(Contact co:SelContacts){
    CampaignMember c=new CampaignMember();
    c.campaignId=cMember.CampaignId;
    c.ContactId=co.Id;
    
  campaignMembers.add(c);

    }
  insert campaignMembers;
  PageReference Page=new PageReference('/apex/SuccessPage?size='+campaignMembers.size()); 
  return Page;
  }
  else{
    return null;
 }
}

public List<selectOption> option;
    
public List<selectOption> getOption(){
  option=new List<selectOption>();
  Schema.DescribeFieldResult F = CampaignMember.Status.getDescribe();
  List<Schema.PicklistEntry> P = F.getPickListValues();
  for(Schema.PicklistEntry loopVar:P)
  {
    option.add(new SelectOption(loopVar.getLabel(),loopVar.getValue()));
  }
  return option;
       

}


public ConExtension(ApexPages.StandardController controller) {
  cMember=(CampaignMember)controller.getRecord();
  contact=new List<Contact>();
  sizeOfMap=0;
albhabet=new List<String>
{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','other','ALL'};
    con=new ApexPages.StandardSetController(Database.getQueryLocator([Select Id,Name,Title,Phone,Email From Contact]));
    selectedPage=10;
 }


 public Id EditId{get;set;}  
 
public pageReference AddToCampaign(){
 
  ids=selectedContacts.keySet();
  for(Id i:ids){
    if(Para==null){
      Para=i;
 }
 else{
   Para=Para+','+i;
   }
 }
system.debug('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh'+Para);
  PageReference page1=new PageReference('/apex/AddToCampaign?ids='+Para);
   page1.setRedirect(true);
  return page1;
 

 }
public pageReference AddContact(){
  PageReference page1=new PageReference('/apex/NewContact');
  page1.setRedirect(true);
  return page1;
}
public PageReference EditContact()
{
  PageReference page1=new PageReference('/apex/EditContactPage?id='+EditId);
  page1.setRedirect(true);
  return page1;
}

public Boolean selectAll{get;set;}
public class contactWithFlag{

  public Contact cont{get;set;}
  public Boolean flag{get;set;}
  public contactWithFlag(Contact c,Boolean b){
  cont=new Contact();
  cont=c;
  flag=b;
  }

}

public List<contactWithFlag> conWithFlag;

public List<contactWithFlag> getConWithFlag(){

  conWithFlag=new List<contactWithFlag>();
  for(Contact c:getContact()){
    if(c==selectedContacts.get(c.Id))
    {
      contactWithFlag co=new contactWithFlag(c,true);
      conWithFlag.add(co);
}
else{
  contactWithFlag co=new contactWithFlag(c,false);
  conWithFlag.add(co);
  }
}
  pageNumber=con.getPageNumber();  
  return conWithFlag;
}                                                                                                                                                                                        



public String selectedView{get;set;}
public List<SelectOption>views;

public void viewRecord(){

  if(selectedView=='AllContact'){
    contact=[select Id,Name,Title,Phone,Email,Birthdate from Contact];
  }
  else if(selectedView=='Birthday This Month'){
         Integer currentMonth=date.today().month();
         contact=[select Id,Name,Title,Phone,Email,Birthdate from Contact where CALENDAR_MONTH(Birthdate)=:currentMonth];
 
  }

else if(selectedView=='New Last Week'){
       contact=[select Id,Name,Title,Phone,Email,Birthdate from Contact WHERE CreatedDate = LAST_WEEK];
}
else if(selectedView=='New This Week'){
   contact=[select Id,Name,Title,Phone,Email,Birthdate from Contact WHERE CreatedDate = THIS_WEEK];
}

else if(selectedView=='Recently Viewed Contacts'){
   contact=[select Id,Name,Title,Phone,Email,LastModifiedDate from Contact order by LastModifiedDate asc];
}

    con = new ApexPages.StandardSetController(contact);
    con.setPageSize(10);
    selectedContacts.clear();
    selectAll=false;
     sizeOfMap=selectedContacts.size();
}

public List<SelectOption> getViews(){
views=new List<SelectOption>() ;
    views.add(new SelectOption('AllContact','AllContact'));
    views.add(new SelectOption('Birthday This Month','Birthday This Month'));
    views.add(new SelectOption('New Last Week','New Last Week'));
    views.add(new SelectOption('New This Week','New This Week'));
    views.add(new SelectOption('Recently Viewed Contacts','Recently Viewed Contacts'));
      
   
       return views;  
}
public List<Contact> contact;
public Integer noOfdisplayedRecords{get;set;}
public Id conId{get;set;}
public Integer sizeOfMap{get;set;}
public Map<Id,Contact> selectedContacts=new Map<Id,Contact>();
public String conId1{get;set;}
public void clearMap(){
   selectedContacts.clear();
   sizeOfMap=selectedContacts.size();
  }
  
public void addAllToMap(){
  for(contactWithFlag contact:conWithFlag){
    contact.flag=selectAll;
    }
    if(selectAll==true){
     for(Contact c:contact){
    selectedContacts.put(c.Id,c);
      }
    }
    else{
      for(contactWithFlag displayed:conWithFlag){
      selectedContacts.remove(displayed.cont.Id);
     }
   }
    
   
    sizeOfMap=selectedContacts.size();
    }
    
public void addToMap()
  {
   Integer c=0;
   Integer c1=0;
   for(contactWithFlag displayed:conWithFlag)
   {
     c++;
     if(!selectedContacts.containskey(displayed.cont.Id)){
       if(displayed.flag==true){
       c1++;
       selectedContacts.put(displayed.cont.Id,displayed.cont);
       }
    }
    else{
      if(displayed.flag==false){
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
    
    public Id delId{get;set;}
   
    public Integer selectedPage{get;
    set;
    }
    public List<SelectOption>noOfPage;

public List<SelectOption> getNoOfPage(){
  noOfPage=new List<SelectOption>() ;
  noOfPage.add(new SelectOption('10','10'));
  noOfPage.add(new SelectOption('2','2'));
  noOfPage.add(new SelectOption('25','25'));
  noOfPage.add(new SelectOption('50','50'));
  noOfPage.add(new SelectOption('100','100'));
  return noOfPage;  
}



public List<String> albhabet;
public integer pageNumber{get;set;}
   
public void goToPage(){
   con.setpageNumber(PageNumber);
   }

public String character{get;set;}
    
    
public List<String> getAlbhabet() {
  return albhabet;  
}

public PageReference EditTheContact(){
    System.debug('******************************************');
    PageReference Editpage=Page.StudentPanel;
    return EditPage;
    
}


public PageReference DelContact(){
  System.debug('*************************'+ApexPages.currentPage().getParameters().get('delcontactId')+delId);
  Contact contact=[Select Id,Name from Contact where id=:delId];
  delete contact;
  con=null;
  return null;
}
public ConExtension () {
  contact=new List<Contact>();
  sizeOfMap=0;
  albhabet=new List<String>
  {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','other','ALL'};
    con=new ApexPages.StandardSetController(Database.getQueryLocator([Select Id,Name,Title,Phone,Email From Contact]));
    selectedPage=10;
   
}

    
public String imageName{get;set;}
public String sortingElement;
ApexPages.StandardSetController con;
    
    
    
public List<Contact> getContact(){
  if(con==null){
    con=new ApexPages.StandardSetController(Database.getQueryLocator([Select Id,Name,Title,Phone,Email From Contact]));
    con.setPageSize(selectedPage);
    contact =(List<Contact>)con.getRecords();
    noOfdisplayedRecords=contact.size();
    return contact; 
   }
    else{
      con.setPageSize(selectedPage);
      contact =(List<Contact>)con.getRecords();
      noOfdisplayedRecords=contact.size();
      return contact; 
       
     }
}
     
public String getsortingElement(){
   return sortingElement;
}
         
       
public void setsortingElement(String s){
   sortingElement=s;
   if(sortDirection== 'ASC'){
     sortDirection='DESC';
   }
   else 
     sortDirection= 'ASC';    
}
       
public String sortDirection{get;set;}
public boolean HasPrevious{
  get{
    return con.getHasPrevious();
  }
  set;
}
      
public boolean HasNext{
  get{
    return con.getHasNext();
  }
  set;
}
      
      public void next(){
      con.next();
      }

     public void previous(){
     con.previous();
     }
      
      
public PageReference showContactAlphabet(){
  system.debug('+++++++++++++++++++++'+ConWithFlag);
  if(character=='ALL'){
  character='';
  }
  List<Contact> contacts=new List<Contact>();
  if(selectedView=='AllContact'){
    contacts=database.query('select Id,Name,Title,Phone,Email From Contact where Name like \''+character+'%\' Limit '+selectedPage);
  }
  else if(selectedView=='Birthday This Month'){
     contacts=database.query('select Id,Name,Title,Phone,Email,Birthdate From Contact where CALENDAR_MONTH(Birthdate)='+date.today().month()+' and Name like \''+character+'%\' Limit '+selectedPage);
  }
  else if(selectedView=='New Last Week'){
     contacts=database.query('select Id,Name,Title,Phone,Email,Birthdate from Contact WHERE CreatedDate = LAST_WEEK and Name like \''+character+'%\' Limit '+selectedPage);
  }
  else if(selectedView=='New This Week'){
    contacts=database.query('select Id,Name,Title,Phone,Email,Birthdate from Contact WHERE CreatedDate = THIS_WEEK and Name like \''+character+'%\' Limit '+selectedPage);
  }
   else if(selectedView=='Recently Viewed Contacts'){
      contacts=database.query('select Id,Name,Title,Phone,Email,LastModifiedDate from Contact order by LastModifiedDate WHERE Name like \''+character+'%\' Limit '+selectedPage);
  }

  con = new ApexPages.StandardSetController(contacts);
  con.setPageSize(10);      
  return null;
}
      
public PageReference PageSizeFun(){
  System.debug('*********************************'+selectedPage);
  con.setPageSize(selectedPage);
  return null;
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
  List<Contact> contacts=database.query('select Id,Name,Title,Phone,Email From Contact order by '+sortingElement+' '+sortDirection);
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
          

}