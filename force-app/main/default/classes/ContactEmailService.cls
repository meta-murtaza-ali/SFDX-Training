/**
 * Class of Email Service
 */
global class ContactEmailService implements Messaging.InboundEmailHandler {
 /**
  * Method to handle Inbound Email.
  */
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
    String contentTextBody= '';
    for(Messaging.InboundEmail.TextAttachment textAttachments : email.textAttachments){
        contentTextBody = textAttachments.body;
        XMLparse(contentTextBody);
    }
   result.success = true;
   return result;
  }
    string XMLString;
    public list<Contact> contactList;
    Contact tempContactObj;
    /**
     * Method for XML parse.
     */
    public void XMLparse(String xMLString){
        contactList = new list<Contact>();
        XMLString = xMLString;
        DOM.Document doc=new DOM.Document();
        try{
            doc.load(XMLString);
            DOM.XmlNode rootNode=doc.getRootElement();
            parseXML(rootNode);
            contactList.add(tempContactObj);
            insert contactList;
        }catch(exception e){
            system.debug(e.getMessage());
        }
    }
    /**
     * Method for Parse XML.
     */
    private void parseXML(DOM.XMLNode node) {
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT) {
        system.debug(node.getName());
            if(node.getName()=='contact'){
                if(tempContactObj!=null)
                    contactList.add(tempContactObj);
                tempContactObj = new Contact();
            }
            if(node.getName()=='title')
                tempContactObj.Title=node.getText().trim();
            if(node.getName()=='fname')
                tempContactObj.FirstName=node.getText().trim();
            if(node.getName()=='lname')
                tempContactObj.LastName=node.getText().trim();
            if(node.getName()=='email')
                tempContactObj.Email=node.getText().trim();
            if(node.getName()=='MobilePhone')
                tempContactObj.Phone=node.getText().trim();
        for (Dom.XMLNode child: node.getChildElements()) {
            parseXML(child);
        }
    }
}
}