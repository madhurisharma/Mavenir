public with sharing class TestUtility {
    public static Opportunity opp;
    public static List<Product2> prodList;
    public static List<Revenue_Type__c> rtList;
    public static List<Revenue_Recognition__c> rrList;
    
    //create account
    public static Account createAccount(){
        
        Account acc = new Account();
        acc.name = 'test';
        insert acc;
        return acc;
    }
    //create opportunity
    public static Opportunity createOpp(){
        
        opp = new Opportunity();
        opp.name = 'test';
        opp.AccountId = createAccount().id;
        opp.Region__c = 'americas';
        opp.Country__c = 'united kingdom';
        opp.Program_Manager__c = 'test';
        opp.Selling_agent_or_consultant__c = 'test';
        opp.CloseDate = Date.today();
        opp.AWS_Forecast_Category__c = 'test';
        opp.stageName = '1. Suspect';
        opp.Bid_Stage__c = 'Qualified';
        opp.Solution__c = 'Instant Messaging';
        opp.Support_Duration_Months__c = 12;
        opp.Delivery_Duration_Months__c = 2;
        opp.Project_Start_Lag_Days__c = 45;
        insert opp;
        return opp;
        
    }
    //create product
    public static List<Product2> createProduct(){
        prodList = new List<Product2>();
        
        Product2 pr1 = new Product2();
        pr1.name = 'Test Product1';
        pr1.Family = 'Test';
        pr1.IsActive = true;
        prodList.add(pr1);
        
        Product2 pr2 = new Product2();
        pr2.name = 'Test Product2';
        pr2.Family = 'Test';
        pr2.IsActive = true;
        prodList.add(pr2);
        
        Product2 pr3 = new Product2();
        pr3.name = 'Test Product3';
        pr3.Family = 'Test';
        pr3.IsActive = true;
        prodList.add(pr3);
        
        insert prodList;
        return prodList;
    }
    
    //create Book_Values__c
    public static List<Book_Values__c>  createBookValues(){ 
        
      List<Book_Values__c> bvList = new List<Book_Values__c>();
      
      Book_Values__c bv1 = new Book_Values__c();
      bv1.Name = 'Lag_Days';
      bv1.Value__c = '45';
      bvList.add(bv1);
      
      Book_Values__c bv2 = new Book_Values__c();
      bv2.Name = 'Month_Duration';
      bv2.Value__c = '3';
      bvList.add(bv2);
      
      Book_Values__c bv3 = new Book_Values__c();
      bv3.Name = 'Support_Month_Duration';
      bv3.Value__c = '12';
      bvList.add(bv3);
      
      insert bvList;
      return bvList;    
     
    }
    //create opportunity
    public static Opportunity createOppWithoutBookValues(){
        
        Opportunity opp1 = new Opportunity();
        opp1.name = 'test';
        opp1.AccountId = createAccount().id;
        opp1.Region__c = 'americas';
        opp1.Country__c = 'united kingdom';
        opp1.Program_Manager__c = 'test';
        opp1.Selling_agent_or_consultant__c = 'test';
        opp1.CloseDate = Date.today();
        opp1.AWS_Forecast_Category__c = 'test';
        opp1.stageName = '1. Suspect';
        opp1.Bid_Stage__c = 'Qualified';
        opp1.Solution__c = 'Instant Messaging';
        insert opp1;
        return opp1;
        
    }
    
    //create OppBudget__c
    public static List<OppBudget__c> createOppBudget(){
        List<OppBudget__c> obList = new List<OppBudget__c>();
        
        OppBudget__c ob1 = new OppBudget__c();
        ob1.name = 'Number_Of_Columns';
        ob1.Value__c = '10';
        obList.add(ob1);
        
        OppBudget__c ob2 = new OppBudget__c();
        ob2.name = 'Number_Of_Rows';
        ob2.Value__c = '10';
        obList.add(ob2);
        
        OppBudget__c ob3 = new OppBudget__c();
        ob3.name = 'Row_1';
        ob3.Value__c = 'Subscribers';
        obList.add(ob3);
        
        OppBudget__c ob4 = new OppBudget__c();
        ob4.name = 'Row_10';
        ob4.Value__c = 'Placeholder5';
        obList.add(ob4);
        
        OppBudget__c ob5 = new OppBudget__c();
        ob5.name = 'Row_2';
        ob5.Value__c = 'HW Price Per Sub';
        obList.add(ob5);
        
        OppBudget__c ob6 = new OppBudget__c();
        ob6.name = 'Row_3';
        ob6.Value__c = 'SW Price per hub';
        obList.add(ob6);
        
        OppBudget__c ob7 = new OppBudget__c();
        ob7.name = 'Row_4';
        ob7.Value__c = 'HW Price % of total HW & SW';
        obList.add(ob7);
        
        OppBudget__c ob8 = new OppBudget__c();
        ob8.name = 'Row_5';
        ob8.Value__c = 'Professional Services price as % of total (HW+SW+All Services)';
        obList.add(ob8);
        
        OppBudget__c ob9 = new OppBudget__c();
        ob9.name = 'Row_6';
        ob9.Value__c = 'Placeholder1';
        obList.add(ob9);
        
        OppBudget__c ob10 = new OppBudget__c();
        ob10.name = 'Row_7';
        ob10.Value__c = 'Placeholder2';
        obList.add(ob10);
        
        OppBudget__c ob11 = new OppBudget__c();
        ob11.name = 'Row_8';
        ob11.Value__c = 'Placeholder3';
        obList.add(ob11);
        
        OppBudget__c ob12 = new OppBudget__c();
        ob12.name = 'Row_9';
        ob12.Value__c = 'Placeholder4';
        obList.add(ob12);
        
        insert obList;
        return obList;
        
    }

}