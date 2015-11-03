global with sharing class MyContactController implements ObjectPaginatorListener
{
	private class SearchField
	{
		public boolean includeInSearch {get;set;}
		public string fieldName {get;set;}
		
		public SearchField(boolean includeInSearchParam, string fieldNameParam) {
			includeInSearch = includeInSearchParam;
			fieldName = fieldNameParam;
		}
	}
	

	public class ContactWrapper
	{
		public Contact con { get; private set; }
		public boolean checked { get;  set; }
		public string error { get; set; }
		public boolean hasError
		{
			get { return error.length() > 0; }
		}		
		public ContactWrapper(Contact visitParam)
		{
			con = visitParam;
			error = '';
			checked = false ;
		}
	}
	
	// Private Variables
	private ApexPages.standardSetController m_contactController = null;

	// Properties
  	public Contact Visit { get { return (Contact)m_contactController.GetRecord(); } }  	
	
	// Filtering
	private List<Contact> visitListAll {get;set;}
	public List<ContactWrapper> visitWrapperListPaged {get;set;}
	public string lblStatusFilter {get; set;}
	public boolean statusFilterAssigned {get; set;}
	public boolean statusFilterIncomplete {get; set;}
	public boolean statusFilterCompleted {get; set;}
	public string searchFilter {get; set;}

	// Paging and Sorting	
	global ObjectPaginator paginator {get; private set;}
	public Integer pageNumber {get; set;}
	public Integer pageSize {get; set;}
	private Integer pageSizeNew {get; set;}
	public String sortField {get; set;}
	private String previousSortField {get; set;}	
	private SearchField[] searchFieldsList {get; set;}
	

    public MyContactController(ApexPages.StandardSetController controller) 
    {
		try
        {
        	m_contactController = controller;
			Initialize();
        }
        catch(exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, String.Valueof(ex) + ex.getLineNumber()));        
        }
    }

    public void Initialize()
    {
    	paginator = new ObjectPaginator(this);
    	this.paginator.setPageSize(10);
    	
    //	lblStatusFilter = Contact.Status__c.getDescribe().getLabel();
		
		searchFieldsList = new SearchField[] {	new SearchField(true, 'Name'),
												new SearchField(true, 'FirstName'),
												new SearchField(true, 'LastName'),
												new SearchField(true, 'Email'),
												new SearchField(true, 'MailingCity')
																							
												};

		ResetFilters();
    	LoadContacts();
	}
    
    private void ResetFilters()
    {
		statusFilterAssigned = true;
		statusFilterIncomplete = true;
		statusFilterCompleted = false;
		searchFilter = '';
    }
    
    private void LoadContacts()
    {
    	string soql = CreateSOQLStatement();

		//info = soql;

		system.debug(string.format('soql: {0}', new string[] { soql } ));

		visitListAll = Database.query(soql);

		system.debug(string.format('VisitCount: {0}', new string[] { string.valueOf(visitListAll.size()) } ));

		paginator.setRecords(this.visitListAll);
    	
    	this.pagesize = this.paginator.pagesize;
    }
    
	private string CreateSOQLStatement()
	{
    	string todayString = string.ValueOf(Date.today());
    	
    	Date twoWeeksAheadDate = Date.today().addDays(+14);
    	string twoWeeksAheadDateFormatted = string.valueof(twoWeeksAheadDate);
    	
    	User me = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId()];

    	string soqlSelect = 'SELECT ';
    	for (SearchField searchField : searchFieldsList) {
    		soqlSelect += searchField.fieldName + ', ';
    	}
    	
    	soqlSelect = soqlSelect.removeEnd(', ') + ' ';

		string soqlWhereStatus = '';

		/*if (statusFilterAssigned) {
          soqlWhereStatus += 'Status_Actual__c = \'' + System.Label.VisitStatus_Assigned + '\' OR ';
		}
		if (statusFilterIncomplete) {
			soqlWhereStatus += 'Status_Actual__c = \'' + System.Label.VisitStatus_Incomplete + '\' OR ';
		}
	 	if (statusFilterCompleted) {
	 		soqlWhereStatus += 'Status_Actual__c = \'' + System.Label.VisitStatus_Completed + '\' OR ';
	 	}

		soqlWhereStatus = soqlWhereStatus.removeEnd(' OR ');
		*/
		string soqlWhere = '' ;//+ ((soqlWhereStatus.length() > 0) ? '(' + soqlWhereStatus + ') AND ' : '(Status_Actual__c = \'\') AND ');
      
		if (searchFilter.length() > 0) {
			soqlWhere += 'WHERE (';
			
			for (SearchField whereField : searchFieldsList)
			{
				if (whereField.includeInSearch == true)
				{
					soqlWhere += '(' + whereField.fieldName + ' LIKE \'%' + String.escapeSingleQuotes(searchFilter) + '%\') OR ';
				}
    		}
    		
			soqlWhere = soqlWhere.removeEnd(' OR ') + ') ';
		}

	
       // system.assert(false,soqlSelect + ' FROM Contact ' + soqlWhere + 'ORDER BY LastName');
		return soqlSelect + ' FROM Contact ' + soqlWhere + 'ORDER BY LastName';
    }

	public void savePlannedVisitDate()
	{
		/*Contact con = [SELECT Id, Status__c, Status_Actual__c, Planned_From_Date__c, StoreVisitDate__c
							FROM Contact WHERE Id = :plannedVisitId LIMIT 1];

		if (con != null)
		{
			Date newPlannedVisitDate = Date.valueOf(plannedVisitYear + '-' + plannedVisitMonth + '-' + plannedVisitDay);

			if (newPlannedVisitDate < con.Planned_From_Date__c || newPlannedVisitDate > con.StoreVisitDate__c)
			{
				SetVisitWrapperError(con.Id, System.Label.InvalidDate);
			}
			else
			{				
				try {
					
					SetVisitWrapperError(con.Id, '');
					
					con.Planned_Visit_Date__c = newPlannedVisitDate;

					update con;
				}
				catch (exception expn) {
					
					SetVisitWrapperError(con.Id, System.Label.Failed_To_Save);
					
					throw expn;
				}
			}
		}
		*/
	}
	
	private void SetVisitWrapperError(Id visitId, string error)
	{
		for (ContactWrapper visitItem : visitWrapperListPaged) {
			if (visitItem.con.Id == visitId) {
				visitItem.error = error;
				break;
			}
		}
	}

    public void search()
    {
    	LoadContacts();
    }
    
    public void clear()
    {
    	ResetFilters();
    	LoadContacts();
    }

	public PageReference save(){
		system.assert(false,'visitWrapperListPaged'+visitWrapperListPaged);
		return null;
	}
	public void doSort()
	{
		try
		{
			String sortDirection = 'asc';

			if (this.previousSortField == this.sortField) {
				sortDirection = 'desc';  
				this.previousSortField = null;  
			}
			else {  
				this.previousSortField = this.sortField;  
			}

			if (this.visitListAll.size() > 0) {
				superSort.sortList(this.visitListAll, this.sortField, sortDirection);
			}          

			this.visitWrapperListPaged.clear();

			for (Contact con : this.visitListAll) {
				this.visitWrapperListPaged.add(new ContactWrapper(con));
			}
			
			this.paginator.first();
		}
		catch (exception expn) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, string.valueOf(expn) + ' ' + expn.getLineNumber()));        
		}
	}
	
	global void handlePageChange(List<Object> newPage)
    {
		if (this.visitWrapperListPaged != null) {
            this.visitWrapperListPaged.clear();
        }
        else {
            this.visitWrapperListPaged = new List<ContactWrapper>();
        }
        
        if (newPage != null && newPage.size() > 0) {
            for (Integer i = 0; i < newPage.size(); i++) {
                this.visitWrapperListPaged.add(new ContactWrapper((Contact)newPage.get(i)));
            }
        }
	}
    
    public PageReference skipToPage()
    {//system.assert(false,'this.pageNumber'+this.pageNumber);
		try{
			if (this.pageNumber != null) {
	            this.paginator.skipToPage(pageNumber);
	        }
	        else {
	            this.pageNumber = 0; 
	            this.paginator.skipToPage(pageNumber);
	        }
		}
		catch(Exception e){
			system.assert(false,'Errror'+e.getMessage()+' Line number '+ e.getLineNumber());
		}
		return null;
    }  
    
    
    global PageReference setPageSize()
    {
		if (pageSizeNew != null) {
            this.paginator.setPageSize(pageSizeNew);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, string.valueOf(pageSizeNew)));
            return null;
        }   
        else {
            pageSizeNew = pageSize;
            this.paginator.setPageSize(pageSizeNew);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, string.valueOf(pageSize)));
            return null;
        }             
	}
}