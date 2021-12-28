@isTest()
public class MembershipTriggerTest {
    
    private static Customer__c customer;
    
    public static void setCustomer() {
        customer = new Customer__c();
        customer.First_Name__c = 'Test First name';
        customer.Last_Name__c = 'Test Last name';
        customer.DOB__c = Date.today().addYears(-2);
        customer.Passport__c = 'Test_passport';
        customer.Street_Address__c = 'Test Address';
        customer.Zipcode__c = 12345;
        customer.State__c = 'Florida';
        customer.City__c = 'Orlando';
        
        insert customer;
    }

    @isTest public static void PointsTest() {
        List<Membership__c> memberships = new List<Membership__c>();
        
        setCustomer();
        
        Membership__c membership = new Membership__c();
        membership.Points__c = -50;
        membership.Username__c = 'Test username';
        membership.Password__c = 'TestPasword1';
        membership.Level__c = 'Gold';
        membership.Customer__c = customer.Id;
        
        memberships.add(membership);
        insert memberships;
    }
    
    @isTest public static void LevelTest() {
        List<Membership__c> memberships = new List<Membership__c>();
        
        setCustomer();
        
        Membership__c membership = new Membership__c();
        membership.Points__c = 100;
        membership.Username__c = 'Test username';
        membership.Password__c = 'TestPasword1';
        membership.Customer__c = customer.Id;
        
        memberships.add(membership);
        insert memberships;
    }
}