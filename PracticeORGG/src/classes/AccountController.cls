/*Question 2 :- Create a Page Where some Filters in BilingCity, BillingState,BillingCountry of Account and
   Click on  Search displaying first 100 Accounts. **/

public with sharing class AccountController {

   
 
    public List<Account> accList { get; set; }
    public String selectedCity { get; set; }
    public String selectedState { get; set; }
    public String selectedCountry { get; set; }
    public List<SelectOption> cities { get; set; }
    public List<SelectOption> states { get; set; }
    public List<SelectOption> countries { get; set; }
    Apexpages.Standardsetcontroller setCon;
  //This constructor will set the value for the objects
    public AccountController() {
        cities = new List<SelectOption>();
        states = new List<SelectOption>();
        countries = new List<SelectOption>();
        cities.add(new SelectOption('','-Select City-'));
        states.add(new SelectOption('','-Select State-'));
        countries.add(new SelectOption('','-Select Country-'));
        selectedCity = '';
        selectedState = '';
        selectedCountry = '';
    for(Account a : [Select id,name,BillingCity,BillingState,BillingCountry from Account]){
            if(a.BillingCity!=null && a.BillingCity!=''){
                cities.add(new SelectOption(a.BillingCity,a.BillingCity));
            }
            if(a.BillingState!=null && a.BillingState!=''){
                states.add(new SelectOption(a.BillingState,a.BillingState));
            }
            if(a.BillingCountry!=null && a.BillingCountry!='' ){
                countries.add(new SelectOption(a.BillingCountry,a.BillingCountry));
            }
            system.debug('This is provided in for loop of aaccount'+accList);
        }
        system.debug('This is provided in constructor'+accList);
        
        setCon = new Apexpages.Standardsetcontroller(Database.getQueryLocator(generateQuery()));
        setCon.setPageSize(0);
        }  
          
   //This will generate the appropriate query according to user selection
    
    public String generateQuery(){
        String query = 'select id,name from Account';
        String whereClause = '';
        if(selectedCity!=null && selectedCity!=''){
            whereClause =' BillingCity =\''+selectedCity+'\'';
        }
        if(selectedState!=null && selectedState!=''){
            if(whereClause!=''){
                whereClause +=' and ';    
            }
            whereClause +=' BillingState =\'' + selectedState + '\'';
        }
        if(selectedCountry!=null && selectedCountry!=''){
            if(whereClause!=''){
                whereClause +=' and ';    
            }
            whereClause +=' BillingCountry =\''+ selectedCountry +'\'';
        }
        if(whereClause!=''){
            query +=' Where '+whereClause; 
        }
        return query;
    }
     public PageReference search() {
           setCon = new Apexpages.Standardsetcontroller(Database.getQueryLocator(generateQuery()));
           return null;
    }
   // wiil return the records from  Apexpages.Standardsetcontroller object
    public List<Account> getAccountPagination() {
         return (List<Account>) setCon.getRecords();
    }  
 
        
}