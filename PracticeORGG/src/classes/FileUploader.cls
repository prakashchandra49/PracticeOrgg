public class FileUploader 
{
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    String[] filelines = new String[]{};
    List<Contact> accstoupload;
    
    public Pagereference ReadFile()
    {
        nameFile=contentFile.toString();
        system.debug('@@@@@@@@@@@@@@@@@@@@@@'+nameFile);
        filelines = nameFile.split('\n');
        system.debug('############################');
        system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$ filelines.size'+filelines.size());
        accstoupload = new List<Contact>();
        for (Integer i=0;i<filelines.size()-1;i++)
        {      
            String[] inputvalues = new String[]{};
            inputvalues = filelines[i].split(',');
           
           system.debug('############################'+inputvalues); 
            Contact a = new Contact();
     //       a.id=inputvalues[0];
            a.LastName= inputvalues[1];
            a.FirstName= inputvalues[2];       
       //     a.MailingStreet= inputvalues[2];
     //       a.MailingState= inputvalues[3];
      //      a.MailingPostalCode= inputvalues[4];
      //      a.MailingCountry= inputvalues[5];
           
            accstoupload.add(a);
        }
        try{
        upsert accstoupload id;
        }
        catch (Exception e)
        {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured. Please check the template or try again later');
            ApexPages.addMessage(errormsg);
        }    
        return null;
    }
    
    public List<Contact> getuploadedContacts()
    {
        if (accstoupload!= NULL)
            if (accstoupload.size() > 0)
                return accstoupload;
            else
                return null;                    
        else
            return null;
    }            
}