public with sharing class SobjectInOrganization {
	
public void showOrganizationSobjects()
	{
		Map<String,Schema.Sobjecttype> sObjectsList = Schema.getGlobalDescribe();
		Set<String> keySet = SobjectsList.keySet();
		System.debug('No. of sObjects in Organization : ' + SobjectsList.size());
		for(String key : keySet)
{
System.debug('ObjectName = ' + SobjectsList.get(key));
			}
		}
	}