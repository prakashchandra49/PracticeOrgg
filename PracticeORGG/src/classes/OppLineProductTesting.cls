@isTest
public with sharing class OppLineProductTesting {
	
	public static testmethod  void myMethod(){
	List<OpportunityLineItem> items=new List<OpportunityLineItem>();
	Date myDate = date.newinstance(2012, 2, 17);
	Opportunity opp1=new Opportunity(Name='opp11',CloseDate=myDate,StageName ='Prospecting');
	//Opportunity opp2=new Opportunity(Name='opp11',CloseDate=myDate);
	insert opp1;
	System.assertEquals(opp1.id,[select id from Opportunity where id=:opp1.id].id);
	OpportunityLineItem item1=new OpportunityLineItem();
	item1.OpportunityId=opp1.id;
	item1.Quantity=33;
	item1.UnitPrice=2;
//	item1.TotalPrice=66 ; 
//	item1.ListPrice=4343;
	OpportunityLineItem item2=new OpportunityLineItem();
	item2.OpportunityId=opp1.id;
	item2.Quantity=33;
	item2.UnitPrice=2;
//	item2.TotalPrice=66 ;
//	item2.ListPrice=4343;
	items.add(item1);
	items.add(item2);
	insert items;
	}
}