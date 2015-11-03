/*Question 4 :-Build a Custom Lookup Screen. As you have created 2 new fields (BillToContact and Manager) on Opportunity previously. Now requirement
                   is Select BillToContact using Custom LookUp (List show Contacts related to that Manager).
                   -- Create a new formula field (Select Bill To Contact) and Link to a New Custom VF Page(Hint :: HyperLink). 
                   -- VF Page showing List of Contacts which is related to that Manager with additional radio Button.
                   -- Page Contains 3 buttons (Save ,Clear Cancel). 
                   -- On Click of Save selected Contact store in BillToContact Field and return back to Opportunity 
                   -- On Click of Clear set BillTo Contact Field Null and return back to Opportunity 
                   -- Do nothing and return back to Opportunity  **/
public class Opportunity_4 {
            List<contact> contacts;
            Opportunity opp;
            public String selectedcontact{get;set;}
            //This constructor will retrieve the opportunity field as per the supplied by getParameters() method
            //opp.Manager__c is an account id and will be use to find the contact corresponding to that account id
            public Opportunity_4(ApexPages.StandardController controller) {
                opp=[select id, name,Manager__c from Opportunity where id =:ApexPages.currentPage().getParameters().get('id')];
                contacts=[select name from contact where account.id = :opp.Manager__c];
            }
           //will return the opportunity object
public Opportunity getOpportunity() {
                return opp;
            }
            //will update the opportunity
public PageReference updateopp(){
                Contact cont=new Contact();
                cont=[select id from contact where name=:selectedcontact LIMIT 1];
                opp.billtocontact__c=cont.id;
                update opp;
                
                 PageReference acctPage = new ApexPages.StandardController(opp).view();
                 acctPage.setRedirect(true);
                 return acctPage;
            
            }
            //will return the contact names
public List<SelectOption> getcontactnames(){
                List<SelectOption> options = new List<SelectOption>();
                for(Contact c:contacts){
                options.add(new selectoption(c.name,c.name));
            }
                return options;
}
public PageReference Clearopp(){
                opp.billtocontact__c=null;
                update opp;
                
                PageReference acctPage = new ApexPages.StandardController(opp).view();
                acctPage.setRedirect(true);
                return acctPage;
            }
public PageReference returnToOpportunity(){
                PageReference acctPage = new ApexPages.StandardController(opp).view();
                acctPage.setRedirect(true);
                return acctPage;
    }
}