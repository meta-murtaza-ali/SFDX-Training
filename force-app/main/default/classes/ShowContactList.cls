public class ShowContactList {
    public string Id{get;set;}
    public List<Contact> conList{get;set;}
    public String contctRecord = null;
    
    public List<SelectOption> getItems(){
        List<SelectOption> option = new List<SelectOption>();
        Id = ApexPages.currentPage().getParameters().get('id');
        conList = [SELECT id,Name FROM Contact WHERE AccountId IN (SELECT Manager__c FROM Opportunity WHERE id=:Id)];
        for(Contact cntct:conList){
            option.add(new SelectOption(cntct.Id,cntct.Name));
        }
        
        return option;
    }
    public PageReference Save(){
        Opportunity oppObj = [SELECT BillToContact__c FROM Opportunity WHERE id=:Id ];
        oppObj.BillToContact__c = contctRecord;
        update oppObj;
        PageReference pgeredirect = new PageReference('/'+Id);
        pgeredirect.setRedirect(true);
        return pgeredirect;
    }
    
    public PageReference Cancel(){
        PageReference pgeredirect = new PageReference('/'+Id);
        pgeredirect.setRedirect(true);
        return pgeredirect;
    }
    
    public PageReference Clear(){
        Opportunity oppObj = [SELECT BillToContact__c FROM Opportunity WHERE id=:Id ];
        oppObj.BillToContact__c = null;
        update oppObj;
        PageReference pgeredirect = new PageReference('/'+Id);
        pgeredirect.setRedirect(true);
        return pgeredirect; 
        
    }
    
    
    public String getContctRecord(){
        return contctRecord;
    }
    public void setContctRecord(String contctRecord){
        this.contctRecord = contctRecord;
    }
    
}