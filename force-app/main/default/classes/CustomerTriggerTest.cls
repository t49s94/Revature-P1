@isTest
public class CustomerTriggerTest {
    @isTest public static void DOBTest () {
        List<Customer__c> customers = new List<Customer__c>();
        
        Customer__c customer = new Customer__c();
        customer.First_Name__c = 'Test First name';
        customer.Last_Name__c = 'Test Last name';
        customer.DOB__c = Date.today().addMonths(1);
        customer.Passport__c = 'Test_passport';
        customer.Street_Address__c = 'Test Address';
        customer.Zipcode__c = 12345;
        customer.State__c = 'Florida';
        customer.City__c = 'Orlando';
        
        customers.add(customer);
        insert customers;
    }
    
    @isTest public static void PhoneNumberTest () {
        List<Customer__c> customers = new List<Customer__c>();
        
        Customer__c customer = new Customer__c();
        customer.First_Name__c = 'Test First name';
        customer.Last_Name__c = 'Test Last name';
        customer.DOB__c = Date.today().addYears(-1);
        customer.Phone_number__c = '123456789';
        customer.Passport__c = 'Testpassport';
        customer.Street_Address__c = 'Test Address';
        customer.Zipcode__c = 12345;
        customer.State__c = 'Florida';
        customer.City__c = 'Orlando';
        
        customers.add(customer);
        insert customers;
    }
}