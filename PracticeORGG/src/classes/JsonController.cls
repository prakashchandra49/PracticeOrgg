/*Question 6 :-  Create a page which show output as a JSON formatted string.
            Hint :- We can use this mechanism when we send response to any service as a JSON.  **/
public class JsonController {
  
  public String jsonArrayString{get;set;}
  
  public JsonController(){
    
    List<Student__c> stuList = new List<Student__c>();
    string jsonString= '';
    for(Student__c std:[select Firstname__c,LastName__c,DOB__c,age__c from Student__c limit 5]){
      jsonString+='Student {';
      jsonString+='"Student Name:"' + '"'+std.Firstname__c+'",';
      jsonString+='"LastName:"' + '"'+std.LastName__c+'",';
      jsonString+='"DateOfBirth:"' + '"'+std.DOB__c+'",';
      jsonString+='"Age:"' + '"'+std.age__c+'",';
      jsonString+='},';
      stuList.add(std);
    }
    String jsonTotalString = '("Student_Array": [' + jsonString + '])';
    this.jsonArrayString = jsonTotalString;
    
  }
  

}