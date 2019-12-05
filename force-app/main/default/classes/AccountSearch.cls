public class AccountSearch {
    public string bilingCity{get;set;}
    public string billingState{get;set;}
    public string billingCountry{get;set;}
    public Integer ResultSize{get;set;}
    public Integer numOfPage{get;set;}
    public String query;
    public AccountSearch() {
        numOfPage = 10;
    }
    public void setbilingCity(String city){
        this.bilingCity = city;
    }
    
    public void setbillingState(String state){
        this.billingState = state ;
    }
    
    public void setbillingCountry(String country){
        this.billingCountry = country ;
    }
    public ApexPages.StandardSetController ssc {
        get {
            if(ssc == null) {
                ssc = new ApexPages.StandardSetController(Database.query(query));
                ssc.setPageSize(numOfPage);  
            }            
            return ssc;
        }
        set;
    }
    
    public void accountSearch(){
        ssc = null;
    }
    
    public List<Account> getResult() {
        query = 'select Name , BillingCity , BillingState ,BillingCountry FROM Account ';
        if(!String.isBlank(bilingCity)||!String.isBlank(billingState)||!String.isBlank(billingCountry)) {
            query+='WHERE' ;
            query+=String.isBlank(bilingCity)?'':' BillingCity LIKE '+'\'%'+bilingCity+'%\''+' AND ';
            query+=String.isBlank(billingState)?'':' BillingState LIKE '+'\'%'+billingState+'%\''+' AND ';
            query+=String.isBlank(billingCountry)?'':' BillingCountry LIKE '+'\'%'+billingCountry+'%\'';
        }
        if(query.endsWith('AND ')) {
            query = query.substring(0, query.length()-4);
        }
        
        ResultSize = ssc.getResultSize();
        return (List<Account>) ssc.getRecords();
    }
}