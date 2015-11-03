trigger Account_create on Contact (after insert) {

    list<string> contEmail=new list<string>();
    list<string> contactWithougtAccount=new list<string>();
    list<Account> accountToBeCreated=new list<Account>();
     List<Account> accountToBeUpdated=new List<Account>();
    for(contact cnt : Trigger.new){
    contEmail.add(cnt.Email);
    
    }
    list<Account> accold= new list<Account>();
    accold=[ select IsExist__c,EmailAddress__c from Account where EmailAddress__c in : contEmail];
   // list<String> contEmail1=new list<String>();
    for(String email : contEmail ){
         if(accold.size()>0){
        for(Account acc : accold){
            if(acc!=null){
            if(acc.EmailAddress__c != email){
                contactWithougtAccount.add(email);
                    }
            
                }
              }
         }
    }
    if(accold.size()==0)
    contactWithougtAccount.addAll(contEmail);
    for(String email:contactWithougtAccount){
        Account acc=new Account(name=email,EmailAddress__c=email);
        accountToBeCreated.add(acc);
        }
    insert accountToBeCreated;
 
    if(accold.size()>0){
    for(Account acc1 : accold ){
    acc1.IsExist__c=true;
      accountToBeUpdated=new List<Account>();
     accountToBeUpdated.add(acc1);
    }
update accountToBeUpdated ;
    }

}