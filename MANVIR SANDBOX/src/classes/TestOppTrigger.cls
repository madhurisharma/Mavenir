public class TestOppTrigger 
{
	static testmethod void testTriggers()
	{
	
		Opportunity o = new Opportunity();	
		o.OwnerId = '00530000000zgnl';
		o.Name = 'Test';
		o.StageName = '1. Suspect';
		o.CloseDate = system.today();		
		insert o;

	}
}