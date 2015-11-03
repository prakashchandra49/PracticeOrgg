trigger LoanStatus on Loan__c (after update) {
    List<Loan__c> listOfLoan=new  List<Loan__c>();
    List<String> listOfEmailID=new List<String>();
    List<Messaging.SingleEmailMessage> mailToBeSend=new List<Messaging.SingleEmailMessage>();
    for(Loan__c l:trigger.new){
        if(l.Status__c!=Trigger.oldMap.get(l.Id).Status__c)
           listOfLoan.add(l);
    }
    
    for(Loan__c ll:listOfLoan){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        listOfEmailID.add(ll.Email__c);
        mail.setToAddresses(listOfEmailID);
        mail.setHtmlBody('<p>'+ll.Status__c+'</p>');
        mailToBeSend.add(mail);
        
    
    }
    Messaging.sendEmail(mailToBeSend);
}