/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestBudgetController {
   
    //Test for Integer 
    static testMethod void budgetController1() {
       //create account
        Account acc = TestUtility.createAccount();
        
        //create opportunity
        Opportunity opp = TestUtility.createOpp();
        
        //create OppBudget_c
        List<OppBudget__c> oppBudget = TestUtility.createOppBudget();
        
        System.debug('---opportunity id------'+opp.id);
        
        ApexPages.Standardcontroller st = new ApexPages.Standardcontroller(opp);
        BudgetController bdCon = new BudgetController(st);
        List<String> jsonList = new String[100];
        for(integer i=0 ;i<100;i++){
            jsonList[i] = '["123","12","","","","","","","",""]';
        }
        System.debug('JSONLIST--->:'+jsonList);
        BudgetController.save(opp.Id, jsonList);
        List<Opportunity_Budget__c> oppBudgetList = new List<Opportunity_Budget__c>();
        oppBudgetList = [Select id,name,Col_1__c from Opportunity_Budget__c where Opportunity__c =:opp.id];
        System.debug('oppBudgetList--->:'+oppBudgetList);
        System.assert(true, oppBudgetList.size() > 0);
        System.assertEquals(oppBudgetList[0].Col_1__c,'["123","12","","","","","","","",""]');
    }
    //Test for special characters 
    static testMethod void budgetController2() {
       //create account
        Account acc = TestUtility.createAccount();
        
        //create opportunity
        Opportunity opp = TestUtility.createOpp();
        
        //create OppBudget_c
        List<OppBudget__c> oppBudget = TestUtility.createOppBudget();
       
        ApexPages.Standardcontroller st = new ApexPages.Standardcontroller(opp);
        BudgetController bdCon = new BudgetController(st);
        List<String> jsonList = new String[100];
        for(integer i=0 ;i<100;i++){
            jsonList[i] = '["#$","+,;()","^$@","","!&{}","","","","",""]';
        }
       
        BudgetController.save(opp.Id, jsonList);
        List<Opportunity_Budget__c> oppBudgetList = new List<Opportunity_Budget__c>();
        oppBudgetList = [Select id,name,Col_1__c from Opportunity_Budget__c where Opportunity__c =:opp.id];
      
        System.assert(true, oppBudgetList.size() > 0);
        System.assertEquals(oppBudgetList[0].Col_1__c,'["#$","+,;()","^$@","","!&{}","","","","",""]');
    }
     //Test for alphabets 
    static testMethod void budgetController3() {
       //create account
        Account acc = TestUtility.createAccount();
        
        //create opportunity
        Opportunity opp = TestUtility.createOpp();
        
        //create OppBudget_c
        List<OppBudget__c> oppBudget = TestUtility.createOppBudget();
       
        ApexPages.Standardcontroller st = new ApexPages.Standardcontroller(opp);
        BudgetController bdCon = new BudgetController(st);
        List<String> jsonList = new String[100];
        for(integer i=0 ;i<100;i++){
            jsonList[i] = '["asd","opj","","","","","","","",""]';
        }
       
        BudgetController.save(opp.Id, jsonList);
        List<Opportunity_Budget__c> oppBudgetList = new List<Opportunity_Budget__c>();
        oppBudgetList = [Select id,name,Col_1__c from Opportunity_Budget__c where Opportunity__c =:opp.id];
      
        System.assert(true, oppBudgetList.size() > 0);
        System.assertEquals(oppBudgetList[0].Col_1__c,'["asd","opj","","","","","","","",""]');
    }
}