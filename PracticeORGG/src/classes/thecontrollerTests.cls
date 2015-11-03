@isTest
public with sharing class thecontrollerTests {
			  public static testMethod void testMyController() {
        PageReference pageRef = Page.success;
        Test.setCurrentPage(pageRef);
      
        TestPagecontroller controller = new TestPagecontroller();
        String nextPage = controller.save().getUrl();

        // Verify that page fails without parameters 
        // Verify that the failure page displays. This COVER THE CATCH BLOCK 
        System.assertEquals('/apex/failure?error=noInsert', nextPage);

       
      
        // Instantiate a new controller with all parameters in the page 
    
        controller = new TestPagecontroller(); 
        controller.setLastName('lastname');
        
        controller.setFirstName('firstname');
        controller.setCompany('acme');
        controller.setEmail('firstlast@acme.com');
        System.assertEquals('lastname', controller.getLastName());
        System.assertEquals('firstname', controller.getFirstName());
        System.assertEquals('acme', controller.getCompany());
        System.assertEquals('firstlast@acme.com', controller.getEmail());
        nextPage = controller.save().getUrl();

       // verify that the success page is display
       System.assertEquals('/apex/success', nextPage);
       
       List<Lead> lead=[select firstname,lastname,email,company from Lead where company='acme'];
       System.assertEquals(lead.get(0).company,'acme');
        }
       
}