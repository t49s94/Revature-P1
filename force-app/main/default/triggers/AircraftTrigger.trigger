trigger AircraftTrigger on Aircraft__c (before insert, before update) {
	Switch on Trigger.OperationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            
            for(Aircraft__c aircraft : Trigger.new) {
                if(aircraft.Capacity__c < 50) {
                    aircraft.addError('Capacity must be at least 50!');
                }
            }
        }
    }
}