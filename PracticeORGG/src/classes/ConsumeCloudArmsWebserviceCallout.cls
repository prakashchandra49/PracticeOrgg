global class ConsumeCloudArmsWebserviceCallout implements Schedulable {    
    global void execute(SchedulableContext SC) {     
         string jobName = String.Valueof(DateTime.Now());           
         string  CronExp ='0 0 0 '+DateTime.now().addDays(1).Day()+' '+DateTime.now().Month()+' '+'? '+DateTime.now().Year();
            System.schedule(jobName+'ConsumeCloudArmsWebserviceCallout_By_Synch_Setting', CronExp, new ConsumeCloudArmsWebserviceCallout() );  
    }

}