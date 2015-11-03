global class MassEmailContacts_Batch implements Database.Batchable<sObject>{
  public  Id tmpId;
  public String email;
  public Set<id> ID;
  public Boolean isSaveAsActivity;
  public Boolean isUseSignature;
  public Boolean isBCCme;
  

  public MassEmailContacts_Batch(Set<id> ID,id tmpId,String  email,Boolean isSaveAsActivity,Boolean isUseSignature,Boolean isBCCme){
    this.email=email;
    this.ID=ID;
    this.tmpId=tmpId;
    this.isSaveAsActivity=isSaveAsActivity;
    this.isUseSignature=isUseSignature;
    this.isBCCme=isBCCme;
   
}
global Database.querylocator start(Database.BatchableContext BC){
            return Database.getQueryLocator([Select id, Name, Phone, Fax,Email,Account.Name from Contact WHERE id in :ID]);
            }

global void execute(Database.BatchableContext BC, List<sObject> scope){
    List<Account> accns = new List<Account>();
    List<Messaging.SingleEmailMessage> mailToBeSend=new List<Messaging.SingleEmailMessage>();
   for(sObject s : scope)
   { 
     List<String> lstEmailID=new List<String>();
     List<String> lstBccAddress=new List<String>();
     lstBccAddress.add(email);
     Contact con = (Contact)s;
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
     lstEmailID.add(String.valueOf(con.Email));
     system.debug('$$$$$$$$$$$$$$$$$mail.setTargetObjectId'+con.Email);
     mail.setTargetObjectId(con.id);
     system.debug('####################'+lstEmailID);
     mail.setToAddresses(lstEmailID);
     mail.setTemplateId(tmpId);
   //  mail.setWhatId(opp.id);
     mail.setReplyTo('prakashchandraporivar@gmail.com');
     if(!isSaveAsActivity)
     mail.setSaveAsActivity(false);
     if(!isUseSignature)
     mail.useSignature=false;
     if(isBCCme)
     mail.setBccAddresses(lstBccAddress);
     mailToBeSend.add(mail);
     
   }

Messaging.sendEmail(mailToBeSend);
    
}
global void finish(Database.BatchableContext BC){
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

mail.setToAddresses(new String[] {email});
mail.setReplyTo('prakashchandraporivar@gmail.com');
mail.setSenderDisplayName('Batch Processing');
mail.setSubject('Batch Process Completed');
mail.setPlainTextBody('Batch Process has completed');

Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
 }
}