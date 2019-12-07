/**
 * Class of Email Service
 */

global class ContactEmailService implements Messaging.InboundEmailHandler
{
    /**
     * Method to handle Inbound Email.
     */
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        try
        {
            for(Messaging.InboundEmail.TextAttachment textAttachments : email.textAttachments)
            {
                XMLparse(textAttachments.body);
            }
            result.success = true;
        }
        catch(Exception e)
        {
            result.message = e.getMessage();
            result.success = false;
        }
        return result;
    }
    
    /**
	 * Method for XML parse.
	 */
    private void XMLparse(String xMLString)
    {
        List<Contact> contactList = new List<Contact>();
        DOM.Document doc=new DOM.Document();
		doc.load(xMLString);
        DOM.XmlNode rootNode=doc.getRootElement();
        contactList =  parseXML(rootNode,contactList);
        insert contactList;
    }
    
    /**
	 * Method for Parse XML.
	 */
    private List<Contact> parseXML(DOM.XMLNode node,List<Contact> contactList)
    {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) 
        {
            if(node.getName()=='contact')
            {
                contactList.add( paseContact(node));
            }
            else
            {
                for (DOM.XMLNode child: node.getChildElements()) 
                {
                    contactList= parseXML(child,contactList);
                }
            }
            
        }
        return contactList;
    }
    
    private Contact paseContact(DOM.XmlNode con)
    {
        Contact cont = new Contact();
        
        for(DOM.XmlNode ele: con.getChildElements())
        {
            cont.put(ele.getName(), ele.getText().trim());
        }
        return cont;
    }
}