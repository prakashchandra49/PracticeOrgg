trigger validateRecord on CampaignMember (after insert) {
   
   try{
       contact con = new contact(id='ssss');
       insert con;
       //throw  new myCustomException('Prakash Error Message');
   }
   catch(Exception ex){
    throw  new myCustomException('Prakash Error Message');
   }
   
}