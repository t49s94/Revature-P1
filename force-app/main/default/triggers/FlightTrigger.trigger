trigger FlightTrigger on Flight__c (before insert, before update) {
	Switch on Trigger.OperationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            
            Map<Id, Aircraft__c> aircrafts = FlightTriggerHelper.getAircrafts(trigger.new);            
            Map<Id, Airport__c> airportsFrom = FlightTriggerHelper.getAirportsFrom(trigger.new);
            Map<Id, Airport__c> airportsTo = FlightTriggerHelper.getAirportsTo(trigger.new);
             
            FlightTriggerHelper.validateAircraftAndAirport(Trigger.new, aircrafts, airportsFrom, airportsTo);
            
        }
    }
}