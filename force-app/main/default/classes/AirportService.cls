public with sharing class AirportService {
    @AuraEnabled(cacheable=true)
    public static List<Airport__c> getAirports(String strCityName) {
      String strKey = '%'+strCityName+'%';
       List<Airport__c> airList = [SELECT Id, Name, State__c, City__c FROM Airport__c WHERE Name like :strKey ];
       return airList;
     }
}
