public without sharing class RTModifyController extends RTController{ 

	public list<selectOption> prodList {get;set;}
	public Map<String,Id> revenueTypeMap {get;set;}
	 Revenue_Type__c modifyRT;
	public RTModifyController(ApexPages.StandardController controller)
	{ 
		modifyRT = (Revenue_Type__c)controller.getRecord();
		init();
	}
	
	public RTModifyController()
	{ 
		init();
	}
	public void init()
	{
		fetchValues();
		prodList = new list<selectOption>();
       
       Map<Id, Product2> productMap = new Map<Id, Product2>();
       for(Revenue_Type__c rt: rtMap.values())
       {
       		productMap.put(rt.Product__c, rt.Product__r);
       		if(modifyRT!=null && modifyRT.Id==rt.Id)
       			rtObject.Product__c = rt.Product__c;
       }
       
       if(rtMap.size()>0){
	       for(Product2 p: productMap.values()){	       	   
	       		SelectOption Option = new selectOption(p.Id,p.Name); 
	       		prodList.add(Option); 
	       }
       }
	}
	//Called to populate default values on click of modify button
    public void populateDefaultValuesForModify()
 	{	
 		if(rtMap.size() > 0){
	 		List<Revenue_Type__c> revList = rtMap.values();
	 		revenueTypeMap = new Map<String,Id>();
	 		Integer amount=0;
	 		if(revList!=null & revList.size() > 0){
	 			for(Revenue_Type__c rt:revList){
	 				if(rt.Product__c == prodList[0].getValue()){		
	 						rtObject.Product_Family__c = rt.Product_Family__c;
	 						productName = rt.Product__r.Name; 
	 						revenueTypeMap.put(rt.Revenue_Type__c,rt.id);
	 						if('License'.equals(rt.Revenue_Type__c))
			 				{
			 					rtObject.License_Type__c = rt.License_Type__c;	 				
			 					license = String.valueOf(rt.Amount__c);
				 			}
				 			if('Support'.equals(rt.Revenue_Type__c)){
				 				rtObject.Support_Type__c = rt.Support_Type__c;		 				
				 				support = String.valueOf(rt.Amount__c);
				 			}
				 			if('Professional Services'.equals(rt.Revenue_Type__c))		 					 				
				 				professionalServices = String.valueOf(rt.Amount__c);
				 			
				 			if('Custom Development'.equals(rt.Revenue_Type__c))		 				
				 				customDevelopment = String.valueOf(rt.Amount__c);
				 			
				 			if('3rd Party'.equals(rt.Revenue_Type__c))		 				
				 				thirdParty = String.valueOf(rt.Amount__c);
				 						 			
				 			if('3rd Party VAS'.equals(rt.Revenue_Type__c))		 				
				 				thirdPartyVAS = String.valueOf(rt.Amount__c);	
	 					}
	 			}
		 		
	 		}
	 		fetchValues();
	 		getDefaultValues();
	 		goCalculateCurrentBookValueModify(false);
 		}
 		else{
 			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please add products to modify'));
			return;
 		}	
 	}
 	//Method to reset properties
 	private void initializeAll(){
 		initializeAmounts();
	    rtObject = new Revenue_Type__c(); 
	}
 	private void initializeAmounts(){
 		license ='';
 		professionalServices ='';
 		customDevelopment ='';
	    thirdParty = '';
	    thirdPartyVAS = '';
	    support = ''; 
	}
	
 	 //Method to save the records and return the control back to Add Reveune form to add more products
 	public PageReference goSaveAndAddProduct()
 	{
		goSaveModify();
		initializeAll();
 		return new Pagereference('/apex/addrevenuetype?oppid=' + opportunity.Id); 
 	}
 	
 	public PageReference goSaveModify()
 	{	
 		if(!validate())
 			return null;
 		
 		goCalculateCurrentBookValueModify();
 			
 		deleteExistingRevenueTypes();
 		
 		List<Revenue_Type__c> rtList = createRevenueTypeModify();
 		System.debug('\n\nMODIFY RT EXISTING: ' + rtMap);
 		System.debug('\n\nMODIFY RT CREATED: ' + rtList);
 		for(Revenue_Type__c rt: rtList)
 		{
 			rtMap.put(rt.Id, rt);
 		} 		
 		
 		goSave(rtMap.values());	
 		
 		return new PageReference('/' + opportunity.Id);
 	}
 	
 	//Called when a product is selected from lookup. The Product and Family fields a re rendered and used to populate the family of the product selected.
    public pagereference populateProductFamily()
    {    	
    	if(rtMap.size()>0){
	       for(Revenue_Type__c rt: rtMap.values()){	       	   
	       		if(rt.Product__c==rtObject.Product__c)
	       		 {
	       		 	rtObject.Product_Family__c = rt.Product_Family__c;
	       		 	rtObject.Product_Type__c = rt.Product_Type__c;
    				productName = rt.Product__r.Name;
	       		 }
	       }
       	}
    	
    	if(rtObject!=null && rtObject.Product__c!=null)
    		{
    			Product2 prod = [Select id,name,Product_Type__c,Family,isActive from Product2 where Id=: rtObject.Product__c];
    			rtObject.Product_Family__c = prod.Family;
    			rtObject.Product_Type__c = prod.Product_Type__c;
    			productName = prod.name;
    		}
    	
    	
    	List<Revenue_Type__c> revList = new List<Revenue_Type__c>();
 		revenueTypeMap = new Map<String,Id>();
 		initializeAmounts();
 		rtObject.License_Type__c = null;
 		rtObject.Support_Type__c = null;
 		//revList = [Select Product__c, Id,Support_Type__c, Amount__c,License_Type__c,Revenue_Type__c From Revenue_Type__c where Product__c =: rtObject.Product__c and Opportunity__c =: ApexPages.currentPage().getParameters().get('id')];
 		if(rtMap.size() > 0)
 		{
 			for(Revenue_Type__c rt: rtMap.values())
 				{
 					if(rt.Product__c==rtObject.Product__c)
 					{
	 					revenueTypeMap.put(rt.Revenue_Type__c,rt.id); 				
		 				if('License'.equals(rt.Revenue_Type__c))
		 				{
		 					rtObject.License_Type__c = rt.License_Type__c;	 				
		 					license = String.valueOf(rt.Amount__c);
			 			}
			 			if('Support'.equals(rt.Revenue_Type__c)){
			 				rtObject.Support_Type__c = rt.Support_Type__c;		 				
			 				support = String.valueOf(rt.Amount__c);
			 			}
			 			if('Professional Services'.equals(rt.Revenue_Type__c))		 					 				
			 				professionalServices = String.valueOf(rt.Amount__c);
			 			
			 			if('Custom Development'.equals(rt.Revenue_Type__c))		 				
			 				customDevelopment = String.valueOf(rt.Amount__c);
			 			
			 			if('3rd Party'.equals(rt.Revenue_Type__c))		 				
			 				thirdParty = String.valueOf(rt.Amount__c);
			 						 			
			 			if('3rd Party VAS'.equals(rt.Revenue_Type__c))		 				
			 				thirdPartyVAS = String.valueOf(rt.Amount__c);
 					}
	 				
 			}
	 		
 		}
 		
 		fetchValues();
 		getDefaultValues();
    	goCalculateCurrentBookValueModify();
      	return null;
    }
 	
 	//Method to create Revenue Type Records
 	public List<Revenue_Type__c> createRevenueTypeModify()
 	{	
			System.debug('\n\nCREATING RTTT: ' + revenueTypeMap);
			List<Revenue_Type__c> rtList = new List<Revenue_Type__c>();
 		
 	 		if(RevenueTypeUtility.hasValue(license)){ 
	 				rtList.add(buildRevenueType('License', revenueTypeMap.get('License'),Decimal.valueOf(license), true, false));
 	 		}
 	 		if(RevenueTypeUtility.hasValue(professionalServices)){ 
 	 				rtList.add(buildRevenueType('Professional Services',revenueTypeMap.get('Professional Services'),Decimal.valueOf(professionalServices), false, false));
 	 		}
 	 		if(RevenueTypeUtility.hasValue(customDevelopment)){ 
	 				rtList.add(buildRevenueType('Custom Development', revenueTypeMap.get('Custom Development'),Decimal.valueOf(customDevelopment), true, false));
 	 		}
 	 		if(RevenueTypeUtility.hasValue(thirdParty)){ 
	 				rtList.add(buildRevenueType('3rd Party', revenueTypeMap.get('3rd Party'),Decimal.valueOf(thirdParty), true, false));
 	 		}
 	 		if(RevenueTypeUtility.hasValue(thirdPartyVAS)){ 
	 				rtList.add(buildRevenueType('3rd Party VAS', revenueTypeMap.get('3rd Party VAS'),Decimal.valueOf(thirdPartyVAS), true, false));
 	 		}
 	 		if(RevenueTypeUtility.hasValue(support)){ 
	 				rtList.add(buildRevenueType('Support', revenueTypeMap.get('Support'),Decimal.valueOf(support), true, false));
 	 		}
 	 	System.debug('\n\nRTLIS: ' + rtList);
 		if(rtList.size() > 0)
 			{		
 					upsert rtList;
 			} 		
 		return rtList;	
 	}
 	private void deleteExistingRevenueTypes()
 	{
 		List<Revenue_Type__c> rtList = new List<Revenue_Type__c>();
 		if(rtMap.size() > 0)
 		{
 			for(Revenue_Type__c rt: rtMap.values())
 				{
 					if(rt.Product__c==rtObject.Product__c)
 					{
		 				if(('License'.equals(rt.Revenue_Type__c) && !RevenueTypeUtility.hasValue(license)) ||
		 				('Support'.equals(rt.Revenue_Type__c) && !RevenueTypeUtility.hasValue(support)) ||
			 			('Professional Services'.equals(rt.Revenue_Type__c) && !RevenueTypeUtility.hasValue(professionalServices)) ||		 					 				
			 			('Custom Development'.equals(rt.Revenue_Type__c) && !RevenueTypeUtility.hasValue(customDevelopment)) ||		 				
			 			('3rd Party'.equals(rt.Revenue_Type__c) && !RevenueTypeUtility.hasValue(thirdParty)) ||		 				
			 			('3rd Party VAS'.equals(rt.Revenue_Type__c) && !RevenueTypeUtility.hasValue(thirdPartyVAS)))		 				
			 				{
		 						rtList.add(rt);
		 						rtMap.remove(rt.Id); 
		 					}
 					}
	 				
 			}
 		if(rtList.size() > 0)
 			delete rtList;	
 		}
 	}
 	
 	public PageReference goCalculateCurrentBookValueModify()
 	{
 		return goCalculateCurrentBookValueModify(true);
 	}
 	public PageReference goCalculateCurrentBookValueModify(boolean callValidate)
 	{
 		goCalculateCurrentBookValue(callValidate);
 		System.debug('\n\nMODAMOUNT: ' + tOpportunity.Amount);
 		
 		String selectedProduct = rtObject.Product__c;
 		if(selectedProduct==null)
 			selectedProduct = prodList[0].getValue(); 
 		 System.debug('\n\nSELECTED PRO: ' + selectedProduct);
 		 System.debug('\n\nOPP AMNT: ' + tOpportunity.Amount);
 		 for(Revenue_Type__c rt: rtMap.values())
	       {
	       		if(rt.Product__c == selectedProduct && rt.Amount__c!=null)
	       		{
	       			System.debug('\n\nAMNT DED: ' + rt.Amount__c);
	       			tOpportunity.Amount = tOpportunity.Amount - rt.Amount__c;
	       		}
	       }
 		System.debug('\n\nTAMOUNT: ' + tOpportunity.Amount);
 		return null;
 	}
}