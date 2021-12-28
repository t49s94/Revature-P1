public with sharing class CustomerFlightService {
    @AuraEnabled()
    public static Boolean insertCustomerFlight(String customerId, String flightId, Integer checkedLuggage, 
    Integer pointsUsed, String paymentMethod) {

        Customer_Flight__c custFlight = new Customer_Flight__c();
        custFlight.Customer__c = customerId;
        custFlight.Flight__c = flightId;
        custFlight.Checked_Luggage__c = checkedLuggage;
        custFlight.Points_Used__c = pointsUsed;
        custFlight.Payment_Method__c = paymentMethod;

        Database.saveresult sr = database.insert(custFlight);

        
        if(sr.isSuccess())
            return true;
        else {
            return false;
        }

     }
}
