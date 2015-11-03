public with sharing class opprtunity_product_Extension {
   public Opportunity opp{get;set;}
   public boolean showDetail{get;set;}
   public ID  oppid{get;set;}
   public ID productid{get;set;}
   public ID priceid{get;set;}
   public boolean isOppRendered{get;set;}
   public boolean isProductRendered{get;set;}
   public boolean isPriceRendered{get;set;}
   public  opprtunity_product_Price prpr{get;set;}
   public List<opprtunity_product_Price> listprpr{get;set;} 
   public List<OpportunityLineItem> oppLineItem{get;set;}
    public opprtunity_product_Extension(ApexPages.StandardController controller) {
            opp=[Select o.Id, o.Name from Opportunity o where id=:ApexPages.currentPage().getParameters().get('id')];
            listprpr=new List<opprtunity_product_Price>();
            oppLineItem=[Select o.Id, o.OpportunityId, o.PricebookEntryId from OpportunityLineItem o where OpportunityId=:opp.id];
            system.debug('@@@@@@@@@@@@@@@@@@oppLineItem'+oppLineItem);
            for(OpportunityLineItem item:oppLineItem){
               PricebookEntry priceBookEntry =[Select p.Id, p.Name, p.Pricebook2Id, p.Pricebook2.Id, p.Pricebook2.Name, p.Product2Id, p.Product2.Id, p.Product2.Name, p.Product2.ProductCode from PricebookEntry p where id=:item.PriceBookEntryId];
               prpr=new opprtunity_product_Price();
               prpr.opprtunity=opp.id;
               prpr.opprtunityName=opp.name;
               prpr.product=priceBookEntry.Product2Id;
               prpr.productName=priceBookEntry.Product2.Name;
               prpr.Price=priceBookEntry.Pricebook2Id;
              listprpr.add(prpr);
               showDetail=false;
            }
    }
public void showDetailPage(){
  showDetail=true;
  isOppRendered=true;
  isProductRendered=false;
  isPriceRendered=false;
  System.debug('************'+showDetail+'&&&&&&&&&&'+oppId);
 
}
public void productDetail(){
     showDetail=true;
     isOppRendered=false;
     isProductRendered=true;
     isPriceRendered=false;
}
public void PriceBookEntryDetail(){
  showDetail=true;
  isOppRendered=false;
  isProductRendered=false;
  isPriceRendered=true;
}
    
   public class opprtunity_product_Price{
       public id opprtunity {get;set;}
       public String opprtunityName{get;set;}
       public id product{get;set;}
       public String productName{get;set;}
       public id Price{get;set;}
       public String PriceName{get;set;}
      public opprtunity_product_Price(){}
   } 
}