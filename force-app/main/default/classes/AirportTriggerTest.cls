@isTest
public class AirportTriggerTest {

    @isTest public static void testAirportNameSuccess() {
    	Airport__c airport = new Airport__c();
        airport.Name = 'TES';
        airport.Airport_Name__c = 'TEST airport';
        airport.State__c = 'Florida';
        airport.City__c = 'Tampa';
        
        insert airport;
        
	}
    
    @isTest public static void testAirportNameError() {
    	Airport__c airport = new Airport__c();
        airport.Name = 'TEST';
        airport.Airport_Name__c = 'TEST airport';
        airport.State__c = 'Florida';
        airport.City__c = 'Tampa';
        
        insert airport;
        
	}
    
}