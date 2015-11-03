trigger Hellotrigger on Lead (before insert) {

      /*
       * begin by building a map which stores the (unique) list of leads
	       * being inserted/updated, using email address as the key.
	       */
	      Map<String, Lead> leadMap = new Map<String, Lead>();
	      for (Lead lead : System.Trigger.new) {              
	            if (lead.Email != null) { // skip null emails0	                /* for inserts OR 
	               
	                if  ( System.Trigger.isInsert ||
	                      (System.Trigger.isUpdate &&
	                        lead.Email != System.Trigger.oldMap.get(lead.Id).Email)) {
	                             
	                      if (leadMap.containsKey(lead.Email)) {
	                            lead.Email.addError('Another new lead has the same email address.');
	                      } else {
	                            leadMap.put(lead.Email, lead);
	                      }
	                }
	            }
	      }
	       
	      /* Using the lead map, make a single database query,
	       * find all the leads in the database that have the same email address as
	       * any of the leads being inserted/updated.
	       */
	      for (Lead lead : [select Email from Lead where Email IN :leadMap.KeySet()]) {
	            Lead newLead = leadMap.get(lead.Email);
	            newLead.Email.addError('A lead with this email address already exists.');
	      }
	}