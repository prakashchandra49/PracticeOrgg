/* Question 3 :- Create a Page Where some Filters in BilingCity, BillingState,BillingCountry of 
   Account and Click on  Search displaying first 10 Accounts at a Time and Provide Pagination for (Previous Next and First and Last)
   Hint :: ApexStandardSetController API **/
   
   
public with sharing class AccountPagination {
    private final Account acct;  
    public ApexPages.StandardSetController setCon;
    public List<Account> accList { get; set; }
    public String selectedCity { get; set; }
    public String selectedState { get; set; }
    public String selectedCountry { get; set; }
    public List<SelectOption> cities { get; set; }
    public List<SelectOption> states { get; set; }
    public List<SelectOption> countries { get; set; }
   //this will set the value of the objects 
    public AccountPagination(ApexPages.StandardSetController controller) {
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
   //will generate the appropriate query according to user selection 
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
    //will search the records as per user  selection
     public PageReference search() {
        setCon = new Apexpages.Standardsetcontroller(Database.getQueryLocator(generateQuery()));
        setCon.setPageSize(10);
        return null;
    }
    // wiil return the records from  Apexpages.Standardsetcontroller object  
    public List<Account> getAccountPagination() {
         return (List<Account>) setCon.getRecords();
    }  
     public Pagereference next(){
        setCon.next();
        return null;
    }
        public Pagereference last(){
        setCon.last();
        return null;
    }
        public Pagereference previous(){
        setCon.previous();
        return null;
    }
        
        public Boolean hasNext{
        get{
            return setCon.getHasNext();
        }
        set;
        
    }

    public Boolean hasPrevious{
        get{
                return setCon.getHasPrevious();
        }       
        set;
        
    }
    
    public Integer pageNumber{
        get{
                return setCon.getPageNumber();
        }
        set {
                setCon.setPageNumber(1);
        }
    }
    
    public Integer pageSize{
        get {
                return setCon.getPageSize();
        }
        set {
                //setCon.setPageSize(1);
        }
    }
  }