({
	handleCreateContact: function(component, event, helper) {
        helper.createContact(component, event.getParam("contactitem"));
    },
    handleUpdateContact : function(component, event, helper) {
        component.set("v.newEditContact",event.getParam("contactitem"));
    },
})