public class ShoppingCartController {
    public boolean render{get;set;}
    public boolean rendercart{get;set;}
    public boolean renderInvoice{get;set;}
    public Map<Id,boolean> isSelected{get;set;}
    public String SearchProduct{get{return SearchProduct;}set{SearchProduct = value;}}
    public Map<Id, Product2> allProduct;
    public Map<ID,boolean> productNameList{get;set;}
    public Id productId{get;set;}
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
    public ShoppingCartController(){
        render=false;
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
                setCon1 = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id, Name,ProductCode,Description,price_per_unit__c,quantity_available__c from Product2 WHERE Id IN : getProducts()]));
                setCon1.setPageSize(10);
            }
            return setCon1;
        }
        set;
    }
    
    public List<PurchaseOrder__c> getPurchaseOrder(){
        return (List<PurchaseOrder__c>) setCon.getRecords();
    }
    public void getshowProducts(){
        render=true; 
        allProduct = new Map<Id, Product2>([SELECT Id, Name,ProductCode,Description,price_per_unit__c,quantity_available__c from Product2]);
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
    
    public void search(){ 
        setcon1=null;
        searchProductList = new List<Product2>();
        if(String.isNotBlank(SearchProduct))
        {
            for(Product2 productObj:allProduct.values()){
                if((productObj.Name).containsIgnoreCase(SearchProduct)){
                    searchProductList.add(productObj);
                }
            }
        }  
        
    }
    public void storeId(){  
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
    public void setParam(){
        if(productQuantity.get(productId)<0 || ( productQuantity.get(productId) > ((quantityClone.get(productId).Quantity_available__c)+prevQuant.get(productId)))){
            productQuantity.put(productId,prevQuant.get(productId) );
        }else{
            quantityClone.get(productId).Quantity_available__c = quantityClone.get(productId).Quantity_available__c - (productQuantity.get(productId)-prevQuant.get(productId));
            prevQuant.put(productId, productQuantity.get(productId));
        }
    }
    public void deleteQuant(){     
        quantityClone.get(productId).Quantity_available__c = quantityClone.get(productId).Quantity_available__c + productQuantity.get(productId);
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