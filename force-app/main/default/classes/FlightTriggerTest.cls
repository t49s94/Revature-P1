@isTest(SeeAllData=true)
public class FlightTriggerTest {
	@isTest(SeeAllData=true) public static Aircraft__c getAircraftsTest() {
        
    	Aircraft__c aircraft = [SELECT Id, Aircraft_Name__c, Capacity__c 
                                FROM Aircraft__c WHERE Approved__c != 'Approved' LIMIT 1];
        
        return aircraft;
        
	}
    
    @isTest(SeeAllData=true) public static Airport__c getAirportFromTest() {
    	Airport__c airport = [SELECT Id, Name, Airport_Name__c, State__c, City__c 
                                FROM Airport__c WHERE Airport_Name__c = 'Orlando International'];
        return airport;
        
	}
    
    @isTest(SeeAllData=true) public static Airport__c getAirportToTest() {
    	Airport__c airport = [SELECT Id, Name, Airport_Name__c, State__c, City__c 
                                FROM Airport__c WHERE Airport_Name__c = 'Tampa International'];
        return airport;
        
	}
    
    @isTest public static void aircraftTest() {
    	List<Flight__c> flights = new List<Flight__c>();
        
        Flight__c flight = new Flight__c();
        flight.Aircraft__c = getAircraftsTest().Id;
        flight.Airport_From__c = getAirportFromTest().Id;
        flight.Airport_To__c = getAirportToTest().Id;
        flight.Date__c = Date.newInstance(2022, 2, 15);
        flight.Time__c = Time.newInstance(12, 0, 0, 0);
        flight.Price__c = 300;
        
        flights.add(flight);
        insert flights;
	}
}