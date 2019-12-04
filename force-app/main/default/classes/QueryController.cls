/**
 * This is a Controller of Query Executer. 
 */
public class QueryController 
{
    public String query{get;set;}
    public Boolean showQueryResultsArea{get;set;}

    public QueryController()
    {
        this.query = '';
        this.showQueryResultsArea = false;
    }
	/**
	 * Execute Method to set showQueryResultsArea variable.
	 */
    public void execute()
    {
        if(!String.isBlank(query))
        {
            this.showQueryResultsArea = true;
        }
    }
}