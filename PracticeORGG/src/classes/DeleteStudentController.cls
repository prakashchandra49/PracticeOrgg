public with sharing class DeleteStudentController
{
    public List<Student__c> getRecords()
    {
        String queryParam = ApexPages.CurrentPage().getParameters().get('selectedIds');
        List<Id> idList = queryParam.split(',');
        List<Student__c> stuList = [select s.Id , s.FirstName__c , s.LastName__c from Student__c s where s.Id in : idList];
        return stuList;
    }
}