global class Scheduler implements Schedulable{
    global void execute(SchedulableContext SC){
    MailToOpportunityOwner_5  objMailer=new MailToOpportunityOwner_5 ();
    objMailer.mailer();
    }
}