@isTest(seealldata=false)
public class TestPopulateOpportunity {
    @isTest static void testPositive(){
        Opportunity opp = new Opportunity(Name='Opportuity',CloseDate=Date.newInstance(2019,11,05),StageName = 'Prospecting');
        insert opp;
        Opportunity opp1 = [SELECT StageName FROM Opportunity WHERE id=:opp.Id];
        opp1.StageName = 'Closed Won';
        update opp1;
        Opportunity opp2 = [SELECT CloseDate FROM Opportunity WHERE id=:opp.Id];
        Date result = Date.today();
        System.assertEquals(result,opp2.CloseDate);
    }
    
    @isTest static void testNegative(){
        Opportunity opp = new Opportunity(Name='Opportuity',CloseDate=Date.newInstance(2019,11,05),StageName = 'Prospecting');
        insert opp;
        Opportunity opp1 = [SELECT StageName,Name FROM Opportunity WHERE id=:opp.Id];
        opp1.Name = 'Won';
        update opp1;
        Opportunity opp2 = [SELECT CloseDate FROM Opportunity WHERE id=:opp.Id];
        Date result = Date.newInstance(2019,11,05);
        System.assertEquals(result,opp2.CloseDate);
    }
}