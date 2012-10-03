public with sharing class RevenueTypeUtility {
    
    public static Decimal getValue(Decimal d)
    {
        if(d==null)
            return 0;
        else
            return d;           
    }
    
    public static Decimal getValueInt(String s)
    {
    	system.debug('------->'+s);
        if(s == null || s.trim().equals(''))
            return 0;
        else
            return Decimal.valueOf(s);           
    }
    public static boolean hasValue(String s)
    {
        if(s!=null && !s.trim().equals(''))
            return true;
        else
            return false;           
    }
   
}