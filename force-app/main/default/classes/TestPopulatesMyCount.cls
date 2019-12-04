@isTest(seealldata=false)
public class TestPopulatesMyCount { 
    @isTest static void testPositiveInsert(){
        Class__c cls1 = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New',Max_Size__c=5);
        insert cls1;
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        insert std1;
        insert std2;
        Class__c testcls = [SELECT My_Count__c FROM Class__c WHERE id=:cls1.Id];
        System.assertEquals(2, testcls.My_Count__c);        
    }
    @isTest static void testPositiveUpdate(){
        Class__c cls1 = new Class__c(Name='PKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New',Max_Size__c=5);
        insert cls1;
        Class__c cls2 = new Class__c(Name='NKG',Board__c='RBSE',Fee__c=15000,Custom_Status__c='New',Max_Size__c=5);
        insert cls2;
        Student__c std1 = new Student__c(Name='Aish',First_Name__c='Aish',Last_Name__c='warya',Date_Of_Birth__c=Date.newInstance(1997, 07, 22),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        Student__c std2 = new Student__c(Name='Arindam',First_Name__c='Arindam',Last_Name__c='ssf',Date_Of_Birth__c=Date.newInstance(1997, 06, 03),Sex__c='FEMALE',Email__c='sfd@cscd.vfd',Class__c=cls1.Id);
        insert std1;
        insert std2;
        Student__c teststd = [SELECT id, class__r.id FROM Student__c WHERE id=:std1.Id];
        teststd.Class__c = cls2.Id;
        Test.startTest();
        Database.SaveResult result=Database.update(teststd);
        Test.stopTest();
        Class__c testcsls = [SELECT My_Count__c FROM Class__c WHERE id=:cls2.Id];
        Class__c clss = [SELECT My_Count__c FROM Class__c WHERE id=:cls1.Id];
        System.assertEquals(1, testcsls.My_Count__c);
        System.assertEquals(1, clss.My_Count__c);
    }
}