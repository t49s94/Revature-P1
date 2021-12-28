public class FlightTriggerHelper{
    
    public static Map<Id, Aircraft__c> getAircrafts(List<Flight__c> flightList) {
        Set<Id> aircrafIds = new Set<Id>();
        
        for (Flight__c flight : flightList)
    			aircrafIds.add(flight.Aircraft__c);
        
        Map<Id, Aircraft__c> aircrafts = new Map<Id, Aircraft__c>([
                SELECT Approved__c, Aircraft_Name__c FROM Aircraft__c WHERE Id IN :aircrafIds
            ]);
        
        return aircrafts;
    }
    
    public static Map<Id, Airport__c> getAirportsFrom(List<Flight__c> flightList) {
        Set<Id> airportsFromIds = new Set<Id>();
        
        for (Flight__c flight : flightList)
            airportsFromIds.add(flight.Airport_From__c);
        
        Map<Id, Airport__c> airportsFrom = new Map<Id, Airport__c>([
            SELECT Operation_Starting_Date__c, Airport_Name__c
            FROM Airport__c WHERE Id IN :airportsFromIds
        ]);
        
        return airportsFrom;
    }
    
    public static Map<Id, Airport__c> getAirportsTo(List<Flight__c> flightList) {
        Set<Id> airportsToIds = new Set<Id>();
        
        for (Flight__c flight : flightList)
            airportsToIds.add(flight.Airport_To__c);
        
        Map<Id, Airport__c> airportsTo = new Map<Id, Airport__c>([
            SELECT Operation_Starting_Date__c, Airport_Name__c
            FROM Airport__c WHERE Id IN :airportsToIds
        ]);
        
        return airportsTo;
    }
    
    public static void validateAircraftAndAirport(List<Flight__c> flightList, Map<Id, Aircraft__c> aircrafts,
                                                 Map<Id, Airport__c> airportsFrom, Map<Id, Airport__c> airportsTo) {
        
        for (Flight__c flight : flightList) {
                
                // New variable referencing the related Account field'Next Renewal Date' 
                if(String.isNotBlank(flight.Aircraft__c)){
                    string approvalStatus = aircrafts.get(flight.Aircraft__c).Approved__c;
                    string aircraftName = aircrafts.get(flight.Aircraft__c).Aircraft_Name__c;
                    
                    if (approvalStatus != 'Approved') {
                        flight.addError('Aircraft "' + aircraftName +'" is not approved!');
                    } 
                    
                    Boolean airportFromAvailable = airportsFrom.get(flight.Airport_From__c).Operation_Starting_Date__c <=
                        flight.Date__c;
                    string airportFromName = airportsFrom.get(flight.Airport_From__c).Airport_Name__c ;
                    
                    if (!airportFromAvailable) {
                        flight.addError('Airport "' + airportFromName +'" is not ready for work!');
                    }
                    
                    Boolean airportToAvailable = airportsTo.get(flight.Airport_To__c).Operation_Starting_Date__c <=
                        flight.Date__c;
                    string airportToName = airportsTo.get(flight.Airport_To__c).Airport_Name__c ;
                    
                    if (!airportToAvailable) {
                        flight.addError('Airport "' + airportToName +'" is not ready for work!');
                    } 
                }
            }
    }

}