public with sharing class FlightService {
    @AuraEnabled(cacheable=true)
    public static List<Flight__c> getFlights(String airportFrom, String airportTo, Date flightDate) {
      
       List<Flight__c> flightList = [SELECT Id, Airport_From__r.Id, Airport_From__r.Name, Airport_To__r.Id, Airport_To__r.Name, Price__c, Date__c, Time__c 
       FROM Flight__c WHERE Airport_From__c = :airportFrom AND Airport_To__c = :airportTo AND Date__c = :flightDate];
       return flightList;

     }
}
