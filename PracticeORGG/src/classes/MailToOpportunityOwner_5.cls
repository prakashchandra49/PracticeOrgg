/*
Question 5 :-  Create a Scheduler to mail to Opportunity Owner , 
if not modified for last 30 days.
**/
public with sharing class MailToOpportunityOwner_5 {
public void mailer(){
    List<Messaging.SingleEmailMessage> singleEmailMessage;
    List<Opportunity> ModDate=[Select o.Owner.Email, o.OwnerId, o.LastModifiedDate From Opportunity o limit 10];
    for(Opportunity obj:ModDate){
        singleEmailMessage=new  List<Messaging.SingleEmailMessage>();
        Datetime dt=obj.LastModifiedDate;
        Date d = Date.newInstance(dt.year(),dt.month(),dt.day());
        integer days=d.daysBetween(Date.today());
        List<String> email=new List<String>();
        System.debug(obj.Owner.Email);
        email.add(obj.Owner.Email);
        System.debug('OwnerId:::::::::::::::::::::::::::::::::::'+obj.OwnerId);
        if(days>15){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(email);
            mail.setSubject('Email To Oppotunity Owner');
            mail.setHtmlBody('Html Body');
            singleEmailMessage.add(mail);
          
            }
        }
          Messaging.sendEmail(singleEmailMessage);
    }
}