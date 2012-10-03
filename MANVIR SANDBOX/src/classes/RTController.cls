public without sharing virtual class RTController 
{
	public Revenue_Type__c rtObject {get; set;}
	public Set<id> productIds{get;set;}
    public Map<id,Decimal> revRecogMap{get;set;}
    
    public string productName{get;set;}        
    public Map<Id, Revenue_Type__c> rtMap = new Map<Id, Revenue_Type__c>();
    
    //Local Book Values
    public String license {get;set;}
    public String professionalServices {get;set;}
    public String customDevelopment {get;set;}
    public String thirdParty {get;set;}
    public String thirdPartyVAS {get;set;}
    public String support {get;set;}
    public Decimal currentBookValue{get;set;}
     
    // Opportunity record from which the button is clicked.
    public Opportunity opportunity{get;set;}   
    //A temprory Opportunity object used to fill values and show on VF page to get the desired currency formating
    public Opportunity tOpportunity{get;set;}
    
     public RTController () {    	
    	productIds = new Set<id>();        
        rtObject = new Revenue_Type__c();
      }
    
    
     //Method call on page load
    public void fetchValues(){
    	System.debug(LoggingLevel.ERROR,'---fetchValues----');
        
        String oppId = ApexPages.currentPage().getParameters().get('oppid');
       
        System.debug(LoggingLevel.ERROR,'\n\nREVID: ' + ApexPages.currentPage().getParameters().get('id'));
        if(oppId==null)
        {
        	oppId = [Select Opportunity__c from Revenue_Type__c where Id=:ApexPages.currentPage().getParameters().get('id')].Opportunity__c;
        }
        System.debug(LoggingLevel.ERROR,'\n\nOPPID: ' + oppId);
        opportunity = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Type__c From Revenue_Recognition__r where Revenue_Type__c!=null) From Opportunity o where 
          o.id =: oppId];  
        
        for(Revenue_Type__c rt:opportunity.Revenue_Type__r){ 
        	rtMap.put(rt.Id, rt);
        	if(rt.Product__c != null){
        		productIds.add(rt.Product__c);
        	}
        	
       }
       
    }
    
    public PageReference goCalculateCurrentBookValue()
    {
    	return goCalculateCurrentBookValue(true);
    }
    
      //Action method called on click of Calculate button
    public PageReference goCalculateCurrentBookValue(boolean callValidate)
    {
    	System.debug(LoggingLevel.ERROR,'------validate ----'+!validate()); 
    	if(callValidate && !validate()){
    		System.debug(LoggingLevel.ERROR,'------In validate Error ----');
 			return null;
    	}
    	System.debug('\n\n----In goCalculateCurrentBookValue ERROR-----');
    	try{
    		if(tOpportunity == null){
    			tOpportunity = new Opportunity();
    		}
	
    	tOpportunity.Cash_collected__c =  getCurrentBookValue();
    		
    	System.debug('\n\nCALC OPP AMOUNT: ' + tOpportunity);
    	goCalculateOppAmount();
    	
    	}catch(System.TypeException e){
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter a valid number'));
    		System.debug(LoggingLevel.ERROR,ApexPages.getMessages());
    	}
    	
    	return null;	
    }
     //Calulate Cureent Book  Value: Sum total of License, Professional services, Custom Development, third party, Support .
    public Decimal getCurrentBookValue()
    {
    	System.debug(LoggingLevel.ERROR,'\n\n----In getCurrentBookValue-----');
    	Decimal localBookValue = 	RevenueTypeUtility.getValueInt(license) + 
    								RevenueTypeUtility.getValueInt(professionalServices) + 
    								RevenueTypeUtility.getValueInt(customDevelopment) + 
    								RevenueTypeUtility.getValueInt(thirdParty) + 
    								RevenueTypeUtility.getValueInt(thirdPartyvas) + 
    								RevenueTypeUtility.getValueInt(support);
		System.debug(LoggingLevel.ERROR,'\n\nLOCALBOOKVAL: ' + localBookValue);
		return localBookValue;
    }
     // Calculated Book Opportunity Value: Sum total of License, Professional services, Custom Development, Support PLUS amount listed on all Revenue Recognition records.
    public Decimal getBookOpportunityValue()
    {
    	
    	Decimal currentBookValue = getCurrentBookValue();
    	System.debug(LoggingLevel.ERROR,'\n\n------current value ------' + currentBookValue)  ;	
    	Decimal opportunityBookValue = 0;
    	System.debug('\n\nOPP REV REC' + opportunity.Revenue_Recognition__r)  ;
		if(opportunity!=null && opportunity.Revenue_Recognition__r!=null && opportunity.Revenue_Recognition__r.size()>0)
		{			
			System.debug('\n\nBOOK VALUE: ' + opportunityBookValue)  ;
			for(Revenue_Recognition__c r: opportunity.Revenue_Recognition__r)
			{
				System.debug('\n\nRREC: ' + opportunityBookValue + '  = ' + r.Amount__c + ' == ' + RevenueTypeUtility.getValue(r.Amount__c));
				opportunityBookValue = opportunityBookValue + RevenueTypeUtility.getValue(r.Amount__c);
				System.debug('\n\nRREC CALC: ' + opportunityBookValue);
			}	
		}
		System.debug('\n\n------Opportunity Book Value --------' + currentBookValue + ' == ' + opportunityBookValue);  								
    	return currentBookValue + opportunityBookValue;
    }
     //Method to display Reset Default Values
    private void setDefaultValues() {
    	
    	String bvName; 
	    	List<Book_Values__c> bookValuesList = Book_Values__c.getall().values();
	       
	    	for(Book_Values__c bv:bookValuesList){
	    		bvName = bv.Name;
	    		if(bvName.equals('Lag_Days')){
	    			opportunity.Project_Start_Lag_Days__c = Integer.valueOf(bv.Value__c);
	    			
	    			
	    		}
	    		else if(bvName.equals('Month_Duration')){
	    			opportunity.Delivery_Duration_Months__c = Integer.valueOf(bv.Value__c);
	    			
	    		}
	    		else if(bvName.equals('Support_Month_Duration')){
	    			opportunity.Support_Duration_Months__c = Integer.valueOf(bv.Value__c);
	    		
	    		}
	    		
	    	}
	    	calSupportStartDate();	    	
    }
     //Method to display Reset Default Values
    public PageReference resetDefaultValues() {
    	
    	System.debug(LoggingLevel.ERROR,'---resetDefaultValues---');
    	setDefaultValues();
	    return null;
    }
    
     //Method to calculate Support Start Date
    public void calSupportStartDate() 
    {     	
		date oppCloseDate = opportunity.CloseDate;
		date oppDtDays;
		if(opportunity.Project_Start_Lag_Days__c == null || opportunity.Project_Start_Lag_Days__c == 0){
			oppDtDays = OppCloseDate;
		}
		else{
			oppDtDays = OppCloseDate.addDays(Integer.valueOf(opportunity.Project_Start_Lag_Days__c)) ;
		}
		
		if(opportunity.Delivery_Duration_Months__c == null || opportunity.Delivery_Duration_Months__c == 0){
			opportunity.Support_Start_Date__c = oppDtDays;
		}
		else{
			opportunity.Support_Start_Date__c = oppDtDays.addMonths(Integer.valueOf(opportunity.Delivery_Duration_Months__c));
		}
		
    }
    
    //Action method called on click of Calculate button
    public PageReference goCalculateOppAmount()
    {
    	if(tOpportunity == null){
    			tOpportunity = new Opportunity();
    	}
    	
    	tOpportunity.Amount =  getBookOpportunityValue();
    	System.debug(LoggingLevel.ERROR,'\n\n----In tOpportunity.Amount-----'+tOpportunity.Amount);
    	return null;	
    }
    
    //Method to return the control back to Opportunity details page
    public Pagereference cancel() {
    	System.debug(LoggingLevel.ERROR,'----In cancel----');
		return new Pagereference('/'+opportunity.id);
 	}
 	private boolean hasOnlyLicense()
 	{
 		Set<String> revTypeNames = new Set<String>();
 		for(Revenue_Type__c rt: rtMap.values())
 		{ 			
 			if(rt.Revenue_Type__c != null){
        		revTypeNames.add(rt.Revenue_Type__c.toLowercase());
        	}
 		}
 		System.debug(LoggingLevel.ERROR,'\n\nREVTYPE NAMES : ' + revTypeNames);
 		if(revTypeNames.contains('license') && revTypeNames.size() == 1)		
 			return true;
 		else
 			return false;
 	}
 	//Method to apply valdiations
 	public boolean validate()
 	{
 		boolean valid = true;
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
 	//Create Revenue Recognisition
	public void createRR(List<Revenue_Type__c> rtList){
		
		System.debug(LoggingLevel.ERROR,'\n\nCREATIGN RR: ' + rtList);
		if(rtList!=null && rtList.size()>0)
		{
			List<Revenue_Recognition__c> revrecs = new List<Revenue_Recognition__c>();
			Date startDate = opportunity.CloseDate;
			System.debug(LoggingLevel.ERROR,'\n\nHASLIONLY: : ' + hasOnlyLicense());
			if(hasOnlyLicense())
			{
				for(Revenue_Type__c rt: rtList)								
					revrecs.add(buildRevRec(rt.Id, startDate, rt.Amount__c));
			}
			else
			{
				startDate = opportunity.CloseDate.addDays(Integer.valueOf(opportunity.Project_Start_Lag_Days__c));
				for(Revenue_Type__c rt: rtList)				
					 revrecs.addAll(breakRevenueRec(rt.Id,rt.Revenue_Type__c, startDate, rt.Amount__c));				
			}
			
			if(revrecs.size()>0)
				upsert revrecs; 			 			
		}
			
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
 	public List<Revenue_Recognition__c> breakRevenueRec(Id revTypeId, String rType,Date startDate, Decimal revRecAmount)
 	{
 		System.debug(LoggingLevel.ERROR,'------ breakRevenueRec------');
 	
	 		//Added for Support Revenue Type
	 		Integer durMonth = Integer.valueOf(opportunity.Delivery_Duration_Months__c);
	 		if(durMonth == 0){
	 			durMonth = durMonth + 1;
	 		}
			if(rType == 'Support'){
				System.debug(LoggingLevel.ERROR,'------ In support if block------');
				startDate = opportunity.Support_Start_Date__c; 
				durMonth = Integer.valueOf(opportunity.Support_Duration_Months__c);
				if(durMonth == 0){
	 				durMonth = durMonth + 1;
	 			}
				
			}
			
	 		Decimal amount ;
	 		amount= revRecAmount / (durMonth * 30);
	 		
	 		List<Revenue_Recognition__c> insertRevRec = new List<Revenue_Recognition__c>();
	 		if(startDate.day()==1 || durMonth == 1)
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
	 			
	 			if(rType == 'Support')
	 				insertRevRec.add(buildRevRec(revTypeId, startDate.addMonths(Integer.valueOf(opportunity.Support_Duration_Months__c)).toStartOfMonth(), (amount * daysLeft)));
	 			else
	 				insertRevRec.add(buildRevRec(revTypeId, startDate.addMonths(Integer.valueOf(opportunity.Delivery_Duration_Months__c)).toStartOfMonth(), (amount * daysLeft)));
	 		}
	 		
	 		return insertRevRec;
 		
 		
 	}
 	private Date calLastDateOfTheMonth(Date projStartDate)
    {	    
    	Date lastDate = projStartDate.addMonths(1).toStartOfMonth().addDays(-1);
    	
    	if(lastDate.day() == 31){
    		Date lDate = Date.newInstance(projStartDate.year(),projStartDate.month(),30);
    		System.debug(LoggingLevel.ERROR,'----lDate-----'+lDate);
    		return lDate;
    	}
    	else {
    		System.debug(LoggingLevel.ERROR,'----lastDate-----'+lastDate);
    		return lastDate;
    	}
    	
    }
   
 	//Delete Revenue Recognition Records
 	public void goDeleteRevenueRecog ()
 	{ 		
 		System.debug(LoggingLevel.ERROR,'\n\nRR SIZE: ' + opportunity.Revenue_Recognition__r.size());
 		if(opportunity.Revenue_Recognition__r!=null && opportunity.Revenue_Recognition__r.size()>0)
 			{ 				
 				
 				List<Database.Deleteresult> drs = Database.delete(opportunity.Revenue_Recognition__r,false);
 			}
 	}
 	public void goSave(List<Revenue_Type__c> rtList)
 	{
 		System.debug(LoggingLevel.ERROR,'\n\nGOSAVE OPPAMT 1: ' + tOpportunity.Amount);
 		goDeleteRevenueRecog();
 		System.debug(LoggingLevel.ERROR,'\n\nGOSAVE OPPAMT 2: ' + tOpportunity.Amount);
 		createRR(rtList);
 		System.debug(LoggingLevel.ERROR,'\n\nGOSAVE OPPAMT 3: ' + tOpportunity.Amount);
 		opportunity.Close_Date_Validation__c = String.valueOf(System.now().getTime());
		
		if(tOpportunity!=null && tOpportunity.Amount!=null)
			opportunity.Amount = tOpportunity.Amount;
		System.debug(LoggingLevel.ERROR,'\n\nGOSAVE OPPAMT 4: ' + opportunity.Amount);
		
		Database.DMLOptions dmo = new Database.DMLOptions();
		dmo.allowFieldTruncation = true;
		opportunity.setOptions(dmo);
		
		Database.update(opportunity); 
 	}
 	public Revenue_Type__c buildRevenueType(String revType,Id ID,Decimal amount, boolean isLicense, boolean isSupport)
	{			Revenue_Type__c rtObj;
				
				if(ID == null){
					rtObj = new Revenue_Type__c();
					rtObj.Opportunity__c = opportunity.id;
					
					rtObj.Revenue_Type__c = revType;
					rtObj.name = productName + '-'+ revType;
				}
			    else {
					rtObj = new Revenue_Type__c(id=ID);
					rtObj.Revenue_Type__c = revType;
				} 
				
	 			rtObj.Amount__c = amount;
	 			
	 			if(isLicense)
	 				rtObj.License_Type__c = rtObject.License_Type__c;
	 			if(isSupport)
	 				rtObj.Support_Type__c = rtObject.Support_Type__c;	
	 			 
	 			
	 			rtObj.Product__c = rtObject.Product__c;
	 			rtObj.Product_Family__c = rtObject.Product_Family__c;
	 			rtObj.Product_Type__c = rtObject.Product_Type__c;
	 			return rtObj;
	}
	
	
 	 public void getDefaultValues() {
    	System.debug(LoggingLevel.ERROR,'---productIds---'+productIds);
    	
    	if(rtMap.size() < 1){
    		setDefaultValues();	    
    	}
    	else if((opportunity.Support_Start_Date__c != null && opportunity.Project_Start_Lag_Days__c != null &&     		
    	     opportunity.Delivery_Duration_Months__c != null && opportunity.Support_Duration_Months__c != null) &&
    	     (rtMap.size() > 0)){
    	     	opportunity.Project_Start_Lag_Days__c = Integer.valueOf(opportunity.Project_Start_Lag_Days__c);
    	     	opportunity.Delivery_Duration_Months__c = Integer.valueOf(opportunity.Delivery_Duration_Months__c);
    	     	opportunity.Support_Duration_Months__c = Integer.valueOf(opportunity.Support_Duration_Months__c); 
    		    
    	}
    	else {
    		    System.debug(LoggingLevel.ERROR,'---In Error block---'); 
    		    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter forecast data fields in Opportunity'));
    		   	return ;
    	}
    
    }
}