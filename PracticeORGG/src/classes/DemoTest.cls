public with sharing class DemoTest{
         public String getRecord(id idd){
            student__c st=[select firstname__c from student__c where id=:idd];
            return st.firstname__c;
        }

}