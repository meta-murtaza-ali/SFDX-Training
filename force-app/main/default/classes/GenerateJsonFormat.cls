public with sharing class GenerateJsonFormat {
    public String jsonString{get;set;}
    public GenerateJsonFormat(){
        jsonString = getJsonStringFormat();
    }
    public String getJsonStringFormat(){
        List<Account> accountRecord = [SELECT id,Name FROM Account];
        return Json.serialize(accountRecord);
    }
}