trigger PopulateOpportunity on Opportunity (before update, after update) {
    List<Opportunity> oppList = new List<Opportunity>();
    if(Trigger.isUpdate && Trigger.isBefore){
            for(Opportunity opp :Trigger.New){
                if((Trigger.oldMap.get(opp.Id).StageName != 'Closed Won' || Trigger.oldMap.get(opp.Id).StageName != 'Closed Lost' ) && (opp.StageName=='Closed Won' || opp.StageName == 'Closed Lost')){
                    opp.CloseDate = System.today();
                }
            }
    }
}