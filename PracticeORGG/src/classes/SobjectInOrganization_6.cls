/*
Question 6 :-  Create a Class which show the list of sobjects exists in Organization.
**/
public with sharing class SobjectInOrganization_6 {
    
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