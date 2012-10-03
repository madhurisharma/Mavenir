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
private class TestRTController {

    static testMethod void addOnlyLicense() {
        
        /*************************** When only License type exist **************************************/
        
        //create account
        Account acc = TestUtility.createAccount();
        
        //create opportunity
        Opportunity opp = TestUtility.createOpp();
       
        //create product
        List<Product2> prList = TestUtility.createProduct();
        
        //create book_values__c
        List<Book_Values__c> bvList = TestUtility.createBookValues();
        
        //call class
        Test.startTest();
        
        ApexPages.currentPage().getParameters().put('oppid', opp.id);
        System.debug('----TestRTController(Opp Id)------'+ApexPages.currentPage().getParameters().get('oppid'));
        RTAddController rtadd = new RTAddController();
        rtadd.addAction();
        rtadd.license = '100';
        rtadd.rtObject.Product__c = prList[0].id;
        rtadd.rtObject.License_Type__c = 'License';
        rtadd.populateProductFamily();
        rtadd.goSaveAdd();
        rtadd.cancel();
        
        Opportunity opportunity = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Recognition_Date__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
        List<Revenue_Type__c> rList = opportunity.Revenue_Type__r;
        List<Revenue_Recognition__c> rrList = opportunity.Revenue_Recognition__r;
       
        System.assertEquals(1,rList.size());
        System.assertEquals(Decimal.valueof('100'), rList[0].Amount__c);
        System.assertEquals('License', rList[0].Revenue_Type__c);
        System.assertEquals(1,rrList.size());
        
        Date startDate = opportunity.CloseDate;
       
        for(Revenue_Recognition__c rr:rrList){
            System.assertEquals(rr.Amount__c,100);
            if(startDate.day() != 1){
                System.assertEquals(rr.Revenue_Recognition_Date__c,startDate);
                
            }
            else{
                date.newinstance(1960, 2, 17);
                Date dt = Date.newInstance(startDate.year(), startDate.month(), 1);
                System.assertEquals(rr.Revenue_Recognition_Date__c,startDate,dt);
            }
        }
        
        /************************************************Modify License Revenue type ***********************************************************/
        RTModifyController rtmodify = new RTModifyController();
        rtmodify.rtObject.Product__c = prList[0].id;
        rtmodify.populateProductFamily();
        rtmodify.populateDefaultValuesForModify();
        rtmodify.rtObject.License_Type__c = 'License';
        rtmodify.license = '200';
        rtmodify.resetDefaultValues();
        rtmodify.goSaveModify();
        rtmodify.cancel();
        
        Opportunity opportunity3 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Recognition_Date__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
        List<Revenue_Type__c> rList3 = opportunity3.Revenue_Type__r;
        List<Revenue_Recognition__c> rrList3 = opportunity3.Revenue_Recognition__r;
        for(Revenue_Type__c r:rList3){
            if(r.Revenue_Type__c == 'License'){
                system.assertEquals(r.amount__c, 200);
            }
        }
        for(Revenue_Recognition__c r:rrList3){
            System.assertEquals(r.Revenue_Recognition_Date__c,opportunity3.CloseDate);
        }
        /**************************************************************************************************************************************/
        
       /****************** When License type already exist and we create custom developement revenue type ************************/
        
        RTAddController rtadd1 = new RTAddController();
        rtadd1.addAction();
        rtadd1.customDevelopment = '200';
        rtadd1.rtObject.Product__c = prList[1].id;
        rtadd1.populateProductFamily();
        rtadd1.goSaveAndAddProduct();
        rtadd1.goCalculateCurrentBookValue();
        
        Opportunity opportunity1 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
        List<Revenue_Type__c> rList1 = opportunity1.Revenue_Type__r;
        List<Revenue_Recognition__c> rrList1 = opportunity1.Revenue_Recognition__r;
        
        System.assertEquals(2,rList1.size());
      
        for(Revenue_Recognition__c rr:rrList){
            System.assertEquals(rr.Amount__c,100);
            if(startDate.day() != 1){
                
                System.assertEquals(rr.Revenue_Recognition_Date__c,startDate);
                
            }
            else{
                
                Date dt = Date.newInstance(startDate.year(), startDate.month(), 1);
                System.assertEquals(rr.Revenue_Recognition_Date__c,startDate,dt);
            }
        }
        
        /************************************************Delete Revenue type ***************************************************************/
        
        /*************************************** When only License Revenue Type left ******************************************************/
        
        ApexPages.currentPage().getParameters().put('oppid', opportunity1.id);
        
        RTDeleteController rtDelete = new RTDeleteController();
        for(Revenue_Type__c r:rList1){
            if(r.Revenue_Type__c == 'Custom Development'){
                rtDelete.selectedProduct = r.Product__c;
            }
        }
       System.debug('----selectedProduct(Test)-----'+rtDelete.selectedProduct);
       rtDelete.deleteRevTypes();
        Opportunity opportunity4 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opportunity1.id];
          
