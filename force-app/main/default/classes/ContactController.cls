public with sharing class ContactController {
	@AuraEnabled
    public static Contact saveContact(Contact saveContact){
        try{
        upsert saveContact;
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
        return saveContact;
    }
}