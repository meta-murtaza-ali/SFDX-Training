@isTest
public class TestShoppingCartController {
    @isTest static void testGetPurchaseOrder(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        PurchaseOrder__c purchaseOrder = new PurchaseOrder__c(Name='watch',Order_Price__c=20,Order_Status__c='Pending');
        insert purchaseOrder;
        List<PurchaseOrder__c> purchaseOrderList = testShoppingObj.getpurchaseOrder();
        PurchaseOrder__c purchaseorderObj = [SELECT Name FROM PurchaseOrder__c WHERE Id IN :purchaseOrderList ];
        System.assertEquals('watch',purchaseorderObj.Name );
        
    } 
    
    @isTest static void testGetAllProducts(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=6);
        insert testProduct;
        testShoppingObj.getshowProducts();
        boolean hasFirstProduct=testShoppingObj.hasFirstProduct;
        boolean hasNextProduct=testShoppingObj.hasNextProduct;
        boolean hasPreviousProduct = testShoppingObj.hasPreviousProduct;
        List<Product2> productList = testShoppingObj.getAllProducts();
        Product2 productObj = [SELECT Name FROM Product2 WHERE Id IN : productList];
        System.assertEquals('Home',productObj.Name);
    }
    
    @isTest static void testGetSearchProducts(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        PageReference pageRef = Page.ShoppingCart;
        Test.setCurrentPage(pageRef);
      
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=6);
        insert testProduct;
        testShoppingObj.allProduct = new Map<Id, Product2>{testProduct.id => testProduct};
        ApexPages.currentPage().getParameters().put('searchtoVF', 'Home');
        testShoppingObj.search();
        List<Product2> productList = testShoppingObj.getProducts();
        System.assertEquals('Home',productList[0].Name);
    }
    
    @isTest static void testStoreId(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=6);
        insert testProduct;
        testShoppingObj.productId = testProduct.Id;
        testShoppingObj.storeId();
        System.assert(testShoppingObj.productNameList.get(testProduct.Id));
        testShoppingObj.storeId();
        System.assertEquals(null, testShoppingObj.productNameList.get(testProduct.Id));
    }
    
    @isTest static void testDeleteItemFromCart(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=4);
        insert testProduct;
        testShoppingObj.getshowProducts();
        testShoppingObj.productId = testProduct.Id;
        testShoppingObj.productQuantity.put(testProduct.Id,2);
        testShoppingObj.deleteQuant();
        System.assertEquals(6,(testShoppingObj.allProduct.get(testProduct.id)).Quantity_available__c);
        System.assertEquals(null, testShoppingObj.productQuantity.get(testProduct.id));
    }
    
    @isTest static void testTotalAndFinalPrice(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=4);
        insert testProduct;
        testShoppingObj.getshowProducts();
        testShoppingObj.productQuantity.put(testProduct.Id,2);
        testShoppingObj.inVoice();
        System.assertEquals(24, testShoppingObj.totalPrice.get(testProduct.id));
        System.assertEquals(24,testShoppingObj.finalTotal );
    }
    
    @isTest static void testPlaceOrder(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=4);
        insert testProduct;
        testShoppingObj.getshowProducts();
        testShoppingObj.productQuantity.put(testProduct.Id,2);
        testShoppingObj.inVoice();
        testShoppingObj.placeOrder();
        PurchaseOrder__c testPurchaseOrderObj = [SELECT Name FROM PurchaseOrder__c];
        System.assertEquals('Home', testPurchaseOrderObj.Name);
    }
    
    @isTest static void testAddItemCart(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=4);
        insert testProduct;
        testShoppingObj.productNameList.put(testProduct.id,true);
        testShoppingObj.getshowProducts();
        testShoppingObj.addItemCart();
        System.assertEquals(1,testShoppingObj.productQuantity.get(testProduct.id));
        System.assertEquals(3,testShoppingObj.allProduct.get(testProduct.id).Quantity_available__c);
        System.assertEquals(1,testShoppingObj.prevQuant.get(testProduct.id));
        testShoppingObj.productNameList.put(testProduct.id,true);
        testShoppingObj.addItemCart();
        System.assertEquals(2,testShoppingObj.productQuantity.get(testProduct.id));
        System.assertEquals(2,testShoppingObj.allProduct.get(testProduct.id).Quantity_available__c);
        System.assertEquals(2,testShoppingObj.prevQuant.get(testProduct.id)); 
    }
    
    @isTest static void testCartItem(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=4);
        insert testProduct;
        testShoppingObj.getshowProducts();
        testShoppingObj.productQuantity.put(testProduct.Id,2);
        List<Product2> productObjList = testShoppingObj.cartItem;
        System.assertEquals(1,productObjList.size() );
    }
    
    @isTest static void testSetQuantity(){
        shoppingCartController testShoppingObj = new shoppingCartController();
        Product2 testProduct = new Product2(Name = 'Home',ProductCode='123',Price_Per_Unit__c=12,Quantity_available__c=4);
        insert testProduct;
        testShoppingObj.productId = testProduct.Id;
        testShoppingObj.getshowProducts();
        testShoppingObj.productQuantity.put(testProduct.Id,-1);
        testShoppingObj.prevQuant.put(testProduct.id,2);
        testShoppingObj.setParam();
        System.assertEquals(2,testShoppingObj.productQuantity.get(testProduct.Id));
        testShoppingObj.productQuantity.put(testProduct.Id,1);
        testShoppingObj.setParam();
        System.assertEquals(1,testShoppingObj.prevQuant.get(testProduct.Id));
    }
}