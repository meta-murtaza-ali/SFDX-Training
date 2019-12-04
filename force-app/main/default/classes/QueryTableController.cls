/**
 * This is a Controller of Query Result Component.
 */
public class QueryTableController 
{
    public String queryToBeExecuted;
    public List<String> fieldsList{get;set;}
    public String sortBy;
    public Integer DesiredPage{get;set;}
    public Boolean isSortingLinkClicked = false;
    /**
     * This is Standard Set Controller Object.
     */
    public ApexPages.StandardSetController setCon
    {
        get
        {
            if(setCon == null)
            {
                List<sObject> displayFields = new List<sObject>();
                displayFields = getDisplayFields(queryToBeExecuted);
                if(displayFields != null)
                {
                    setCon = new ApexPages.StandardSetController(displayFields);
                    setCon.setPageSize(10);
                }
            }
            return setCon;
        }
        set;
    }
    // Constructor Initializer
    public QueryTableController()
    {
        this.queryToBeExecuted = '';
        this.sortBy = '';
    }
    // Return query to be executed.
    public String getQueryToBeExecuted()
    {
        return this.queryToBeExecuted;
    }
    // Set queryToBeExecuted Variable.
    public void setQueryToBeExecuted(String query)
    {
        if(!this.queryToBeExecuted.equalsIgnoreCase(query))
        {
            this.queryToBeExecuted = query;
            this.setCon = null;
        }
    }
    // Sorting Method. 
    public void sortByMethod()
    {
        this.setCon = null;
        this.isSortingLinkClicked = true;
    }
    // Set sortBy variable.
    public void setSortBy(String fieldName)
    {
        this.sortBy = fieldName;
    }
    // Get sortBy variable.
    public String getSortBy()
    {
        return this.sortBy;
    }
    // Get Records List.
    public List<sObject> getRecordsList()
    {
        if(setCon != null)
        {
            this.DesiredPage = setCon.getPageNumber();
            return setCon.getRecords();
        }
        else
        {
            return null;
        }
    }
    
	// Create final query.
    private String createQuery(String query)
    {
        String orderedQuery = query;        
        if(isSortingLinkClicked && String.isNotBlank(this.getSortBy()))
        {
            if(query.containsIgnoreCase('order by'))
            {
                orderedQuery = orderedQuery.substring(0, query.indexOfIgnoreCase('order by') - 1);
            }
            orderedQuery = orderedQuery + ' ORDER BY ' + this.getSortBy();
        }
        return orderedQuery;
    }
    
	// Execute Query.
    private List<sObject> executeQuery(String query)
    {
        String orderedQuery = createQuery(query);
        List<sObject> sObjectList = new List<sObject>();
        try
        {
            sObjectList = Database.query(orderedQuery);
            
        }
        catch(Exception excp)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, excp.getMessage())); 
            return null;
        }
        return sObjectList;
    }
    
	// Return records to be display.
    public List<sObject> getDisplayFields(String query)
    {
        List<sObject> records = executeQuery(query);
        if(records == null)
        {
            return null;
        }
        else
        {
            if(records.isEmpty())
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No records found'));
                records = new List<Account>();
            }
            else
            {
                Set<String> fieldsSet = new Set<String>();
                for(sObject record : records)
                {
                    fieldsSet.addAll(record.getPopulatedFieldsAsMap().keySet());
                }
                this.fieldsList = new List<String>();
                this.fieldsList.addAll(fieldsSet);
            }
            return records; 
        }
    }  
	// Method for jump to a desired page number.
    public void jumpToPage()
    {
        this.setCon.setPageNumber(DesiredPage);
    }
}