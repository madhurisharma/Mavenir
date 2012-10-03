trigger OppTrigger on Opportunity (before insert, before update) 
{
	//declarations
	Opportunity[] o = Trigger.new;	
	Set<Id> userIds = new Set<Id>();
	Set<Id> actAssoc = new Set<Id>();
	
	//loop through to get all distinct ownerids and AccountAssociates
	for (Opportunity oLoop1:o)	
	{	
		userIds.add(oLoop1.ownerid);	
		if (oLoop1.Global_Account_Associate__c != null)
		{
			actAssoc.add(oLoop1.Global_Account_Associate__c);
		}
	}	
	
	// Populate the User Map
   	Map<Id, User> userMap = new Map<Id, User>([select Employee_ID__c from User Where Id IN :userIds]);   
   
    //Populate Account Associate (User) Map	
   	Map<Id, User> actAssocMap = new Map<Id, User>([select Employee_ID__c from User Where Id IN :actAssoc]);   
   	   
	//loop through all records and set values from the mapped user   
   	for (Opportunity oLoop2:o)	
	{	
		oLoop2.AM_Employee_ID__c = userMap.get(oLoop2.OwnerId).Employee_ID__c;
		if (oLoop2.Global_Account_Associate__c != null)
		{
			oLoop2.GAA_Employee_ID__c = actAssocMap.get(oLoop2.Global_Account_Associate__c).Employee_ID__c;				
		}	
		else
		{
			oLoop2.GAA_Employee_ID__c = '';
		} 
	}
}