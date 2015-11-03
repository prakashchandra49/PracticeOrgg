public with sharing class TestPopup {
   public boolean displayPopup {get;set;}
   public TestPopup (){
       displayPopup =false;
   }
   public void show()
   {
       displayPopup = true;
   }
   public void hide()
   {
       displayPopup = false;
   }
}