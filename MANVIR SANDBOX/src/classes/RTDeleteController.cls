public without sharing class RTDeleteController extends RTController {
	
	//Delete Revenue Type
   public list<selectOption> prodList {get;set;}
   public String selectedProduct {get;set;}
   public Id selectedProdForModify {get;set;}
   public List<Product2> productNames{get;set;}
   public Map<String,Id> revenueTypeMap {get;set;}
   Revenue_Type__c deleteRT;
   
   public RTDeleteController(ApexPages.StandardController controller)
   {
   	
   	 deleteRT = (Revenue_Type__c)controller.getRecord(); 
   	 init();   	 
   }
  
   public RTDeleteController()
   {
   	 init();
   }
   
   public boolean hasProducts
   {
   		get
   		{
   			if(prodList!=null && prodList.size()>0)
   				return true;
   			else
   				return false;	
   		}
   }
   
   public void init()
   {
   	 fetchValues();
    	prodList = new list<selectOption>();
      System.debug('\n\nDELRT: ' + deleteRT);
       Map<Id, Product2> productMap = new Map<Id, Product2>();
       if(rtMap.size() > 0){
	       for(Revenue_Type__c rt: rtMap.values())
	       {
	       		productMap.put(rt.Product__c, rt.Product__r);
	       		if(deleteRT!=null && deleteRT.Id==rt.Id)
	       			rtObject.Product__c = rt.Product__c;
	       }
	      System.debug('\n\nSEL: ' + selectedProduct); 
	       if(rtMap.size()>0){
		       for(Product2 p: productMap.values()){	       	   
		       		SelectOption Option = new selectOption(p.Id,p.Name); 
		       		prodList.add(Option); 
		       }
	       }
	       System.debug('\n\nOUT ' + selectedProduct); 
   		}
   			
   }
      	
	//Called when a product is selected from menu. Revenue Types and Revenue Recognition Records related to the slected product should be deleted.
    public pageReference deleteRevTypes(){
    	List<Revenue_Type__c> rtList = new List<Revenue_Type__c>();
    	
    	Decimal oppamt = 0;
    	
    	for(Revenue_Type__c r: rtMap.values())
    	{
    		if(r.Product__c==selectedProduct)
    			{
    				rtList.add(r);
    				rtMap.remove(r.Id);
    			}
    		else
    			oppamt = oppamt + r.Amount__c;	
    	}
    	
    	//Delete the selected Revenue Type record, trigger will delete the related RR records.
    	if(rtList.size() > 0){
    		delete rtList;
    	}
    	
    	//Before creating new ones, delete the existing RR records for all other Revenue Types
    	goDeleteRevenueRecog();
    	
    	createRR(rtMap.values());	
    	
    	
    	opportunity.Close_Date_Validation__c = String.valueOf(System.now().getTime());
    	opportunity.Amount = oppamt;
    	
    	Database.DMLOptions dmo = new Database.DMLOptions();
		dmo.allowFieldTruncation = true;
		opportunity.setOptions(dmo);
		update opportunity; 
    	
    	return new Pagereference('/'+opportunity.id);
	}
	
	
}