public class Customer_FlightTriggerHelper {

    public static Map<Id, Customer__c> getCustomers(List<Customer_Flight__c> customer_flights) {
        Set<Id> customersIds = new Set<Id>();
        
        for (Customer_Flight__c customerFlight : customer_flights)
            customersIds.add(customerFlight.Customer__c);
        
        Map<Id, Customer__c> customers = new Map<Id, Customer__c>([
            SELECT Id, ( SELECT Points__c, Level__c FROM Memberships__r) 
            FROM Customer__c WHERE Id IN :customersIds
        ]);

        return customers;
    }
    
    public static Map<Id, Flight__c> getFlights(List<Customer_Flight__c> customer_flights) {
        Set<Id> flightsIds = new Set<Id>();
        
        for (Customer_Flight__c customerFlight : customer_flights)
            flightsIds.add(customerFlight.Flight__c);
        
        Map<Id, Flight__c> flights = new Map<Id, Flight__c>([
            SELECT Price__c FROM Flight__c WHERE Id IN :flightsIds
        ]);
        
        return flights;
    }
    
    public static Decimal getMembershipDiscount(List<Membership__c> membership ) {
        Decimal membershipDiscount = 1;
        
        if(!membership.isEmpty()){
            switch on (membership[0].Level__c) {
                when 'Silver' {
                    membershipDiscount = 0.9;
                }
                when 'Gold' {
                    membershipDiscount = 0.85;
                }
                when 'Platinium' {
                    membershipDiscount = 0.8;
                }
            }
        }

        return membershipDiscount;
    }
    
    public static void validatePointsUsedAndCheckedLuggage(Customer_Flight__c customerFlight, 
                                                           Map<Id, Customer__c> customers) {

       if(!customers.get(customerFlight.Customer__c).Memberships__r.isEmpty()) {
            
            if(customerFlight.Points_Used__c < 0)
                customerFlight.addError('Point\'s value must be positive!');
            
            if(customerFlight.Points_Used__c > customers.get(customerFlight.Customer__c).Memberships__r[0].Points__c)
                customerFlight.addError('Insufficient points. You only have ' + 
                    customers.get(customerFlight.Customer__c).Memberships__r[0].Points__c);
                                                              
        }                                                        
                  
        if(customerFlight.Checked_Luggage__c != NULL && customerFlight.Checked_Luggage__c < 0) {
        	customerFlight.addError('Checked luggage\'s value must be positive!');
        }
    }
    
    public static Decimal getPointsDiscount(List<Membership__c> membership, Decimal pointsUsed) {

		Decimal pointsDiscount = 0;                                                                
        if(!membership.isEmpty()) {
			pointsDiscount = pointsUsed / 100;
        }
        
        return pointsDiscount;
    }
    
    public static Decimal getAmountPaid(Customer_Flight__c customerFlight, 
                                        Map<Id, Customer__c> customers,
                                        Map<Id, Flight__c> flights) {

		Decimal membershipDiscount = Customer_FlightTriggerHelper.getMembershipDiscount
                    (customers.get(customerFlight.Customer__c).Memberships__r);

                Decimal flightPrice = flights.get(customerFlight.Flight__c).Price__c;
                
                Decimal checkedBagsPrice = 0;
                if(customerFlight.Checked_Luggage__c != NULL)
                	checkedBagsPrice = customerFlight.Checked_Luggage__c * 50;
                else
                	customerFlight.Checked_Luggage__c = 0;
                
                Decimal pointsDiscount = 0;
                if(customerFlight.Points_Used__c != NULL)
                	pointsDiscount = Customer_FlightTriggerHelper.getPointsDiscount
                    	(customers.get(customerFlight.Customer__c).Memberships__r, (Decimal)customerFlight.Points_Used__c);
                else
                    customerFlight.Points_Used__c = 0;
                
                if (pointsDiscount == 0)
                    customerFlight.Points_Used__c = 0;
                
                Decimal amountPaid = flightPrice * membershipDiscount + checkedBagsPrice - pointsDiscount;
                return amountPaid;
                
    }
    
    public static List<Membership__c> getMembershipUpdateList(List<Customer_Flight__c> customerFlights,
                                                             Map<Id, Customer__c> customers,
                                                             Map<Id, Flight__c> flights) {
        List<Membership__c> membershipUpdates = new List<Membership__c>();
                                                                 
        for (Customer_Flight__c customerFlight : customerFlights) {
                if(!customers.get(customerFlight.Customer__c).Memberships__r.isEmpty()) {
                    Integer pointsEarned = (Integer)flights.get(customerFlight.Flight__c).Price__c;
                    Integer pointsUsed = (Integer)customerFlight.Points_Used__c;
                    
                    Integer pointsNewValue = (Integer)customers.get(customerFlight.Customer__c).Memberships__r[0].Points__c
                        + pointsEarned - pointsUsed;
                    customers.get(customerFlight.Customer__c).Memberships__r[0].Points__c = pointsNewValue;
                    
                    membershipUpdates.add(customers.get(customerFlight.Customer__c).Memberships__r[0]);
                }
            }

        return membershipUpdates;
    }
    
}