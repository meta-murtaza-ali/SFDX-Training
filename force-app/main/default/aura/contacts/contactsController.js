({
	handleCreateContact: function(component, event, helper) {
        var newContact = event.getParam("contactitem");
        helper.createContact(component, newContact);
    },
    handleUpdateContact : function(component, event, helper) {
        var newContact = event.getParam("contactitem");
        component.set("v.newEditContact",newContact);
    },
})