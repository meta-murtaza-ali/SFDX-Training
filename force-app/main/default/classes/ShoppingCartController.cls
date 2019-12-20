public class ShoppingCartController {
    public boolean render{get;set;}
    public boolean rendercart{get;set;}
    public boolean renderInvoice{get;set;}
    public Map<Id,boolean> isSelected{get;set;}
    public String SearchProduct{get{return SearchProduct;}set{SearchProduct = value;}}
    public Map<Id, Product2> allProduct{get;set;}
    public Id productId{get;set;}
    public List<Product2> searchProductList{get;set;}
    public Map<Id,Decimal> totalPrice{get;set;}
    public Decimal finalTotal{get;set;}
    public Map<Id,Product2> quantityClone{get;set;}
    public List<PurchaseOrder__c> purchaseOrderList = new List<PurchaseOrder__c>();
    public List<Product2> cartItem{get{
        return shoppingCartService.cartItem;
    }set;}
    public Map<Id,Integer> productQuantity{get;set;}
    public Integer setParam{get;set;}
    ShoppingCartService shoppingCartService;
    public ShoppingCartController(){
        shoppingCartService = new shoppingCartService();
        render=false;
        isSelected = new Map<Id,boolean>();
        rendercart=false;
        productQuantity = new Map<Id,Integer>();
        totalPrice = new Map<Id,Decimal>();
        finalTotal = 0;
        searchProductList = new List<Product2>();
    }
    public static List<Schema.FieldSetMember> getProductFields() {
        return shoppingCartService.getProductFields();
    }
    public void purchaseFirst(){
        shoppingCartService.setCon.first();
    }
    public void purchaseLast(){
        shoppingCartService.setCon.last();
    }
    public void purchaseNext(){
        shoppingCartService.setCon.next();
    }
    public void purchasePrevious(){
        shoppingCartService.setCon.previous();
    }
    public boolean getHasPurchasePrevious(){
        return shoppingCartService.setCon.getHasPrevious();
    }
    public boolean getHasPurchaseNext(){
        return shoppingCartService.setCon.getHasNext();
    }
    public void productFirst(){
        shoppingCartService.setCon1.first();
    }
    public void productLast(){
        shoppingCartService.setCon1.last();
    }
    public void productNext(){
        shoppingCartService.setCon1.next();
    }
    public void productPrevious(){
        shoppingCartService.setCon1.previous();
    }
    public boolean getHasProductPrevious(){
        return shoppingCartService.setCon1.getHasPrevious();
    }
    public boolean getHasProductNext(){
        return shoppingCartService.setCon1.getHasNext();
    }
    
    public List<PurchaseOrder__c> getPurchaseOrder(){
        return shoppingCartService.getPurchaseOrder();
    }
    public void getshowProducts(){
        render=true;
        shoppingCartService.getshowProducts();
        allProduct=shoppingCartService.allProduct;
        quantityClone = allProduct;
        isSelected = shoppingCartService.isSelected;
    }
    
    public List<Product2> getAllProducts(){
       return shoppingCartService.getAllProducts();
    }
    
    public List<Product2> getProducts(){
        return shoppingCartService.getProducts();
    }
    
    public void search(){ 
        shoppingCartService.search(SearchProduct);
    }
    public void storeId(){  
        shoppingCartService.storeId(productId);
        isSelected = shoppingCartService.isSelected;
    }
    public void addItemCart(){
        shoppingCartService.addItemCart();
        rendercart = shoppingCartService.rendercart;
        productQuantity=shoppingCartService.productQuantity;
        isSelected = shoppingCartService.isSelected;
    }
    public void setParam(){
        shoppingCartService.setParam(productId);
        productQuantity=shoppingCartService.productQuantity;
    }
    public void deleteQuant(){
        shoppingCartService.deleteQuant(productId);
        quantityClone = shoppingCartService.quantityClone;
		productQuantity = shoppingCartService.productQuantity;     
        rendercart = shoppingCartService.rendercart;
    }  
    public void inVoice(){
        renderInvoice = true;
        rendercart = false;
        render = false;
        shoppingCartService.inVoice();
        totalPrice = shoppingCartService.totalPrice;
        finalTotal = shoppingCartService.finalTotal;
    }
    public PageReference placeOrder(){     
        renderInvoice = false;
        return shoppingCartService.placeOrder();      
    }
}