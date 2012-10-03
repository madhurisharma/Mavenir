/*******************************************************************************************************************
Name         : RevenueTypeController 
Created By   : Madhuri
Created Date : 21 Aug 2012
Description  : Used to create Revenue Type
Related Page : AddRevenueType.page
Task         : 
Requested By : 

/*************************************************************************************************************/

public class RevenueTypeController {
  
    //Variables
    public Revenue_Type__c rtObject {get; set;}
    public Set<id> productIds{get;set;}
    public Map<id,Decimal> revRecogMap{get;set;}
    public Set<String> revTypeNames{get;set;}
    public string productName{get;set;}        
    boolean isActiveProduct = true;
    
    //Local Book Values
    public String license {get;set;}
    public String professionalServices {get;set;}
    public String customDevelopment {get;set;}
    public String thirdParty {get;set;}
    public String thirdPartyVAS {get;set;}
    public String support {get;set;}
    public Decimal currentBookValue{get;set;}
     
   //Delete Revenue Type
   public list<selectOption> prodList {get;set;}
   public String selectedProd {get;set;}
   
    
    // Opportunity record from which the button is clicked.
    public Opportunity opportunity{get;set;}   
    //A temprory Opportunity object used to fill values and show on VF page to get the desired currency formating
    public Opportunity tOpportunity{get;set;}
    
    public RevenueTypeController () {
        productIds = new Set<id>();
        revTypeNames = new Set<String>();
        prodList = new list<selectOption>();
        List<Product2> productNames = new List<Product2>();
    
        
        opportunity = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product__c, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r), (Select Id, Amount__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: ApexPages.currentPage().getParameters().get('id')];
      
        for(Revenue_Type__c rt:opportunity.Revenue_Type__r){
        	
        	if(rt.Product__c != null){
        		productIds.add(rt.Product__c);
        	}
        	if(rt.Revenue_Type__c != null){
        		revTypeNames.add(rt.Revenue_Type__c.toLowercase());
        	}
        	
       }
       
       productNames = [Select id,name from Product2 where id=:productIds order by name];
       system.debug('-----prodNames-----'+productNames);
       for(Product2 p:productNames){
       		SelectOption Option = new selectOption(p.id,p.name); 
       		prodList.add(Option);
       		
       }      
       
