public class ShoppingCartController {
    
    public Integer resultSize{get;set;}
    public boolean render{get;set;}
    public boolean rendercart{get;set;}
    public boolean renderInvoice{get;set;}
    public boolean isSelected{get;set;}
    public String SearchProduct{get;set;}
    public Map<Id, Product2> allProduct;
    public Map<ID,boolean> productNameList = new Map<ID,boolean>();
    public Id productId{get;set;}
    public List<Product2> searchProductList{get;set;}
    public Map<Id,Decimal> totalPrice{get;set;}
    public Decimal finalTotal{get;set;}
    public Integer count=1;
    public List<PurchaseOrder__c> purchaseOrderList = new List<PurchaseOrder__c>();
    public List<Product2> cartItem{get{
        List<Product2> tempList = new List<Product2>();
        for(Id prodId :productQuantity.keySet())
        {
            tempList.add(allProduct.get(prodId));
        }
        
        return tempList;
    }set;}
    public Map<Id,Integer> productQuantity{get;set;}
    public Integer setParam{get;set;}
    public Map<Id,Integer> prevQuant = new Map<Id,Integer>();
    public shoppingCartController(){
        render=false;
		isSelected=false;
        rendercart=false;
        productQuantity = new Map<Id,Integer>();
        totalPrice = new Map<Id,Decimal>();
        finalTotal = 0;
        searchProductList = new List<Product2>();
    }
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT id,Order_Price__c,Order_Status__c from PurchaseOrder__c]));
                setCon.setPageSize(5);  
            }            
            return setCon;
        }
        set;
    }
    
    public ApexPages.StandardSetController setCon1 {
        get { 
            if(setCon1 == null){
                setCon1 = new ApexPages.StandardSetController(getProducts());
                setCon1.setPageSize(10);
            }
            return setCon1;
        }
        set;
    }
    
    public List<PurchaseOrder__c> getpurchaseOrder(){
        resultSize = setCon.getResultSize();
        return (List<PurchaseOrder__c>) setCon.getRecords();
    }
    public void getshowProducts(){
        render=true; 
        allProduct = new Map<Id, Product2>([SELECT Id, Name,ProductCode,Description,price_per_unit__c,quantity_available__c from Product2]); 
    }
    
    public List<Product2> getAllProducts(){
       return (List<Product2>) setCon1.getRecords();
    }
    
    public List<Product2> getProducts(){
        if(searchProductList==null || searchProductList.isEmpty()){
            return allProduct.values();
        }else{
            return  searchProductList;
        }
        
    }
    
    public void search(){ 
		String searchCondition = Apexpages.currentPage().getParameters().get('searchtoVF'); 
        setcon1=null;
        searchProductList.clear();
        if(String.isNotBlank(searchCondition))
        {
            for(Product2 productObj:allProduct.values()){
                if((productObj.Name).containsIgnoreCase(searchCondition)){
                    searchProductList.add(productObj);
                }
            }
        }  
        
    }
    
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    public Boolean hasNextProduct {
        get {
            return setCon1.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
    public Boolean hasPreviousProduct {
        get {
            return setCon1.getHasPrevious();
        }
        set;
    }
    public Boolean hasFirst {
        get{
            return  setCon.getHasPrevious();
        }
        set;
    }
    public Boolean hasFirstProduct {
        get{
            return  setCon1.getHasPrevious();
        }
        set;
    }
    public Boolean hasLast {
        get{
            return  setCon.getHasNext();
        }
        set;
    }
    public Boolean hasLastProduct {
        get{
            return  setCon1.getHasNext();
        }
        set;
    }
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
    public Integer pageNumberProduct {
        get {
            return setCon1.getPageNumber();
        }
        set;
    }
    public void first() {
        setCon.first();
    }
    public void firstProduct() {
        setCon1.first();
    }
    public void last() {
        setCon.last();
    }
    public void lastProduct() {
        setCon1.last();
    }
    public void previous(){
        setcon.previous();
    }
    public void previousProduct(){
        setCon1.previous();
    }
    public void next(){
        setcon.next();
    }
    public void nextProduct(){
        setCon1.next();
    }
    
    public void storeId(){  
        if(productNameList.get(productId) == null) {
            productNameList.put(productId, true);
        } else {
            productNameList.remove(productId);
        }
    }
    
    public void addItemCart(){
        rendercart = true; 
        for(Id productSelcted :productNameList.keySet())
        {
        	if(productQuantity.get(productSelcted)==null && allProduct.get(productSelcted).Quantity_available__c>0)
            {
                productQuantity.put(productSelcted,1);
            }else if(allProduct.get(productSelcted).Quantity_available__c==0){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Item Not Available'));
                 
            }
            else
            {
                productQuantity.put(productSelcted,productQuantity.get(productSelcted) + 1);
            }
            if(allProduct.get(productSelcted).Quantity_available__c>0){
            Product2 tempObj = allProduct.get(productSelcted);
            tempObj.Quantity_available__c = tempObj.Quantity_available__c - 1;
            }
            
        }
        for(Id proId : productQuantity.keySet() ){
            prevQuant.put(proId,productQuantity.get(proId) );
        }
        productNameList.clear();
        
    }
    public void setParam(){
        if(productQuantity.get(productId)<0 || ( productQuantity.get(productId) > ((allProduct.get(productId).Quantity_available__c)+prevQuant.get(productId)))){
            productQuantity.put(productId,prevQuant.get(productId) );
        }else{
            allProduct.get(productId).Quantity_available__c = allProduct.get(productId).Quantity_available__c - (productQuantity.get(productId)-prevQuant.get(productId));
            prevQuant.put(productId, productQuantity.get(productId));
        }
    }
    public void deleteQuant(){     
        allProduct.get(productId).Quantity_available__c = allProduct.get(productId).Quantity_available__c + productQuantity.get(productId);
        productQuantity.remove(productId);
        if(productQuantity.isEmpty()){
            rendercart = false;
        }
    }
    
    
    public void inVoice(){
        renderInvoice = true;
        rendercart = false;
        render = false;
        
        for(Id proId : productQuantity.keySet() ){
            totalPrice.put(proId, ((allProduct.get(proId).price_per_unit__c)*productQuantity.get(proId)));
            finalTotal = finalTotal + totalPrice.get(proId);
        }
    }
    public PageReference placeOrder(){
        for(Id proId: productQuantity.keySet()){
            PurchaseOrder__c purchaseOrder = new PurchaseOrder__c(Name=allProduct.get(proId).Name,Order_Price__c=finalTotal,Order_Status__c='Pending');
            purchaseOrderList.add(purchaseOrder);
        }
        renderInvoice = false;
        insert purchaseOrderList; 
        
        PageReference pr = new PageReference('/apex/ShoppingCart');
        pr.setRedirect(true);
        return pr;
        
    }
}