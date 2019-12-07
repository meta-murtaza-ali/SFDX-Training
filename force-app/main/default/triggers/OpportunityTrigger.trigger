trigger OpportunityTrigger on Opportunity (before update,after update) {
    if(Trigger.isUpdate){
        if(Trigger.IsBefore){
            OpportunityManager.beforeUpdateOpportunity(Trigger.New,Trigger.oldMap);      
        }
        if(Trigger.isAfter){
            OpportunityManager.afterUpdateOpportunity(Trigger.New,Trigger.oldMap); 
        }
    }
}