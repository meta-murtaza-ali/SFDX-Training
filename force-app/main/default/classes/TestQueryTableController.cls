@isTest
public class TestQueryTableController 
{
    @testSetup
    static void testDataSetup()
    {
        List<Account> accountList = new List<Account>();
        for(Integer recordCount = 1; recordCount < 101; recordCount++)
        {
            accountList.add(new Account(Name='Test Account ' + recordCount));
        }
        insert accountList;
    }
    
    @isTest
    static void testSetQueryToBeExecuted()
    {
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Account';
        conObj.setQueryToBeExecuted(testQuery);
        System.assertEquals(testQuery, conObj.getQueryToBeExecuted());
    }
    
    @isTest
    static void testDisplayFieldsIfRecordsFound()
    {        
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Account';
        String sortField = 'Name';
        conObj.setQueryToBeExecuted(testQuery);        
        conObj.setSortBy(sortField);
        conObj.sortByMethod();
        List<sObject> records = (List<sObject>)conObj.getRecordsList();
        List<String> recordsFields = new List<String>(records[0].getPopulatedFieldsAsMap().keySet());
        List<String> fields = new List<String>();
        fields.add('Id');
        fields.add('Name');
        System.assertEquals(fields, recordsFields);
        System.assertEquals(sortField, conObj.getSortBy());                
    }
    
    @isTest
    static void testDisplayFieldsIfRecordsNotFound()
    {
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Account WHERE Name = \'abcd\'';
        String sortField = 'Name';
        conObj.setQueryToBeExecuted(testQuery);
        conObj.setSortBy(sortField);
        List<sObject> records = (List<sObject>)conObj.getRecordsList(); 
        System.assert(records.IsEmpty());
        System.assert(ApexPages.getMessages()[0].getSummary().contains('No records found'));                    
    }
    
    @isTest
    static void testDisplayFieldsIfQueryIsIncorrect()
    {
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Amount WHERE';
        String sortField = 'Name';      
        conObj.setQueryToBeExecuted(testQuery);
        conObj.setSortBy(sortField);
        List<sObject> records = (List<sObject>)conObj.getRecordsList(); 
        System.assertEquals(ApexPages.getMessages()[0].getSummary(), 'unexpected token: \'<EOF>\'');
    }
    
    @isTest
    static void testPageNumber()
    {
        QueryTableController conObj = new QueryTableController();
        String testQuery = 'SELECT Id, Name FROM Account';
        String sortField = 'Name';       	
        conObj.setQueryToBeExecuted(testQuery);
        conObj.setSortBy(sortField);
        List<sobject> records = (List<sobject>)conObj.getRecordsList(); 
        conObj.DesiredPage = 2;
        conObj.jumpToPage();
        System.assertEquals(2, conObj.setCon.getPageNumber());
    }
}