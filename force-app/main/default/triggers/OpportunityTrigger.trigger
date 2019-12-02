trigger OpportunityTrigger on Opportunity (before update) {
    OpportunityManager.beforeUpdateOpportunity(Trigger.New,Trigger.oldMap);
}
