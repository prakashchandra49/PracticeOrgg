public with sharing class ShoppingCartCon {
    public ID productID{get;set;}
    public Integer quantity{get;set;}
    public Integer TotalPrice{get;set;}
    public Boolean isRenderedd{get;set;}
    public Account account{get;set;}
    public Boolean isDone{get;set;}
    public Boolean isGenereted{get;set;}
    public List<Account> accountsFromDb{get;set;}
    public List<Wrapper> ProductLineItem=new List<Wrapper>();
    public ShoppingCartCon(ApexPages.StandardSetController controller) {
      setCon=new ApexPages.StandardSetController(Database.getQueryLocator([Select m.Id, m.Name__c, m.price__c,m.category__c from MyProduct__c m]));
      setCon.setPageSize(5);
      isRenderedd=false;
      isDone=false;
      isGenereted=false;
      accountsFromDb=[select a.id,a.Name from Account a];
      
    }


    public ShoppingCartCon(ApexPages.StandardController controller) {
      
    }
    public List<SelectOption> getAccounts()
    {     List<SelectOption> options = new List<SelectOption>();
        for(Account acc:accountsFromDb){
            options.add(new SelectOption(acc.id,acc.Name));
        }
        return (List<SelectOption>)options ;
    }
    
    
   
 
    

    public ApexPages.StandardSetController setCon;
    public ShoppingCartCon (){
        system.debug('saaa');
 
    }
    public List<MyProduct__c> getProduct(){
        return (List<MyProduct__c>)setCon.getRecords();
    }
    public void addToCart(){
       
        isRenderedd=true;
        system.debug(':::::----------------------------------'+isRenderedd);
        Boolean isAdded=false;
        Wrapper Wrapperobj=new Wrapper();
        Wrapperobj.product=[Select m.Id, m.Name__c, m.price__c,m.category__c from MyProduct__c m where  m.id=:productID];
        Wrapperobj.quantity=1;
        Wrapperobj.Total=(Integer)(Wrapperobj.product.price__c)*(Wrapperobj.quantity);
        for(Wrapper  wrapper:ProductLineItem){
            if(wrapper.product.id==productID){
                isAdded=true;
                wrapper.quantity++;
                wrapper.Total=(Integer)(wrapper.product.price__c)*(wrapper.quantity);
                }
        }
        if(!isAdded)
         ProductLineItem.add(Wrapperobj);
  
    }
   
    public void Proceed(){
     //   System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+isDone);
        isDone=true;
     //   System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+isDone);
    }
  public void GenerateInvoice(){
 //   system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@ ProductLineItem sizs'+ProductLineItem .size());
 // gen();
     isGenereted=true;
  } 
  
  public void gen(){
   for(Wrapper  wrapper:ProductLineItem){
           if(wrapper!=null)
          TotalPrice+=(Integer)wrapper.Total;
        } 
  }
    public List<Wrapper> getproductLineItem(){
    
        return (List<Wrapper>)ProductLineItem;
        
    }
  public void removeFromCart(){
      system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ProductLineItem.size()'+ProductLineItem.size());
      if(ProductLineItem.size()==1)
      isRenderedd=false;
      system.debug('sdfsdfsdfsdf');
      Integer count=-1;
       for(Wrapper  wrapper:ProductLineItem){
           count++;
            if(wrapper.product.id==productID){
                break;
                }
        }
     ProductLineItem.remove(count); 
     system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ isRenderedd'+isRenderedd);  
  }  
    
public class Wrapper{
  public Myproduct__c product{get;set;}
  public Integer quantity{get;set;}
  public Integer Total{get;set;}
}    
        
    
}