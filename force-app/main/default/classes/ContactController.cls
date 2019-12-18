public with sharing class ContactController {
	@AuraEnabled
    public static Contact saveContact(Contact record){
        System.debug(record);

        try{
        upsert record;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        return record;
    }
}