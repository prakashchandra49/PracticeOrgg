public with sharing class productselectionController {
  
  public List<Product2> lstProduct;
  public Boolean selectAll{get;set;} 
  public map<id,Product2> selectedProducts=new map<id,Product2>();
  public Integer quantity{get;set;}
  public ApexPages.StandardSetController con;
  
  public PageReference saveToDatabase(){
    List<Product2> prd =( List<Product2>) selectedProducts.values();
    system.debug('@@@@@@@@@@@@@@@@@@@@@@'+prd[0].PricebookEntries[0].id);
    OpportunityLineItem opportunityLineItem = new OpportunityLineItem ();
    opportunityLineItem .OpportunityId ='00690000004pvXT';
    opportunityLineItem .Quantity = quantity;
    opportunityLineItem.PricebookEntryId = prd[0].PricebookEntries[0].id;
   opportunityLineItem.TotalPrice=prd[0].PricebookEntries[0].UnitPrice * quantity;
    insert opportunityLineItem ;
//    opportunityLineItem .OpportunityId
  //  opportunityLineItem .OpportunityId
     return null;
  }
  
  public Pagereference addProduct(){
 //   system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@'+selectedProducts);
    return  Page.multilineitem;
  }  
  public List<Product2> getselectedProducts(){
    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@'+selectedProducts.values());
    return selectedProducts.values();
  }
    
  public productselectionController (){
     con=new ApexPages.StandardSetController(Database.getQueryLocator([Select p.Description, p.Family, p.Name, p.ProductCode,(Select id,UnitPrice From PricebookEntries) from Product2 p]));
     con.setPageSize(5);
     lstProduct=new List<Product2>();
      Set<String> lsts= Schema.SObjectType.Product2.fields.getMap().keySet();
     system.debug('@@@@@@@@@@@@@@@ DescribeFieldResult F'+lsts );
    
    }
    public List<Product2> getProduct(){
  
    if(con==null)
    {
       con=new ApexPages.StandardSetController(Database.getQueryLocator([Select p.id,p.Description, p.Family, p.Name, p.ProductCode, (Select UnitPrice From PricebookEntries) from Product2 p]));
     //  con.setPageSize(selectedPage);
       con.setPageSize(5);
       lstProduct=(List<Product2>)con.getRecords();
     //  noOfdisplayedRecords=contact.size();
       return lstProduct; 
    }
    else
    {
        lstProduct=(List<Product2>)con.getRecords();
        return lstProduct; 
       
     }
    }
  
    
  public void addToMap(){
    Integer c=0;
    Integer c1=0;
    for(ProductWrapper productWrapper :lstProductWrapper){
      c++;
      if(!selectedProducts.containskey(productWrapper .Product.Id)){
        if(productWrapper .isSelected==true){
          c1++;
          selectedProducts.put(productWrapper .Product.Id,productWrapper .Product);
        }
    }
    else{
     if(productWrapper .isSelected==false){
       selectedProducts.remove(productWrapper .Product.Id);
    }
    else{
      c1++;
    }
      
   }
  }
    if(c==c1){
    selectAll=true;
    }
    else{
    selectAll=false;
    }
 
} 

  public List<ProductWrapper> lstProductWrapper;
  public List<ProductWrapper> getlstProductWrapper(){
    lstProductWrapper=new List<ProductWrapper>();
    for(Product2 c:getProduct()){
      if(selectedProducts.get(c.Id)!=null){
        if(c.id==selectedProducts.get(c.Id).id){
          ProductWrapper co=new ProductWrapper(c,true);
          lstProductWrapper.add(co);
   
        }
    }
  else{
    ProductWrapper co=new ProductWrapper(c,false);
    lstProductWrapper.add(co);
   }
}
//system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@lstProductWrapper'+lstProductWrapper);
//pageNumber=con.getPageNumber();
return lstProductWrapper;
}
 

                    
  
  
  
// indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
 
    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
 
    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
 
    // returns the first page of records
    public void first() {
        con.first();
    }
 
    // returns the last page of records
    public void last() {
        con.last();
    }
 
    // returns the previous page of records
    public void previous() {
       
        con.previous();
       
    }
 
    // returns the next page of records
    public void next() {
           
           
        con.next();
       
    }
   
 
 
 
  public class ProductWrapper {
    public Product2 Product{get;set;}
    public Boolean isSelected {get;set;}
   // public Opportunity opportunity {get;set;}
    public ProductWrapper() {
      Product = new Product2();
    //  opportunity =new Opportunity ();
      isSelected = false; 
    } 
    public ProductWrapper(Product2 Productt,Boolean isSelectedd) {
      Product = Productt;
      isSelected = isSelectedd; 
  //    opportunity = opp;
    } 
  }//closing inner class   
}//closing outer class