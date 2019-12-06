trigger AccountAddressTrigger on Account (before insert,before update) {
    if(Trigger.isInsert || Trigger.isUpdate){
        if(Trigger.isBefore) {
            for(Account a: Trigger.New){
                if(a.Match_Billing_Address__c){
                    a.ShippingPostalCode = a.BillingPostalCode;
                }
            }
        }
    }
}