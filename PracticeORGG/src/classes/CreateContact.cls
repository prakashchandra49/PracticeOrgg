/**
* Email services are automated processes that use Apex classes
* to process the contents, headers, and attachments of inbound
* email.
*/
global class CreateContact implements Messaging.InboundEmailHandler {
    List<Contact> contactToBeInserted=new List<Contact>();
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) {
    
        Messaging.Inboundemailresult result = new Messaging.Inboundemailresult();
        String attachmentBody;
      
        System.debug('****** Size ==== ' + email.textAttachments.size());
        if(email.textAttachments != null && email.textAttachments.size() > 0){
          if(email.textAttachments[0].fileName.endsWith('.xml'))
            attachmentBody = email.textAttachments[0].body;
        }
        
        System.debug(' ******* Attachment Body ==== ' + attachmentBody);
        parseAttachment(attachmentBody);
        
        return result;
    }
    
    public void parseAttachment(String attachment){
        Dom.Document doc = new Dom.Document();
        try{
        doc.load(attachment);
        Dom.Xmlnode root = doc.getRootElement();
        for(Dom.Xmlnode child : root.getChildElements()){
        insertContactObjetc(child);
        }
        insert contactToBeInserted;
        }catch(System.XMLException e){
        e.getMessage();
        }
    }
    
    public void insertContactObjetc(Dom.Xmlnode child){
        String fName,lName,mobile,phone,email;
        
        Dom.Xmlnode firstName = child.getChildElement('fname', null);
        Dom.Xmlnode lastName = child.getChildElement('lname', null);
        Dom.Xmlnode phoneNumber = child.getChildElement('phone', null);
        Dom.Xmlnode mobileNumber = child.getChildElement('mobile', null);
        Dom.Xmlnode emailId = child.getChildElement('email', null);
        
        fName = firstName.getText();
        lName = lastName.getText();
        phone = phoneNumber.getText();
        mobile = mobileNumber.getText();
        email = emailId.getText();
        
        Contact contact = new Contact();
        contact.FirstName = fName;
        contact.LastName = lName;
        contact.MobilePhone = mobile;
        contact.Email = email;
        contact.Phone = phone;
        contactToBeInserted.add(contact);
      //  insert contact;
    }
}