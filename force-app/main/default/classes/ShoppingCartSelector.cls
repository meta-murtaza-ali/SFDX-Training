public class ShoppingCartSelector  {
    public static List<PurchaseOrder__c> getPurchaseOrderList(){
        return new List<PurchaseOrder__c>([SELECT id,Order_Price__c,Order_Status__c from PurchaseOrder__c]);
    }
    public static List<Product2> getProductListByRecords(List<Product2> productRecord){
        return  new List<Product2>([SELECT Id, Name,ProductCode,Description,price_per_unit__c,quantity_available__c from Product2 WHERE Id IN : productRecord]);
    }
    public static Map<Id,Product2> getProductRecordINMap(){
        return  new Map<Id,Product2>([SELECT Id, Name,ProductCode,Description,price_per_unit__c,quantity_available__c from Product2]);
    }
    public static List<Schema.FieldSetMember> getProductFields(){
        return Schema.SObjectType.Product2.fieldSets.ShoppingCartProductColumns.getFields();
    }
}