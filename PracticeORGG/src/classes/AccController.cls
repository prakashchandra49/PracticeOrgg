public with sharing class AccController {
         List<contact> contacts;
         public String selectedcontact{get;set;}
    public AccController(ApexPages.StandardController controller) {
         contacts=[select name from contact where account.id = :ApexPages.currentPage().getParameters().get('id')];
    }
    public List<SelectOption> getcontactnames(){
                List<SelectOption> options = new List<SelectOption>();
                for(Contact c:contacts){
                options.add(new selectoption(c.id,c.name));
            }
                return options;
}
}