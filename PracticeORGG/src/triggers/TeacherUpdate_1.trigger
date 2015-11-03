trigger TeacherUpdate_1 on Contact (before insert,before update) {
    List<Contact> listOfContact=Trigger.new;
    for(Contact con:listOfContact){
        if(con.Subjects__c=='Hindi')
        {
            con.addError('Sorry You Cant Insert This Record');
        }
    }
}