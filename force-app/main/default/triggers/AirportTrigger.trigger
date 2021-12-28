trigger AirportTrigger on Airport__c (before insert, before update) {
	Switch on Trigger.OperationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            
            for(Airport__c airport : Trigger.new) {
                if(airport.Name.length() != 3) {
                    airport.addError('Airport Code must be 3 characters!');
                }
                
                airport.Operation_Starting_Date__c = Date.today().addMonths(1);
            }
        }
        
    }
}