public class AccountSearch {
    public string bilingCity{get;set;}
    public string billingState{get;set;}
    public string billingCountry{get;set;}
    public List<Account> result{get;set;}
    public Integer numOfPage{get;set;}
    public Integer PageNumber{get;set;}
    public Integer ResultSize{get;set;}
    public Integer PageSize{get;set;}
    public boolean HasPrevious{get;set;}
    public boolean HasNext{get;set;}
    public ApexPages.StandardSetController ssc{get;set;}
    public AccountSearch(){
        result = [SELECT Name,BillingCity,BillingState,BillingCountry FROM Account];
        ssc = new ApexPages.StandardSetController(result);
        ssc.setPageSize(10);
    }
    public void accountSearch(){
        result = [SELECT Name,BillingCity,BillingState,BillingCountry FROM Account WHERE BillingCity=:bilingCity AND BillingState=:billingState AND BillingCountry=:billingCountry ];
       ssc = new ApexPages.StandardSetController(result);
        ssc.setPageSize(numOfPage);
        PageNumber = ssc.getPageNumber();
        ResultSize = ssc.getResultSize();
        PageSize = ssc.getPageSize();
        HasPrevious = ssc.getHasPrevious();
        HasNext = ssc.getHasNext();
    }
}