       System.assertEquals(1,opportunity4.Revenue_Type__r.size());
       System.assertEquals(1,opportunity4.Revenue_Recognition__r.size());
       Test.stopTest();
       
    }
     
     static testMethod void addTPVASOnly() {
        
        /*************************** Create ThirdPartyVAS Revenue Type **************************************/
        
        //create account
        Account acc = TestUtility.createAccount();
        
        //create opportunity
        Opportunity opp = TestUtility.createOppWithoutBookValues();
       
        //create product
        List<Product2> prList = TestUtility.createProduct();
        
        //create book_values__c
        List<Book_Values__c> bvList = TestUtility.createBookValues();
        system.debug('----bvList----'+bvList);
        
        //call class
        Test.startTest();
        ApexPages.currentPage().getParameters().put('oppid', opp.id);
        RTAddController rtadd = new RTAddController();
        rtadd.addAction();
    
        rtadd.thirdPartyVAS = '300';
        rtadd.rtObject.Product__c = prList[1].id;
        rtadd.populateProductFamily();
        rtadd.goSaveAdd();
        
        Opportunity opportunity1 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
        
        system.assertEquals(45,opportunity1.Project_Start_Lag_Days__c);
        system.assertEquals(12,opportunity1.Support_Duration_Months__c);
        system.assertEquals(3,opportunity1.Delivery_Duration_Months__c);
        
        List<Revenue_Type__c> rList1 = opportunity1.Revenue_Type__r;
        List<Revenue_Recognition__c> rrList1 = opportunity1.Revenue_Recognition__r;
        
        System.assertEquals(1,rList1.size());
        
        Date startDate = opportunity1.CloseDate.addDays(Integer.valueOf(opportunity1.Project_Start_Lag_Days__c));
        if(startDate.day() != 1){
            System.assertEquals(opportunity1.Delivery_Duration_Months__c + 1,rrList1.size());
        }else{
            System.assertEquals(opportunity1.Delivery_Duration_Months__c,rrList1.size());
        }
        
       /**************************Modify ThirdPartyVAS Revenue type and create Professional Services Revenue Type****************************/
       
        ApexPages.currentPage().getParameters().put('oppid', opportunity1.id);
        System.debug('---opportunity id------'+opportunity1.id);
        RTModifyController rtmodify = new RTModifyController();
        rtmodify.populateDefaultValuesForModify();
        rtmodify.rtObject.Product__c = prList[1].id;
        rtmodify.populateProductFamily();
        rtmodify.thirdPartyVAS = '400';
        rtmodify.professionalServices = '200';
        boolean validate = rtmodify.validate();
        System.assertEquals(true, validate);
        rtmodify.goSaveAndAddProduct();
       
        
        Opportunity opportunity3 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Recognition_Date__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
        List<Revenue_Type__c> rList3 = opportunity3.Revenue_Type__r;
        List<Revenue_Recognition__c> rrList3 = opportunity3.Revenue_Recognition__r;
        
        system.assertEquals(2,rList3.size());
        Date startDate1 = opportunity3.CloseDate.addDays(Integer.valueOf(opportunity3.Project_Start_Lag_Days__c));
        if(startDate1.day() != 1){
            System.assertEquals(rrList1.size() + (opportunity3.Delivery_Duration_Months__c + 1),rrList3.size());
        }else{
            System.assertEquals(rrList1.size() + (opportunity3.Delivery_Duration_Months__c),rrList3.size());
        }
        
        for(Revenue_Type__c r:rList3){
            if(r.Revenue_Type__c == '3rd Party VAS'){
                system.assertEquals(r.amount__c, 400);
            }
            if(r.Revenue_Type__c == 'Professional services'){
                system.assertEquals(r.amount__c, 200);
            }
        }
        
        /**************************************************************************************************************************************/
        
        /************************************************Delete Third Party VAS Revenue type *************************************************/
        
        //Call Class
       
       ApexPages.currentPage().getParameters().put('oppid', opportunity3.id);
        
        RTDeleteController rtDelete = new RTDeleteController();
        
        for(Revenue_Type__c r:rList3){
            if(r.Revenue_Type__c == '3rd Party VAS'){
                rtDelete.selectedProduct = r.Product__c;
            }
        }
       System.debug('----selectedProduct(Test)-----'+rtDelete.selectedProduct);
       rtDelete.deleteRevTypes();
          
         Opportunity opportunity4 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
          List<Revenue_Type__c> rList4 = opportunity4.Revenue_Type__r;
          List<Revenue_Recognition__c> rrList4 = opportunity4.Revenue_Recognition__r;
         
          System.assertEquals(0,rList4.size());
          System.assertEquals(0,rrList4.size());
         
    }
    
    static testMethod void addPSAndCD() {
       
        /*************************** Create Professional Services and Custom Developement **************************************/
        
        //create account
        Account acc = TestUtility.createAccount();
        
        //create opportunity
        Opportunity opp = TestUtility.createOpp();
       
        //create product
        List<Product2> prList = TestUtility.createProduct();
        
        //create book_values__c
        List<Book_Values__c> bvList = TestUtility.createBookValues();
        
        //call class
        
        Test.startTest();
        
        ApexPages.currentPage().getParameters().put('oppid', opp.id);
        RTAddController rtadd = new RTAddController();
        rtadd.addAction();
        rtadd.professionalServices = '100';
        rtadd.customDevelopment = '200';
        rtadd.rtObject.Product__c = prList[1].id;
        rtadd.populateProductFamily();
        rtadd.goSaveAdd();
        
         Opportunity opportunity3 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Recognition_Date__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
        List<Revenue_Type__c> rList3 = opportunity3.Revenue_Type__r;
        System.assertEquals(2,opportunity3.Revenue_Type__r.size());
        List<Revenue_Recognition__c> rrList3 = opportunity3.Revenue_Recognition__r;
        
        Date startDate1 = opportunity3.CloseDate.addDays(Integer.valueOf(opportunity3.Project_Start_Lag_Days__c));
        if(startDate1.day() != 1){
            System.assertEquals(2*(opportunity3.Delivery_Duration_Months__c + 1),rrList3.size());
        }else{
            System.assertEquals(2*(opportunity3.Delivery_Duration_Months__c),rrList3.size());
        }
        system.assertEquals(Decimal.valueof('300'), rtadd.opportunity.Amount);
        
        /**************************Modify Custom Developement Revenue Type****************************/
       
        ApexPages.currentPage().getParameters().put('oppid', opportunity3.id);
        System.debug('---opportunity id------'+opportunity3.id);
        ApexPages.Standardcontroller st;
        for(Revenue_Type__c r:rList3){
            if(r.Revenue_Type__c == 'Custom Development'){
                st = new ApexPages.Standardcontroller(r);
            }
        }
        
        RTModifyController rtmodify = new RTModifyController(st);
        rtmodify.populateDefaultValuesForModify();
        rtmodify.rtObject.Product__c = prList[1].id;
        rtmodify.populateProductFamily();
        rtmodify.customDevelopment = '300';
        rtmodify.goSaveAndAddProduct();
       
        
        Opportunity opportunity4 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Recognition_Date__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
        List<Revenue_Type__c> rList4 = opportunity4.Revenue_Type__r;
        List<Revenue_Recognition__c> rrList4 = opportunity4.Revenue_Recognition__r;
       
        for(Revenue_Type__c r:rList4){
            if(r.Revenue_Type__c == 'Custom Development'){
                system.assertEquals(r.amount__c, 300);
            }
        }
        
        /**************************************************************************************************************************************/
        
        
        Test.stopTest();
    }
    
    static testMethod void addSupportOnly() {
        
        /*************************** Create Support Revenue Type **************************************/
          
        //create account
        Account acc = TestUtility.createAccount();
        
        //create opportunity
        Opportunity opp = TestUtility.createOpp();
       
        //create product
        List<Product2> prList = TestUtility.createProduct();
        
        //create book_values__c
        List<Book_Values__c> bvList = TestUtility.createBookValues();
        System.debug('----book values(test)-----'+bvList);
        
        //call class
        
        Test.startTest();
        
        ApexPages.currentPage().getParameters().put('oppid', opp.id);
        RTAddController rtadd = new RTAddController();
        rtadd.support = '100';
        rtadd.rtObject.Support_Type__c = 'Support';
        rtadd.rtObject.Product__c = prList[0].id;
        rtadd.populateProductFamily();
        rtadd.addAction();
        rtadd.goSaveAdd();
        Opportunity opportunity1 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
       
        List<Revenue_Type__c> rList1 = opportunity1.Revenue_Type__r;
        List<Revenue_Recognition__c> rrList1 = opportunity1.Revenue_Recognition__r;
        
        System.debug('---rrList1----'+rrList1.size());
        
        System.assertEquals(1,rList1.size());
        
        if(opportunity1.Support_Start_Date__c.day() != 1){
            System.assertEquals(13,rrList1.size());
        }else{
            System.assertEquals(12,rrList1.size());
        }
        
        /****************** When support type already exist and we create third party revenue type ************************/
       
        //call class
      
        ApexPages.currentPage().getParameters().put('oppid', opp.id);
        RTAddController rtadd1 = new RTAddController();
        rtadd1.addAction();
        rtadd1.thirdParty = '200';
        rtadd.rtObject.Product__c = prList[1].id;
        rtadd1.populateProductFamily();
        rtadd1.goSaveAdd();
        
        Opportunity opportunity2 = [Select o.Support_Duration_Months__c,o.Support_Start_Date__c,o.Delivery_Duration_Months__c , o.Project_Start_Lag_Days__c, o.Name, o.Id, o.CloseDate, 
          (Select Id, Amount__c, Product_Type__c, Product__c,Product__r.Name, Product_Family__c, Revenue_Type__c, License_Type__c, Support_Type__c 
          From Revenue_Type__r order by Product__r.Name), (Select Id, Amount__c,Revenue_Type__c From Revenue_Recognition__r) From Opportunity o where 
          o.id =: opp.id];
       
        List<Revenue_Type__c> rList2 = opportunity2.Revenue_Type__r;
        List<Revenue_Recognition__c> rrList2 = opportunity2.Revenue_Recognition__r;
        
        System.debug('---rrList1----'+rrList2.size());
        
        System.assertEquals(2,rList2.size());
        
        Date startDate = opportunity2.CloseDate.addDays(Integer.valueOf(opportunity2.Project_Start_Lag_Days__c));
        if(startDate.day() != 1){
            System.assertEquals(rrList1.size() + (opportunity2.Delivery_Duration_Months__c + 1),rrList2.size());
        }else{
            System.assertEquals(rrList1.size() + (opportunity2.Delivery_Duration_Months__c),rrList2.size());
        }
        
        Test.stopTest();
    }
   
}