       rtObject = new Revenue_Type__c();        
       goCalculateOppAmount();
       getDefaultValues();
              
    }
    
    //Called when a product is selected from lookup. The Product and Family fields a re rendered and used to populate the family of the product selected.
    public PageReference populateProductFamily()
    {
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
    
    //Action method called on click of Calculate button
    public PageReference goCalculateCurrentBookValue()
    {
    	System.debug('------validate ----'+!validate());
    	if(!validate()){
    		system.debug('------In validate ----');
 			return null;
    	}
    	system.debug('----In goCalculateCurrentBookValue-----');
    	try{
    		tOpportunity = new Opportunity();
    		tOpportunity.Cash_collected__c =  getCurrentBookValue();
    	system.debug('----currentBookValue---'+currentBookValue);
    	
    	}catch(System.TypeException e){
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error:'+e));
    		system.debug(ApexPages.getMessages());
    	}
    	goCalculateOppAmount();
    	return null;	
    }
    
    //Action method called on click of Calculate button
    public PageReference goCalculateOppAmount()
    {
    	system.debug('----In goCalculateOppAmount-----');
    	tOpportunity = new Opportunity();
    	//tOpportunity.Cash_collected__c = getCurrentBookValue();
    	//System.debug('----tOpportunity.Cash_collected__c -----'+tOpportunity.Cash_collected__c );
    	tOpportunity.Amount =  getBookOpportunityValue();
    	system.debug('----In tOpportunity.Amount-----'+tOpportunity.Amount);
    	return null;	
    }
    
    //Calulate Cureent Book  Value: Sum total of License, Professional services, Custom Development, third party, Support .
     public Decimal getCurrentBookValue()
    {
    	system.debug('----In getCurrentBookValue-----');
    	Decimal localBookValue = 	RevenueTypeUtility.getValueInt(license) + 
    								RevenueTypeUtility.getValueInt(professionalServices) + 
    								RevenueTypeUtility.getValueInt(customDevelopment) + 
    								RevenueTypeUtility.getValueInt(thirdParty) + 
    								RevenueTypeUtility.getValueInt(support);
		System.debug('\n\nLOCALBOOKVAL: ' + localBookValue);
		return localBookValue;
    }
	
    // Calculated Book Opportunity Value: Sum total of License, Professional services, Custom Development, Support PLUS amount listed on all Revenue Recognition records.
    public Decimal getBookOpportunityValue()
    {
    	system.debug('----In getBookOpportunityValue-----');
    	Decimal currentBookValue = getCurrentBookValue();
    	Decimal opportunityBookValue = 0;
		if(opportunity!=null && opportunity.Revenue_Recognition__r!=null && opportunity.Revenue_Recognition__r.size()>0)
		{
			for(Revenue_Recognition__c r: opportunity.Revenue_Recognition__r)
			{
				opportunityBookValue = opportunityBookValue + RevenueTypeUtility.getValue(r.Amount__c);
			}	
		}
		    								
    	return currentBookValue + opportunityBookValue;
    }
    
    //Method to display Reset Default Values
    private void setDefaultValues() {
    	system.debug('---setDefaultValues---');
    	String bvName; 
	    	List<Book_Values__c> bookValuesList = Book_Values__c.getall().values();
	    	system.debug('---bookValuesList---'+bookValuesList);
	    	for(Book_Values__c bv:bookValuesList){
	    		bvName = bv.Name;
	    		if(bvName.equals('Lag_Days')){
	    			opportunity.Project_Start_Lag_Days__c = Integer.valueOf(bv.Value__c);
	    			system.debug('---opportunity.Project_Start_Lag_Days__c---'+opportunity.Project_Start_Lag_Days__c);
	    		}
	    		else if(bvName.equals('opportunity.Delivery_Duration_Months__cation')){
	    			opportunity.Delivery_Duration_Months__c = Integer.valueOf(bv.Value__c);
	    		}
	    		else if(bvName.equals('Support_opportunity.Delivery_Duration_Months__cation')){
	    			opportunity.Support_Duration_Months__c = Integer.valueOf(bv.Value__c);
	    		}
	    		
	    	}
	    	calSupportStartDate();
	    	
    }
    
    //Method to display Reset Default Values
    public PageReference resetDefaultValues() {
    	
    	system.debug('---resetDefaultValues---');
    	setDefaultValues();
	    return null;
    }
    
    //Method to display default values from Custom Settings
    public void getDefaultValues() {
    	system.debug('---productIds---'+productIds);
    	if(productIds.size() == 0){
    		system.debug('---In productIds block---');
    		setDefaultValues();	    
    	}
    	else if((opportunity.Support_Start_Date__c != null && opportunity.Project_Start_Lag_Days__c != 0 &&     		
    	     opportunity.Delivery_Duration_Months__c != 0 && opportunity.Support_Duration_Months__c != 0) &&
    	     (productIds.size() > 0)){
    	     	system.debug('---In Opportunity block---');
    	     	opportunity.Project_Start_Lag_Days__c = Integer.valueOf(opportunity.Project_Start_Lag_Days__c);
    	     	opportunity.Delivery_Duration_Months__c = Integer.valueOf(opportunity.Delivery_Duration_Months__c);
    	     	opportunity.Support_Duration_Months__c = Integer.valueOf(opportunity.Support_Duration_Months__c);
    		    
    	}
    	else {
    		    system.debug('---In Error block---'); 
    		    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter forecast data fields in Opportunity'));
    		   	return ;
    	}
    
    }
    //Method to calculate Support Start Date
    public void calSupportStartDate() 
    {     	
		date oppCloseDate = opportunity.CloseDate;
		date oppDtDays = OppCloseDate.addDays(Integer.valueOf(opportunity.Project_Start_Lag_Days__c)) ;		
		opportunity.Support_Start_Date__c = oppDtDays.addMonths(Integer.valueOf(opportunity.Delivery_Duration_Months__c));
    }
    //Method to return the control back to Opportunity details page
    public Pagereference cancel() {
    	system.debug('----In cancel----');
		return new Pagereference('/'+opportunity.id);
 	}
 	
 	
 	private boolean hasOnlyLicense()
 	{
 		System.debug('----revTypeNames-----'+revTypeNames);
 		system.debug('----RevenueTypeUtility.hasValue(license)------'+RevenueTypeUtility.hasValue(license));
 		system.debug('----RevenueTypeUtility.hasValue(professionalServices)------'+RevenueTypeUtility.hasValue(professionalServices));
 		system.debug('----RevenueTypeUtility.hasValue(customDevelopment)------'+RevenueTypeUtility.hasValue(customDevelopment));
 		system.debug('----RevenueTypeUtility.hasValue(thirdParty)------'+RevenueTypeUtility.hasValue(thirdParty));
 		system.debug('----RevenueTypeUtility.hasValue(thirdPartyVAS)------'+RevenueTypeUtility.hasValue(thirdPartyVAS));
 		system.debug('----RevenueTypeUtility.hasValue(support)------'+RevenueTypeUtility.hasValue(support));
 		//if((!(revTypeNames.contains('license')) || !(RevenueTypeUtility.hasValue(license))) && 
 			//(revTypeNames.size()>1 || (RevenueTypeUtility.hasValue(professionalServices) || RevenueTypeUtility.hasValue(customDevelopment) || RevenueTypeUtility.hasValue(thirdParty) || RevenueTypeUtility.hasValue(thirdPartyVAS) || RevenueTypeUtility.hasValue(support)))){
 		if((RevenueTypeUtility.hasValue(license)) && 
	        (
		    !(RevenueTypeUtility.hasValue(professionalServices)) && 
		    !(RevenueTypeUtility.hasValue(customDevelopment)) && 
		    !(RevenueTypeUtility.hasValue(thirdParty)) && 
		    !(RevenueTypeUtility.hasValue(thirdPartyVAS)) && 
		    !(RevenueTypeUtility.hasValue(support))
		   ) && (!revTypeNames.contains('license') && revTypeNames.size() < 1)
		)
 		{
 		
 			System.debug('------Inside true block-----');
 			return true;
 		}
 		else
 			return false;
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
 	
 	
 	//Method to apply valdiations
 	public boolean validate()
 	{
 		boolean valid = true;
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
 				
 		if(RevenueTypeUtility.hasValue(license) && !RevenueTypeUtility.hasValue(rtObject.License_Type__c))
 		{
 			rtObject.License_Type__c.addError('Please select the type of License');
    		valid = false;    	
 		}
 		if(RevenueTypeUtility.hasValue(support) && !RevenueTypeUtility.hasValue(rtObject.Support_Type__c))
 		{
 			rtObject.Support_Type__c.addError('Please select the type of Support');
    		valid = false;    	
 		}
 		if(
	 		!RevenueTypeUtility.hasValue(license) &&
	 		!RevenueTypeUtility.hasValue(professionalServices)&&
	 		!RevenueTypeUtility.hasValue(customDevelopment)&&
	 		!RevenueTypeUtility.hasValue(thirdParty)&&
	 		!RevenueTypeUtility.hasValue(thirdPartyVAS)&&
	 		!RevenueTypeUtility.hasValue(support)
 		){
 			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter the book value for any revenue type'));
    		valid = false; 
 		} 		
 			return valid;
 	}
 	
	// Fetch Revenue types after product delete
	public Map<String, Revenue_Type__c> fetchRevenueTypes()
	{
		system.debug('----fetchRevenueTypes----');
		List<Revenue_Type__c> rtList = new List<Revenue_Type__c>();
		List<Revenue_Recognition__c> rrList = new List<Revenue_Recognition__c>();
		rtList = [Select r.Support_Type__c, r.Revenue_Type__c, r.Product__c, r.Product_Type__c, r.Product_Family__c, 
									r.Opportunity__c, r.Name, r.License_Type__c, r.Id,r.amount__c, (Select Id, Amount__c, Revenue_Recognition_Date__c 
									From Revenue_Type__r) From Revenue_Type__c r
									where r.Opportunity__c =: ApexPages.currentPage().getParameters().get('id')];
			
			
		Map<String, Revenue_Type__c> rtMap = new Map<String, Revenue_Type__c>();
				
		if(rtList.size() > 0)
			{		
					System.debug('-----rtList after prod delete----'+rtList);
					
					for(Revenue_Type__c r: rtList)
					{
						rtMap.put(r.Revenue_Type__c, r);	
						rrList.addAll(r.Revenue_Type__r);
					}
					
				
			}
			//Delete remaining revenue recognition records and create again
			system.debug('----remaining revenue recognitiion----'+rrList);
			delete rrList;
		return rtMap;
		
	}
	
	//Create Revenue Recognisition
	public void createRR(Map<String, Revenue_Type__c> revTypeMap,boolean flag){
		
		system.debug('-----flag-----'+flag);
		system.debug('-----revTypeMap-----'+revTypeMap);
		if(revTypeMap!=null && revTypeMap.size()>0)
		{
			List<Revenue_Recognition__c> revrecs = new List<Revenue_Recognition__c>();
			Date startDate = opportunity.CloseDate;
			if(hasOnlyLicense())
			{
				system.debug('-----revTypeMap-----'+revTypeMap);
				Revenue_Type__c rt = revTypeMap.get('License'); 
				system.debug('---rt----'+rt+'----start date-----'+startDate);				
				revrecs.add(buildRevRec(rt.Id, startDate, rt.Amount__c));
			}
			else
			{
				startDate = opportunity.CloseDate.addDays(Integer.valueOf(opportunity.Project_Start_Lag_Days__c));
				List<Revenue_Type__c> allRevTypes = revTypeMap.values();
				system.debug('-----allRevTypes-----'+allRevTypes);
				if(flag){
					system.debug('-----Inside flag -----');
					if(opportunity.Revenue_Type__r!=null)
						allRevTypes.addAll(opportunity.Revenue_Type__r);
				}	
				for(Revenue_Type__c rt: allRevTypes)
				{
					 //revrecs.addAll(breakRevenueRec(rt.Id, startDate, rt.Amount__c));
					 //Change for Support Type
					 revrecs.addAll(breakRevenueRec(rt.Id,rt.Revenue_Type__c, startDate, rt.Amount__c));
				}
			}
			
			if(revrecs.size()>0)
				System.debug('-----Revenue Recognition Records----'+revrecs);
				insert revrecs; 			 			
		}
		opportunity.Close_Date_Validation__c = String.valueOf(System.now().getTime());
		update opportunity; 	
	}
 	
 	//Create Revenue Recognisition after product delete
	public void createRRAfterProdDelete(){
		boolean flag = false;                        
		Map<String, Revenue_Type__c> rtMap = new Map<String,Revenue_Type__c>();
		rtMap =  fetchRevenueTypes();
	    createRR(rtMap,flag);
	
	} 	
 	
 	//Called when a product is selected from menu. Revenue Types and Revenue Recognition Records related to the slected product should be deleted.
    public pageReference deleteRevTypes(){
    	system.debug('----selectedProd----'+selectedProd);
    	List<Revenue_Recognition__c> rrToDelete = new List<Revenue_Recognition__c>();
    	
    	List<Revenue_Type__c> rtList = [Select Product__c, Id,Amount__c, (Select Id, Revenue_Recognition_Date__c
    	                          From R00N30000001tAoVEAU) From Revenue_Type__c  where Product__c =:selectedProd
    	                          and Opportunity__c =: ApexPages.currentPage().getParameters().get('id')];
    	System.debug('----rtList----'+rtList);
    	
    	for(Revenue_Type__c r: rtList)
    	{
    		rrToDelete.addAll(r.R00N30000001tAoVEAU);
    	}
    	
    	System.debug('----rrToDelete----'+rrToDelete);
    	if(rtList.size() > 0){
    		delete rtList;
    	}
    	if(rrToDelete.size() > 0){
    		delete rrToDelete;
    	}
    	
    	createRRAfterProdDelete();
    	return new Pagereference('/'+opportunity.id);
	}
 	
 	//Delete Revenue Recognition Records
 	public void goDeleteRevenueRecog()
 	{
 		
 		if(opportunity.Revenue_Recognition__r!=null && opportunity.Revenue_Recognition__r.size()>0)
 			delete opportunity.Revenue_Recognition__r;
 		
 		
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
		goSave();
		initialVariables();
 		return new Pagereference('/apex/addrevenuetype');
 	}
 		
 	public PageReference goSave()
 	{
 		boolean flag = true;	
 		if(!validate())
 			return null;
 			
 		 goDeleteRevenueRecog();
 		
 		Map<String, Revenue_Type__c> revTypeMap = createRevenueType();
 		system.debug('-----revTypeMap In goSave-----'+revTypeMap);
 		createRR(revTypeMap,flag);
 	/*	if(revTypeMap!=null && revTypeMap.size()>0)
 		{
 			List<Revenue_Recognition__c> revrecs = new List<Revenue_Recognition__c>();
 			Date startDate = opportunity.CloseDate;
 			if(hasOnlyLicense())
 			{
 				system.debug('-----revTypeMap-----'+revTypeMap);
 				Revenue_Type__c rt = revTypeMap.get('License'); 
 				system.debug('---rt----'+rt+'----start date-----'+startDate);				
 				revrecs.add(buildRevRec(rt.Id, startDate, rt.Amount__c));
 			}
 			else
 			{
 				startDate = opportunity.CloseDate.addDays(Integer.valueOf(opportunity.Project_Start_Lag_Days__c));
 				List<Revenue_Type__c> allRevTypes = revTypeMap.values();
 				if(opportunity.Revenue_Type__r!=null)
 					allRevTypes.addAll(opportunity.Revenue_Type__r);
 				for(Revenue_Type__c rt: allRevTypes)
 				{
 					 //revrecs.addAll(breakRevenueRec(rt.Id, startDate, rt.Amount__c));
 					 //Change for Support Type
 					 revrecs.addAll(breakRevenueRec(rt.Id,rt.Revenue_Type__c, startDate, rt.Amount__c));
 				}
 			}
 			
 			if(revrecs.size()>0)
 			    System.debug('-----Revenue Recognition Records----'+revrecs);
 				insert revrecs; 			 			
 		}
 		opportunity.Close_Date_Validation__c = String.valueOf(System.now().getTime());
 		update opportunity; */		 			 		
 		return new PageReference('/' + opportunity.Id);
 	}
 	
 	public List<Revenue_Recognition__c> breakRevenueRec(Id revTypeId, String rType,Date startDate, Decimal revRecAmount)
 	{
 		System.debug('------ breakRevenueRec------');
 		//Added for Support Revenue Type
 		Integer durMonth = Integer.valueOf(opportunity.Delivery_Duration_Months__c);
		if(rType == 'Support'){
			System.debug('------ In support if block------');
			startDate = opportunity.Support_Start_Date__c; 
			durMonth = Integer.valueOf(opportunity.Support_Duration_Months__c);
			System.debug('------ startdate------'+startDate+'-----durMont-----'+durMonth);
		}
		
 		//Decimal amount = revRecAmount / (opportunity.Delivery_Duration_Months__c * 30);
 		Decimal amount = revRecAmount / (durMonth * 30);
 		
 		List<Revenue_Recognition__c> insertRevRec = new List<Revenue_Recognition__c>();
 		if(startDate.day()==1)
 		{
 			for(Integer i=0; i<durMonth; i++)
 			{
 				insertRevRec.add(buildRevRec(revTypeId, startDate.addMonths(i), (amount * 30)));
 			}
 		}
 		else
 		
 		{				
 			Date lastDate = calLastDateOfTheMonth(startDate);
 			Date startDateCalc = startDate; //used for Calculations
 			if(startDateCalc.day()==31) 			
 				startDateCalc = startDateCalc.addDays(-1); 				
 					
 			Integer No_Days = startDateCalc.daysBetween(lastDate);
 			//Integer daysLeft = Integer.valueOf(opportunity.Delivery_Duration_Months__c) * 30;
 			Integer daysLeft = Integer.valueOf(durMonth) * 30; 	 		
 			
 			No_Days = No_Days + 1;
 			insertRevRec.add(buildRevRec(revTypeId, startDate, (amount * No_Days)));
 			daysLeft = daysLeft - No_Days;
 			
 			//if(opportunity.Delivery_Duration_Months__c>1)
 			if(durMonth>1)
 			{	 			
	 			//for(Integer i=0; i<opportunity.Delivery_Duration_Months__c - 1; i++)
	 			for(Integer i=0; i<durMonth - 1; i++)
	 			{
	 				insertRevRec.add(buildRevRec(revTypeId, startDate.addMonths(i + 1).toStartOfMonth(), (amount * 30)));
	 				daysLeft = daysLeft - 30;
	 			}
 			}
 			
 			insertRevRec.add(buildRevRec(revTypeId, startDate.addMonths(Integer.valueOf(opportunity.Delivery_Duration_Months__c)).toStartOfMonth(), (amount * daysLeft)));
 			
 		}
 		return insertRevRec;
 	}
 	
 	public Revenue_Recognition__c buildRevRec(Id revTypeId, Date recDate, Decimal amount)
 	{
    	Revenue_Recognition__c revRecog = new Revenue_Recognition__c();
    	revRecog.Revenue_Type__c = revTypeId;
    	revRecog.Opportunity__c = opportunity.id;	
    	revRecog.Revenue_Recognition_Date__c = recDate;
    	revRecog.Amount__c = amount;
    	return revRecog;
 	}
 	
	public Revenue_Type__c buildRevenueType(String revType, Decimal amount, boolean isLicense, boolean isSupport)
	{
				Revenue_Type__c rtObj = new Revenue_Type__c();
	 			rtObj.Amount__c = amount;
	 			if(isLicense)
	 				rtObj.License_Type__c = rtObject.License_Type__c;
	 			if(isSupport)
	 				rtObj.Support_Type__c = rtObject.Support_Type__c;	
	 			rtObj.name = productName + '-'+ revType; 
	 			rtObj.Opportunity__c = opportunity.id;
	 			rtObj.Revenue_Type__c = revType;
	 			rtObj.Product__c = rtObject.Product__c;
	 			rtObj.Product_Family__c = rtObject.Product_Family__c;
	 			rtObj.Product_Type__c = rtObject.Product_Type__c;
	 			return rtObj;
	}
	
	//Method to create Revenue Type Records
 	public Map<String, Revenue_Type__c> createRevenueType()
 	{
 		system.debug('----createRevenueType----');
 		List<Revenue_Type__c> revTypeRecords = new List<Revenue_Type__c>();
 		
 	 		if(RevenueTypeUtility.hasValue(license)) 
	 			revTypeRecords.add(buildRevenueType('License', Integer.valueOf(license), true, false));	 	
	 		if(RevenueTypeUtility.hasValue(professionalServices))
	 			revTypeRecords.add(buildRevenueType('Professional Services', Integer.valueOf(professionalServices), false, false));	 		
	 		if(RevenueTypeUtility.hasValue(customDevelopment))
	 			revTypeRecords.add(buildRevenueType('Custom Development', Integer.valueOf(customDevelopment), false, false));
	 		if(RevenueTypeUtility.hasValue(thirdParty))
	 			revTypeRecords.add(buildRevenueType('3rd Party', Integer.valueOf(thirdParty), false, false));
	 		if(RevenueTypeUtility.hasValue(thirdPartyVAS))
	 			revTypeRecords.add(buildRevenueType('3rd Party VAS', Integer.valueOf(thirdPartyVAS), false, false));
	 		if(RevenueTypeUtility.hasValue(support))
	 			revTypeRecords.add(buildRevenueType('Support', Integer.valueOf(support), false, true));
 		 	
 		 	Map<String, Revenue_Type__c> rtMap = new Map<String, Revenue_Type__c>();
 		 		
 		if(revTypeRecords.size() > 0)
 			{		
 					System.debug('-----Revenue Type Records----'+revTypeRecords);
 					insert revTypeRecords;
 					for(Revenue_Type__c r: revTypeRecords)
 					{
 						System.debug('-----rtMap in createRevenueType----'+rtMap);
 						rtMap.put(r.Revenue_Type__c, r);	
 					}
 					
 				
 			}
 		
 		return rtMap;
 		
	 	}
 		
    private Date calLastDateOfTheMonth(Date projStartDate)
    {	    
    	Date lastDate = projStartDate.addMonths(1).toStartOfMonth().addDays(-1);
    	
    	if(lastDate.day() == 31){
    		Date lDate = Date.newInstance(projStartDate.year(),projStartDate.month(),30);
    		System.debug('----lDate-----'+lDate);
    		return lDate;
    	}
    	else {
    		System.debug('----lastDate-----'+lastDate);
    		return lastDate;
    	}
    	
    }
}