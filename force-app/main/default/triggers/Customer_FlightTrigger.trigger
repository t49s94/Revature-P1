trigger Customer_FlightTrigger on Customer_Flight__c (before insert, after insert) {
	Switch on Trigger.OperationType {
        when BEFORE_INSERT {
            
            Map<Id, Customer__c> customers = Customer_FlightTriggerHelper.getCustomers(trigger.new);
            Map<Id, Flight__c> flights = Customer_FlightTriggerHelper.getFlights(trigger.new);
            
        	for (Customer_Flight__c customerFlight : trigger.new) {
                
                Customer_FlightTriggerHelper.validatePointsUsedAndCheckedLuggage(customerFlight, customers);
         
                customerFlight.Amount_Paid__c = Customer_FlightTriggerHelper.getAmountPaid(customerFlight, customers, flights);
                
            }
            
        }
        
        when AFTER_INSERT {
            Map<Id, Customer__c> customers = Customer_FlightTriggerHelper.getCustomers(trigger.new);
            Map<Id, Flight__c> flights = Customer_FlightTriggerHelper.getFlights(trigger.new);
            
            List<Membership__c> membershipUpdates = 
                Customer_FlightTriggerHelper.getMembershipUpdateList(trigger.new, customers, flights);
                    
            if(!membershipUpdates.isEmpty())
            	update membershipUpdates;
        }

        
    }
}