@isTest(SeeAllData=true)
public class Customer_FlightTest {
    
    public static List<Customer_Flight__c> customerFlights = new List<Customer_Flight__c>();
    public static List<Customer__c> customers = new List<Customer__c>();
    public static List<Flight__c> flights = new List<Flight__c>();
    
    public static Aircraft__c aircraft = new Aircraft__c();
    public static Airport__c airportFrom = new Airport__c();
    public static Airport__c airportTo = new Airport__c();
    public static Membership__c membership = new Membership__c();
    
    public static void setCustomers() {
        Customer__c customer = new Customer__c();
        customer.First_Name__c = 'Test First name';
        customer.Last_Name__c = 'Test Last name';
        customer.DOB__c = Date.today().addYears(-2);
        customer.Passport__c = 'Test_passport';
        customer.Street_Address__c = 'Test Address';
        customer.Zipcode__c = 12345;
        customer.State__c = 'Florida';
        customer.City__c = 'Orlando';
        
        customers.add(customer);
        insert customers;
    }
    
    public static void setMembership() {
        membership.Points__c = 500;
        membership.Username__c = 'Test username';
        membership.Password__c = 'TestPasword1';
        membership.Level__c = 'Gold';
        membership.Customer__c = customers[0].Id;
        
        insert membership;
    }
    
    public static void setAircraft() {
        aircraft.Aircraft_Name__c = 'Test aircraft';
        aircraft.Capacity__c = 200;
        aircraft.Approved__c = 'Approved';
        
        insert aircraft;
    }
    
    public static void setAirportFrom() {
        
        airportFrom.Airport_Name__c = 'Test airport from';
        airportFrom.Name = 'TAF';
        airportFrom.State__c = 'Florida';
        airportFrom.City__c = 'Orlando';
        
        insert airportFrom;

    }
    
    public static void setAirportTo() {
        
        airportTo.Airport_Name__c = 'Test airport to';
        airportTo.Name = 'TAT';
        airportTo.State__c = 'Florida';
        airportTo.City__c = 'Tampa';
        
        insert airportTo;

    }
    
    public static void setFlights() {
        
        setAircraft();
        setAirportFrom();
        setAirportTo();
        
        Flight__c flight = new Flight__c();
        flight.Aircraft__c = aircraft.Id;
        flight.Airport_From__c = airportFrom.Id;
        flight.Airport_To__c = airportTo.Id;
        flight.Date__c = Date.Today().addMonths(2);
        flight.Time__c = Time.newInstance(12, 0, 0, 0);
        flight.Price__c = 300;
        
        flights.add(flight);
        insert flights;
    }
    
    public static void setCustomerFlights() {
        
        setCustomers();
        setFlights();
        
        Customer_Flight__c customerFlight = new Customer_Flight__c();
        customerFlight.Customer__c = customers[0].Id;
        customerFlight.Flight__c = flights[0].Id;
        customerFlight.Payment_Method__c = 'Credit card';
        customerFlight.Checked_Luggage__c = 2;
        customerFlight.Points_Used__c = 200;
        
        customerFlights.add(customerFlight);
    }
    
    @isTest public static void BookFlightTest() {
        setCustomerFlights();
        insert customerFlights;
    }
    
    @isTest public static void BookFlightWithMembershipTest() {
        setCustomerFlights();
        setMembership();
        insert customerFlights;
    }
}