trigger OnChangeStatus on Opportunity (after update) {   
    if(Trigger.IsAfter){         
        try{
        
          Set<Id> ownerids=new Set<Id>();
            for(Opportunity  l:trigger.new){
                if(l.Custom_Status__c!=Trigger.oldMap.get(l.Id).Custom_Status__c){                  
                   ownerids.add(l.ownerId);
                   }
            }
         Map<Id,User> ownermap=new Map<Id,User>([Select u.id,u.Email From User u where u.id in:ownerids]);   
         List<Messaging.SingleEmailMessage> mailsToSend = new List<Messaging.SingleEmailMessage>();
         EmailTemplate template = [Select e.Name, e.Id From EmailTemplate e where name='MailToOwner' and isActive=true LIMIT 1];
         for(Opportunity oppr : Trigger.new){            
            Opportunity oldOpportunity = Trigger.oldMap.get(oppr.ID);           
            if(oldOpportunity.Custom_Status__c != oppr.Custom_Status__c){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();   
                    system.debug('@@here 1');            
                    List<String> emailAddress = new List<String>();
                    emailAddress.add(ownermap.get(oppr.ownerId).email);
                    email.setToAddresses(emailAddress);
                    email.setTargetObjectId(oppr.OwnerId);
                    email.setWhatId(oppr.id);                  
                    email.setTemplateId(template .id);
                    email.setSaveAsActivity(false);                      
                    mailsToSend.add(email);           
                    system.debug('@@here 2');                  
            }
        }
        Messaging.sendEmail(mailsToSend); 
            }
        catch(Exception e){
            System.debug('Exception######-'+ e.getmessage() + 'Line No##' + e.getLineNumber());
            
        }
    }
}