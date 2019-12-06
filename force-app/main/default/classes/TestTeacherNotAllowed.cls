@isTest(Seealldata=false)
private class TestTeacherNotAllowed {
    @isTest static void testTeacherNotAllowed_IfSubjectHindi(){
        Contact newcontact = new Contact(LastName='Murtaza');
        insert newcontact;
        Class__c class1 = new Class__c(Name='PKG', Board__c='RBSE', Fee__c=15000, Custom_Status__c='New',Max_Size__c=5);
        insert class1;
        Teach__c tech = new Teach__c(Teacher__c=newcontact.Id,class__c=class1.Id,Subject__c='Hindi');
        insert tech;
        Contact testcontact = [SELECT LastName FROM Contact WHERE id=:newcontact.Id];
        testcontact.LastName = 'Ali';
        Test.startTest();
        Database.SaveResult result = Database.update(testcontact,false);
        Test.stopTest();
        System.assertEquals(false, result.isSuccess(), 'Record should not be Update');
        System.assertEquals(true,result.getErrors().size()>0);
        System.assertEquals('NOT Allowed.',result.getErrors()[0].getMessage());  
    }
    
        @isTest static void testTeacherNotAllowed_IfSubjectNotHindi(){
        Contact newcontact = new Contact(LastName='Murtaza');
        insert newcontact;
        Class__c class1 = new Class__c(Name='PKG', Board__c='RBSE', Fee__c=15000, Custom_Status__c='New',Max_Size__c=5);
        insert class1;
        Teach__c tech = new Teach__c(Teacher__c=newcontact.Id,class__c=class1.Id,Subject__c='English');
        insert tech;
        Contact testcontact = [SELECT LastName FROM Contact WHERE id=:newcontact.Id];
        testcontact.LastName = 'Ali';
        Test.startTest();
        Database.SaveResult result = Database.update(testcontact,false);
        Test.stopTest();
        System.assertEquals(true, result.isSuccess(), 'Record should  be Update'); 
    }

}