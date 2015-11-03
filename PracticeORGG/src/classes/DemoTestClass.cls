@isTest
private class DemoTestClass {
		static testMethod void myUnitTest(){
			DemoTest obj=new DemoTest();
		  String str=obj.getRecord(createRecord());
		  Test.startTest();
		  system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$'+str);
		  system.assertEquals(str,'prakash');
		  Test.stopTest();
		}
		public static Id createRecord(){
				Student__c testObject=new Student__c();
				testObject.LastName__c='chandra';
				testObject.FirstName__c='prakash';
				class__c cls=new class__c(name__c='III');
				insert cls;
				testObject.ClassSt__c=cls.id;
				insert testObject;
				return testObject.id;
				
		}
		 
}