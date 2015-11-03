trigger MailToOwner on Opportunity (before update) {
  
  try{  
  List<Opportunity> listOfOpp=new  List<Opportunity>();
    List<String> listOfEmailID=new List<String>();
    List<Messaging.SingleEmailMessage> mailToBeSend=new List<Messaging.SingleEmailMessage>();
    Set<Id> ownerids=new Set<Id>();
    for(Opportunity  l:trigger.new){
        if(l.Custom_Status__c!=Trigger.oldMap.get(l.Id).Custom_Status__c){
           listOfOpp.add(l);
           ownerids.add(l.ownerId);
           }
    }
    EmailTemplate temp=[Select e.Name, e.Id From EmailTemplate e where name='MailToOwner' and isActive=true LIMIT 1];
    Map<Id,User> ownermap=new Map<Id,User>([Select u.id,u.Email From User u where u.id in:ownerids]);
    for(Opportunity   opp:listOfOpp){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       listOfEmailID.add(String.valueOf(ownermap.get(opp.ownerid).Email));
        mail.setTargetObjectId(opp.OwnerId);
        system.debug('####################'+listOfEmailID);
        mail.setToAddresses(listOfEmailID);
        mail.setTemplateId(temp.id);
        mail.setWhatId(opp.id);
        mail.setReplyTo('prakashchandraporivar@gmail.com');
        mail.setSaveAsActivity(false);
        mailToBeSend.add(mail);
        
    
    }
    Messaging.sendEmail(mailToBeSend);
    }
    catch(Exception e){
        system.debug('exception##'+e.getMessage()+ 'line no##'+e.getlinenumber());
    }
}