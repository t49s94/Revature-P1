@isTest
public class AircraftTriggerTest {
	@isTest public static void testCapacitySucces() {
    	Aircraft__c aircraft = new Aircraft__c();
        aircraft.Aircraft_Name__c = 'Test aircraft';
        aircraft.Capacity__c = 200;
        
        insert aircraft;
        
	}
    
    @isTest public static void testCapacityError() {
    	Aircraft__c aircraft = new Aircraft__c();
        aircraft.Aircraft_Name__c = 'Test aircraft';
        aircraft.Capacity__c = 30;
        
        insert aircraft;
        
	}
}