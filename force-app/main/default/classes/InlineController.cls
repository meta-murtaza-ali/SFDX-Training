public class InlineController {
	public ID contactId = ApexPages.currentPage().getParameters().get('id');
    public String recordName{get;set;}
    public Contact contactDetail{get;set;}
    public InlineController(ApexPages.StandardController controller){
     contactDetail  = [SELECT Name,RecordTypeId FROM Contact WHERE id=:contactId];
        if(contactDetail.RecordTypeId == '0122v000001SJXmAAO'){
            recordName = 'TGT';
        }else{
            recordName = 'PGT';
        }
    }
    
}