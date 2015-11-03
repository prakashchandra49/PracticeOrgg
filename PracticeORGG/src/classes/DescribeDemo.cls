public with sharing class DescribeDemo {
	
	public static void destResult(){
  Schema.Describesobjectresult r=Account.sObjectType.getDescribe();	
  system.debug('################################'+r.getRecordTypeInfosById());
	}
}