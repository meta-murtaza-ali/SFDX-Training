public class OpportunityManager {
    public static List<Opportunity> beforeUpdateOpportunity(List<Opportunity> triggerNew,Map<Id,Opportunity> triggerOldMap){
        for(Opportunity opp :triggerNew){
            if((triggerOldMap.get(opp.Id).StageName != 'Closed Won' || triggerOldMap.get(opp.Id).StageName != 'Closed Lost' ) && (opp.StageName=='Closed Won' || opp.StageName == 'Closed Lost')){
                opp.CloseDate = System.today();
            }
        }
        return triggerNew;
    }
}