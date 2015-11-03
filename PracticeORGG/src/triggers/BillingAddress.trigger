trigger BillingAddress on Account (after update) {

   List<contact> contactToBeUpdated=new List<contact>();
   Set<ID> accid=new Set<ID>();
   Map<id,account> pcon=new  Map<id,account>();
   for(account acc:trigger.new){
       if(acc.BillingCity!=trigger.oldmap.get(acc.id).BillingCity){
           accid.add(acc.id);
           pcon.put(acc.id,acc);
           }
           
   }
   List<contact> contacts=[Select c.id,c.accountid,c.MailingCity, c.MailingCountry, c.MailingPostalCode, c.MailingState, c.MailingStreet from Contact c  where c.accountid in :accid]; 
   for(contact cont:contacts){
                 cont.MailingCity=pcon.get(cont.accountid).BillingCity;
                 contactToBeUpdated.add(cont);
           }
             
         
 
 update contactToBeUpdated;

}