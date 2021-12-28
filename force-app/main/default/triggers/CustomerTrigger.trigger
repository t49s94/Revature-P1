trigger CustomerTrigger on Customer__c (before insert, before update) {
	Switch on Trigger.OperationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            
            for(Customer__c customer : Trigger.new) {
                if(customer.DOB__c > Date.today()) {
                    customer.addError('Enter a proper DOB!');
                } 
                
                if (customer.Phone_number__c != Null &&
                    customer.Phone_number__c.length() != 10 
                    ) {
                        customer.addError('Phone number must be 10 digits!');
                }                      
            }
        }
        
    }
}