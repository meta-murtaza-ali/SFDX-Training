trigger OpportunityTrigger on Opportunity (before update) {
    if(trigger.isUpdate){
        if(trigger.IsBefore){
            OpportunityManager.beforeUpdateOpportunity(Trigger.New,Trigger.oldMap);
        }
    }
}