@isTest(Seealldata=false)
private class TestClassDeletion {
    @isTest static void testClassDeletion_WithFemaleStudents(){
        Class__c cls = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000);
        insert cls;
        List<Student__c> studnt = new List<Student__c>();
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        studnt.add(std1);
        studnt.add(std2);
        insert studnt; 
        Test.startTest();
        Database.DeleteResult result = Database.delete(cls,false);
        Test.stopTest();
        System.assertEquals(true,result.getErrors().size() > 0);
        System.assertEquals('Cannot delete Class Because there are more than 1 Female Student.',
                             result.getErrors()[0].getMessage());
    }
    
    @isTest static void testClassDeletion_WithMaleStudents(){
        Class__c cls = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000);
        insert cls;
        List<Student__c> studnt = new List<Student__c>();
        Student__c std1 = new Student__c(Name='Abhi',First_Name__c='Abhi',Last_Name__c='shek',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='MALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        Student__c std2 = new Student__c(Name='Naman',First_Name__c='Naman',Last_Name__c='vijay',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='MALE',Email__c='sfd@cscd.vfd',Class__c=cls.Id);
        studnt.add(std1);
        studnt.add(std2);
        insert studnt; 
        Test.startTest();
        Database.DeleteResult result = Database.delete(cls,false);
        Test.stopTest();
        System.assertEquals(true, result.isSuccess(), 'Record should  be Deleted');
    }
}