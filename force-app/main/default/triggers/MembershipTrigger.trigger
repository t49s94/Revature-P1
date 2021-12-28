trigger MembershipTrigger on Membership__c (before insert, before update) {
	Switch on Trigger.OperationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            
            for(Membership__c membership : Trigger.new) {
                if(membership.Points__c < 0) {
                    membership.addError('Point\'s value cannot be negative!');
                } 
                
                if (membership.Level__c == NULL ) {
                    membership.Level__c = 'Silver';
                }                      
            }
        }
        
    }
}