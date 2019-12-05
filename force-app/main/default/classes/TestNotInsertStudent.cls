@isTest(Seealldata=false)
private class TestNotInsertStudent {
    @isTest static void testNotInsertStudent_WhenMaxSizeAcchive(){
        Class__c cls = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New',Max_Size__c=1);
        insert cls;
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        insert std1;
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        Test.startTest();
        Database.SaveResult result = Database.insert(std2,false);
        Test.stopTest();
       System.assertEquals(false, result.isSuccess(), 'Record should not be Inserted');
        System.assertEquals(true,result.getErrors().size()>0);
        System.assertEquals('Not Insert Student Because Maximium Limit is Reach.',result.getErrors()[0].getMessage());       
    }
    
    @isTest static void testNotInsertStudent_WhenMaxSizeNotAcchive(){
        Class__c cls = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New',Max_Size__c=5);
        insert cls;
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        insert std1;
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        Test.startTest();
        Database.SaveResult result = Database.insert(std2,false);
        Test.stopTest();
        System.assertEquals(true,result.isSuccess());
    }
}