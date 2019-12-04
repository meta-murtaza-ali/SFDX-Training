@isTest
public class TestQueryController 
{
    @isTest
	static void testExecuteWhenQueryIsEmpty()
    {
        QueryController conObj = new QueryController();
        conObj.query = '';
        conObj.execute();
        System.assertEquals(false, conObj.showQueryResultsArea, 'Result Area was visible');
    }
    
    @isTest
	static void testExecuteWhenQueryIsNotEmpty()
    {
        QueryController conObj = new QueryController();
        conObj.query = 'SELECT Name FROM Account';
        conObj.execute();
        System.assertEquals(true, conObj.showQueryResultsArea, 'Result Area was visible');
    }
}