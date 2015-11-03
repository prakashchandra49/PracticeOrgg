/*
*     Copyright (c) 2013 CloudClickware
* 
*    Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
*    and associated documentation files (the "Software"), to deal in the Software without restriction, 
*    including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
*    and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
*    subject to the following conditions:
*
*    The above copyright notice and this permission notice shall be included in all copies or substantial 
*    portions of the Software.
* 
*    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
*    INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE 
*    AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
*    DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT 
*    OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
public with sharing class CCW_ContactPaginationController {
 
    /*
    *   item in context from the page
    */
    public String contextItem{get;set;}
 
 
    /*
    *   set controller
    */
    private ApexPages.StandardSetController setCon;
    
    
    /*
    *   the contact ids selected by the user
    */
    private Set<Id> selectedContactIds;
    
    
    /*
    *   constructor
    */
    public CCW_ContactPaginationController ()
    {
        //init variable
        this.selectedContactIds= new Set<Id>();
        
        //gather data set
        this.setCon= new ApexPages.StandardSetController( [SELECT Id, FirstName, LastName, Title, Phone, Email FROM Contact] );
        this.setCon.setpageNumber(1);
        this.setCon.setPageSize(10);
        
    }
    
    
    /*
    *   handle item selected
    */
    public void doSelectItem(){
        
        this.selectedContactIds.add(this.contextItem);
        
    }
    
    
    /*
    *   handle item deselected
    */
    public void doDeselectItem(){
        
        this.selectedContactIds.remove(this.contextItem);
        
    }
    
    
    /*
    *   return count of selected items
    */
    public Integer getSelectedCount(){
        
        return this.selectedContactIds.size();
        
    }
    
    List<id> lstContactId = new List<Id>();
    /*
    *   advance to next page
    */
    public void doNext(){
        SetContactId();
        if(this.setCon.getHasNext())
            this.setCon.next();
 
    }
    
    
    /*
    *   advance to previous page
    */
    public void doPrevious(){
      	SetContactId();
        if(this.setCon.getHasPrevious())
            this.setCon.previous();
                
    }
    
    
    
    /*
    *   return current page of groups
    */
    List<CCWRowItem> lstContact = new List<CCWRowItem>();
    public List<CCWRowItem> getContacts(){
        
        List<CCWRowItem> rows = new List<CCWRowItem>();
        
        
        for(sObject r : this.setCon.getRecords()){
            Contact c = (Contact)r;
            
            CCWRowItem row = new CCWRowItem(c,false);
            if(this.selectedContactIds.contains(c.Id)){
                row.IsSelected=true;
            }
            else{
                row.IsSelected=false;
            }
            rows.add(row);            
        }
        lstContact =  rows;       
        return rows;
        
    }
    
    public void SetContactId(){
    	for(CCWRowItem row :   lstContact){
    		if(row.IsSelected)
    			selectedContactIds.add(row.tContact.Id);
    	}
    }
    
    /*
    *   return whether previous page exists
    */
    public Boolean getHasPrevious(){
        
        return this.setCon.getHasPrevious();
        
    }
    
    
    /*
    *   return whether next page exists
    */
    public Boolean getHasNext(){
      
        return this.setCon.getHasNext();
    
    }
    
    
    /*
    *   return page number
    */
    public Integer getPageNumber(){
        
        return this.setCon.getPageNumber();
        
    }
    
    
    /*
    *    return total pages
    */
    Public Integer getTotalPages(){
    
        Decimal totalSize = this.setCon.getResultSize();
        Decimal pageSize = this.setCon.getPageSize();
        
        Decimal pages = totalSize/pageSize;
        
        return (Integer)pages.round(System.RoundingMode.CEILING);
    }
    
    
    
    /*
    *   helper class that represents a row
    */
    public with sharing class CCWRowItem{
        
        public Contact tContact{get;set;}
        public Boolean IsSelected{get;set;}
        
        public CCWRowItem(Contact c, Boolean s){
            this.tContact=c;
            this.IsSelected=s;
        }
        
    } 
}