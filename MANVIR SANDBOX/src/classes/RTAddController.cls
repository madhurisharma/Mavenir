public without sharing class RTAddController extends RTController{ 
	
	boolean isActiveProduct = true;
	boolean isOnlySupport = false;
	
	//Called when a product is selected from lookup. The Product and Family fields a re rendered and used to populate the family of the product selected.
    public pagereference populateProductFamily()
    {
    	System.debug('----rtObject----'+rtObject);
    	if(rtObject!=null && rtObject.Product__c!=null)
    		{
    			
    			Product2 prod = [Select id,name,Product_Type__c,Family,isActive from Product2 where Id=: rtObject.Product__c];
    			rtObject.Product_Family__c = prod.Family;
    			rtObject.Product_Type__c = prod.Product_Type__c;
    			productName = prod.name;
    			isActiveProduct = prod.isActive;
    			//rtObject.Product_Family__c = [Select Family from Product2 where Id=: rtObject.Product__c].Family;
    		}
    	    	
    	return null;
    }
    public boolean productExists()
    {
    	if(opportunity.Revenue_Type__r!=null)
    	{
    		for(Revenue_Type__c r: opportunity.Revenue_Type__r)
    		{
    			if(r.Product__c==rtObject.Product__c)
    				return true;
    		}
    	}
    	return false;
    }
    public boolean validateAdd()
 	{
 		
 		boolean valid = validate();
 		if(productExists())
 			{
 			   	rtObject.Product__c.addError('Product already exists');
    		   	valid = false;
 			}
 			if(!isActiveProduct)
 			{
 			   	rtObject.Product__c.addError('Please select an active Product from the Lookup');
    		   	valid = false;
 			}	 				 		
 			
 		return valid;
 	}
 	
 	//Method to reset properties
 	private void initialVariables(){
 		license ='';
 		professionalServices ='';
 		customDevelopment ='';
	    thirdParty = '';
	    thirdPartyVAS = '';
	    support = '';
	    rtObject.Product__c = null;
	    rtObject.Support_Type__c = null;
	    rtObject.License_Type__c = null;
	    rtObject.Product_Family__c = null;
	}
 	 //Method to save the records and return the control back to Add Reveune form to add more products
 	public PageReference goSaveAndAddProduct()
 	{
 		system.debug('----goSaveAndAddProduct----');
		goSaveAdd();
		initialVariables();
 		return new Pagereference('/apex/addrevenuetype?oppid=' + opportunity.id);
 	}
 	
 	public PageReference goSaveAdd()
 	{
 		
 		if(!validateAdd())
 			return null;
 		
 		//get the list created in this session
 		List<Revenue_Type__c> rtList = createRevenueTypeAdd();
 		//add it to the rtmap with all other existing RTs in the opportunity
 		for(Revenue_Type__c rt: rtList)
 		{
 			rtMap.put(rt.Id, rt);
 		}
 		System.debug('----rtmap-----'+rtMap);
		//pass on all the RTs - existing and new to save
		goCalculateOppAmount();
 		goSave(rtMap.values());	 
 		return new PageReference('/' + opportunity.Id);
 	}
 	//Method to create Revenue Type Records
 	public List<Revenue_Type__c> createRevenueTypeAdd()
 	{	
			List<Revenue_Type__c> revTypeRecords = new List<Revenue_Type__c>();
			 		
 			if(RevenueTypeUtility.hasValue(license))
 				revTypeRecords.add(buildRevenueType('License',null, Decimal.valueOf(license), true, false));
 			if(RevenueTypeUtility.hasValue(professionalServices))
	 			revTypeRecords.add(buildRevenueType('Professional Services', null,Decimal.valueOf(professionalServices), false, false));	 		
	 		if(RevenueTypeUtility.hasValue(customDevelopment))
	 			revTypeRecords.add(buildRevenueType('Custom Development',null, Decimal.valueOf(customDevelopment), false, false));
	 		if(RevenueTypeUtility.hasValue(thirdParty))
	 			revTypeRecords.add(buildRevenueType('3rd Party',null, Decimal.valueOf(thirdParty), false, false));
	 		if(RevenueTypeUtility.hasValue(thirdPartyVAS))
	 			revTypeRecords.add(buildRevenueType('3rd Party VAS',null, Decimal.valueOf(thirdPartyVAS), false, false));
	 		if(RevenueTypeUtility.hasValue(support))
	 			revTypeRecords.add(buildRevenueType('Support',null, Decimal.valueOf(support), false, true));
	 		
	 		if(revTypeRecords.size() > 0)
 					upsert revTypeRecords;
 		
 			return revTypeRecords;
 	
 	}
 	 //Called to populate default values on click of modify button
    public void addAction() 
 	{
 		fetchValues();
 		goCalculateOppAmount();
 		getDefaultValues();
 	}     
    
}