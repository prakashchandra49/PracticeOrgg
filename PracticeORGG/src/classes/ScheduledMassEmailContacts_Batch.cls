global class ScheduledMassEmailContacts_Batch implements Schedulable{
   
  public  Id tmpId;
  public String email;
  public Set<id> ID;
  public Boolean isSaveAsActivity;
  public Boolean isUseSignature;
  public Boolean isBCCme;

  public ScheduledMassEmailContacts_Batch(Set<id> ID,id tmpId,String email,Boolean isSaveAsActivity,Boolean isUseSignature,Boolean isBCCme){
    this.email=email;
    this.ID=ID;
    this.tmpId=tmpId;
    this.isSaveAsActivity=isSaveAsActivity;
    this.isUseSignature=isUseSignature;
    this.isBCCme=isBCCme;
   
}
   global void execute(SchedulableContext sc) {
      Database.executeBatch(new MassEmailContacts_Batch(ID,TmpId,email,isSaveAsActivity,isUseSignature,isBCCme));
   }
}