public with sharing class CustomerService {
    @AuraEnabled(cacheable=true)
    public static List<Customer__c> getCustomers() {
       List<Customer__c> custList = [SELECT Id, Name, First_Name__c, Last_Name__c FROM Customer__c];
       return custList;
     }
}
