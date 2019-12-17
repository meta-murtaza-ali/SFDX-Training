public class ShoppingCartService {
    public boolean rendercart{get;set;}
    public Map<Id,boolean> isSelected{get;set;}
    public Map<Id, Product2> allProduct;
    public Map<ID,boolean> productNameList{get;set;}
    public List<Product2> searchProductList{get;set;}
    public Map<Id,Decimal> totalPrice{get;set;}
    public Decimal finalTotal{get;set;}
    public Map<Id,Product2> quantityClone{get;set;}
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
    public ShoppingCartService(){
        isSelected = new Map<Id,boolean>();
        rendercart=false;
        productQuantity = new Map<Id,Integer>();
        totalPrice = new Map<Id,Decimal>();
        finalTotal = 0;
        searchProductList = new List<Product2>();
        productNameList = new Map<ID,boolean>();
    }
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(ShoppingCartSelector.getPurchaseOrderList());
                setCon.setPageSize(5);  
            } 
            return setCon;
        }
        set;
    }
    
    public ApexPages.StandardSetController setCon1 {
        get { 
            if(setCon1 == null){
                setCon1 = new ApexPages.StandardSetController(ShoppingCartSelector.getProductListByRecords(getProducts()));
                setCon1.setPageSize(10);
            }
            return setCon1;
        }
        set;
    }
    public static List<Schema.FieldSetMember> getProductFields() {
        return ShoppingCartSelector.getProductFields();
    }
    public List<PurchaseOrder__c> getPurchaseOrder(){
        return (List<PurchaseOrder__c>) setCon.getRecords();
    }
    public void getshowProducts(){
        allProduct = ShoppingCartSelector.getProductRecordINMap();
        quantityClone = allProduct;
        for(Product2 proObj : allProduct.values()){
            isSelected.put(proObj.Id, false);
        }
    }
    
    public List<Product2> getAllProducts(){
       return (List<Product2>) setcon1.getRecords();
    }
    
    public List<Product2> getProducts(){
        if(searchProductList.isEmpty()){
            return allProduct.values();
        }else{
            return  searchProductList;
        }
        
    }
    
    public void search(String SearchProducts){ 
        setcon1=null;
        searchProductList = new List<Product2>();
        if(String.isNotBlank(SearchProducts))
        {
            for(Product2 productObj:allProduct.values()){
                if((productObj.Name).containsIgnoreCase(SearchProducts)){
                    searchProductList.add(productObj);
                }
            }
        }  
        
    }
    public void storeId(Id productId){  
        if(productNameList.get(productId) == null) {
            productNameList.put(productId, true);
            isSelected.put(productId,true);
        } else {
            productNameList.remove(productId);
            isSelected.put(productId,false);
        }
    }
    public void addItemCart(){
        
        if(!productNameList.isEmpty()){
        	rendercart = true;
        }
        for(Id productSelcted :productNameList.keySet())
        {
            isSelected.put(productSelcted,false);
        	if(productQuantity.get(productSelcted)==null && quantityClone.get(productSelcted).Quantity_available__c>0)
            {
                productQuantity.put(productSelcted,1);
            }else if(quantityClone.get(productSelcted).Quantity_available__c==0){
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Item Not Available'));
                 
            }
            else if(productQuantity.get(productSelcted)!=null)
            {
                productQuantity.put(productSelcted,productQuantity.get(productSelcted) + 1);
            }
            if(quantityClone.get(productSelcted).Quantity_available__c>0){
            Product2 tempObj = quantityClone.get(productSelcted);
            tempObj.Quantity_available__c = tempObj.Quantity_available__c - 1;
            }          
        }
        for(Id proId : productQuantity.keySet() ){
            prevQuant.put(proId,productQuantity.get(proId) );
        }
        productNameList = new Map<ID,boolean>();
    }
    public void setParam(Id productId){
        if(productQuantity.get(productId)<0 || ( productQuantity.get(productId) > ((quantityClone.get(productId).Quantity_available__c)+prevQuant.get(productId)))){
            productQuantity.put(productId,prevQuant.get(productId) );
        }else{
            quantityClone.get(productId).Quantity_available__c = quantityClone.get(productId).Quantity_available__c - (productQuantity.get(productId)-prevQuant.get(productId));
            prevQuant.put(productId, productQuantity.get(productId));
        }
    }
    public void deleteQuant(Id productId){     
        quantityClone.get(productId).Quantity_available__c = quantityClone.get(productId).Quantity_available__c + productQuantity.get(productId);
        productQuantity.remove(productId);
        if(productQuantity.isEmpty()){
            rendercart = false;
        }
    }  
    public void inVoice(){
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
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[]{PurchaseOrder__c.SObjectType});
        uow.registerNew(purchaseOrderList);
        uow.commitWork();
        PageReference pr = new PageReference('/apex/ShoppingCart');
        pr.setRedirect(true);
        return pr;      
    }
}