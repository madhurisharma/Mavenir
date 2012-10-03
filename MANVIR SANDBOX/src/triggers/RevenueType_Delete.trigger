trigger RevenueType_Delete on Revenue_Type__c (after delete) {
	
	delete [Select Id from Revenue_Recognition__c where Revenue_Type__c IN :Trigger.old];
	
}