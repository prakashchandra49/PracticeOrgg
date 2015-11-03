@isTest
public class TestMassEmailContactsController
  {
     static testMethod void runPositiveTestCases()
       {
         MassEmailContactsController controller=new MassEmailContactsController();
         Contact contact;
         MassEmailContactsController.ContactWrapper contactWrapper1=new MassEmailContactsController.ContactWrapper();
         contactWrapper1.isSelected=true;
         contactWrapper1.cont=new Contact(LastName='praksh');
         controller.lstcontactWrapper.add(contactWrapper1);
         system.assert((controller.getlstcontactWrapper()).size()>0);
         
         List<Contact> contactlst=new List<Contact>();
        
         controller.BindData();
         //verify BindData() before populating contacts list
         system.assertequals(0,controller.lstcontactWrapper.size());
         Account account=new Account(Name='acc1');
         insert account;
         for(Integer i=0;i<20;i++) 
           {
            contact=new Contact(AccountId=account.Id,LastName='lastName'+i,Email='prakash.chandra@metagurukul.com');
            contactlst.add(contact);
           }
       
         controller.Contacts=contactlst;
         system.assertequals(20,(controller.getcontacts()).size());
         controller.BindData();
         //verify BindData() After populating contacts list
         system.assertequals(20,controller.lstcontactWrapper.size());
         String mainPage=controller.Cancel().getUrl();
         // Verify that the https://ap1.salesforce.com/003/o page displays
          //   Schema.DescribeSObjectResult r = Contact.sObjectType.getDescribe(); 
             system.assertequals('/003/o',mainPage);
         
         
    
        for(MassEmailContactsController.ContactWrapper contactWrapper :controller.lstcontactWrapper)
          {
            contactWrapper.isSelected=true;
          }
         String SelectTeamplate=controller.SelectTeamplate().getUrl();
         
         
         // Verify that the /apex/emailtemplates page displays 
         system.assertequals('/apex/emailtemplates',SelectTeamplate);
          system.assert((controller.getEmailTemplates()).size()>0);
          PageReference SelectTeamplates=controller.FilterTemp();
          system.assertequals(null,SelectTeamplates);
          
          String massEmailTmp=controller.massEmailTmp().getUrl();
         // Verify that the /apex/MassEmailContacts page displays 
          system.assertequals('/apex/massemailcontacts',massEmailTmp);
          // Verify that the /apex/MassEmailContacts page displays
         controller.isNow='isNow';   
         String SuccessMassEmail=controller.SendMassEmail().getUrl(); 
         system.assertequals('/apex/successmassemail',SuccessMassEmail);
         
         String EmailTemplates = controller.EmailTemplates().getUrl(); 
         system.assertequals('/apex/emailtemplates',EmailTemplates);
         
         String ScheduleMassEmail = controller.ScheduleMassEmail().getUrl(); 
         system.assertequals('/apex/schedulemassemail',ScheduleMassEmail);
         controller.isNow='';
         controller.scheduleDate='';
         controller.massEmailName='AAAA';
         
         controller.SendMassEmail();
         controller.scheduleDate = '2012/12/12'; 
         controller.isSaveAsActivity = true;
         controller.isUseSignature = true;
         controller.tmpId='00X90000000TQhOEAW';
         controller.isBCCme = true;
         SuccessMassEmail=controller.SendMassEmail().getUrl(); 
         system.assertequals('/apex/successmassemail',SuccessMassEmail);
         controller.selectAll=true;
         controller.checkAll();
         controller.assignId();
         
        
         controller.TemplateName='abc';
         controller.FilterTemp();
         controller.TemplateName='my';
         
         controller.SendMassEmail();
         controller.ViewData();
      
      
      //run nagative test cases 
      
         for(MassEmailContactsController.ContactWrapper contactWrapper :controller.lstcontactWrapper)
          {
            contactWrapper.isSelected=false;
          }
         controller.SelectTeamplate();  
         controller.lstcontactWrapper=null;
         controller.SendMassEmail();
         
         controller.Contacts.add(new Contact(LastName='prakash')); 
         controller.BindData();
       }
   
  }