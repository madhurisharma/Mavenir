/*******************************************************************************************************************
Name         : BudgetController 
Created By   : Manu Dewan/ Make Positive
Created Date : 14 Sep 2012
Description  : Controller/ Extension for the budget page used as a visualforce section on the Opportunity page
               to show and allow editing of budget fields as a grid
Related Page : budget.page
Task         : Display budget as an editable spreadsheet on Opportunity as rows with 10 columns each to be able to be
               copy-pasted from/to MS Excel
Requested By : Clive Innes/ Mavenir UK

/*************************************************************************************************************/
global class BudgetController {
    private final Opportunity opp;
    
    public List<Opportunity_Budget__c> lstBudget{get;set;}
    public string JSONBudget{get;set;}
    public string rowHeaders{get;set;}
    public string colHeaders{get;set;}
    
    Map<string, OppBudget__c> mapBudgetSetings;
    public integer noOfCols{get;set;}
    public integer noOfRows{get;set;}
    
    //Default constructor for the extension of the Opportunity
    public BudgetController(ApexPages.StandardController stdController) {
                
        mapBudgetSetings = OppBudget__c.getAll();
        noOfCols = Integer.valueOf(OppBudget__c.getAll().get('Number_Of_Columns').value__c);
        noOfRows = Integer.valueOf(OppBudget__c.getAll().get('Number_Of_Rows').value__c);
        system.debug('mapBudgetSetings: '+ mapBudgetSetings);
        this.opp = (Opportunity)stdController.getRecord();
        
        List<Opportunity_Budget__c> lstBudget = database.query(getQueryString());
        System.debug('--lstBudget----'+lstBudget);
        this.lstBudget = lstBudget;
        this.JSONBudget = serialize(lstBudget);
        
        rowHeaders = getRowHeaders();
        colHeaders = getColHeaders();
        
    }
    
    //Build the query based on the naming convention of the column name being col_x__c where x is 1, 2, 3....n
    //where n is the number of fields having that format (col_x__c)
    private string getQueryString(){
        
        string queryString ='select ';
        for(Integer i=1; i<=noOfCols;i++){
            queryString+='Col_' + i+'__c,';
        }
        queryString+=' name FROM Opportunity_Budget__c where Opportunity__r.id=\''+opp.Id+'\'';
        system.debug(querystring);
        return querystring;
    }
    
    //Save the modified budget records
    webservice static string save(Id oppId, string[] JSONBudget){
        string returnString ='The entered values updated sucessfully.';
        System.debug('\n\nSAVE STRING:  ' + JSONBudget);
        List<Opportunity_Budget__c> lstBudget;
        try{
            lstBudget = deserialize(oppId, JSONBudget);
            System.debug('\n\nSAVE: ' + lstBudget);
        }catch(Exception e){
            returnString = 'There was an error: '+ e;
        }
       
        Database.upsert(lstBudget, Opportunity_Budget__c.Header__c);
        
        return returnString;
    }

    //Serializes the list of Opp Budgets into a strig acceptable by the JS component on the the page
    private string serialize(List<Opportunity_Budget__c> lstBudget){
        string JSONBudget = '[';
        Map<string, Opportunity_Budget__c> mapBudget = new  Map<string, Opportunity_Budget__c>();
        
        for(Opportunity_Budget__c budget : lstBudget){
            System.debug('\n\nBUDGET NAME: ' + budget.name);  
            mapBudget.put(budget.name, budget);
        }
        
        for(Integer i=0; i<noOfRows; i++){
            String rowName = mapBudgetSetings.get('Row_' + (i + 1)).Value__c;
            System.debug('\n\nROW NAME: ' + rowName);            
            JSONBudget+='[';
           
            if(mapBudget.containsKey(rowName)){
                Opportunity_Budget__c budget = mapbudget.get(rowName);
                System.debug('\n\nBUDGET RECORD: ' + budget);
                for(integer j = 1; j <= noOfCols; j++){
                    JSONBudget+='"'+replaceNull(String.valueOf(budget.get('Col_'+j+'__c')))+'",';
                }
                System.debug('\n\nBUDGET JSON: ' + JSONBudget);
                JSONBudget=JSONBudget.substring(0, JSONBudget.lastIndexOf(','));
            }else{
                for(integer j = 1; j <= noOfCols; j++){
                    JSONBudget+=',';
                }
            }
            
            JSONBudget+='],';
        }
        
        
        JSONBudget=JSONBudget.substring(0, JSONBudget.lastIndexOf(','));
        JSONBudget+=']';
        System.debug('-----JSONBUDGET-------'+JSONBudget);
        return JSONBudget;
    }

    //Deseriliazes the array of strings to a list of the Opp Budgets for the Opp
    private static List<Opportunity_Budget__c> deserialize(Id oppId, List<string> lstJSONBudget){
        
        system.debug('\n\nJSON LIST--->' + lstJSONBudget);
        
        List<Opportunity_Budget__c> lstBudget = new List<Opportunity_Budget__c>();
        Integer noOfCols = Integer.valueOf(OppBudget__c.getAll().get('Number_Of_Columns').value__c);
        Integer noOfRows = Integer.valueOf(OppBudget__c.getAll().get('Number_Of_Rows').value__c);
        Integer counter = 0;
        Map<string, OppBudget__c> mapBudgetSetings = OppBudget__c.getAll();
        
        System.debug('\n\nNO OF ROWS: ' + noOfRows);
        
        for (integer i = 0; i < noOfRows; i++){         
            //TODO: Get the names of the rows from JS or from the custom settings
            Opportunity_Budget__c budget = new Opportunity_Budget__c(Header__c = mapBudgetSetings.get('Row_' + (i + 1)).Value__c);
            budget.Opportunity__c = oppId;
            
            for(integer j = 0; j < noOfCols; j++){
                budget.put('Col_' + (j + 1) + '__c',lstJSONBudget[counter++]);
            }
            System.debug('\n\nROW: ' + i + ' == ' + budget);
            lstBudget.add(budget);
            System.debug('\n\nLIST OF ROWS 2: ' + lstBudget);
        }
        System.debug('\n\nLIST OF ROWS: ' + lstBudget);
        return lstBudget;
    }
    
    //Get the row headers from the custom settings as a comma-separated string as required by the handsontable script to generate the table
    private string getRowHeaders(){
        string rowHeaders = '';
        for(Integer i=0; i<noOfRows; i++){
            rowHeaders+='"'+ mapBudgetSetings.get('Row_' + (i + 1)).Value__c +'",';         
        }
        rowHeaders = rowHeaders.substring(0, rowHeaders.lastIndexOf(','));      
        return rowHeaders;
    }
    
    //Get the column headers as a comma-separated string as required by the handsontable script to generate the table
    private string getColHeaders(){
        string colHeaders='';
        for(integer i=1; i <= noOfCols; i++){
            colHeaders+='"'+i+'",';
        }
        
        colHeaders = colHeaders.substring(0, colHeaders.lastIndexOf(','));
        
        return colHeaders;
    }

    public string replaceNull(string s){
     /*
        if (s==null || s.equals('null')) 
            return '';
      else
          return s; */
       if (s==null || s.equals('null')) 
            return '';
      else if(s != null){
            String s1 =  s.replace('"', '\\"');
            return s1;
      }
      else
          return s;  
    }

}