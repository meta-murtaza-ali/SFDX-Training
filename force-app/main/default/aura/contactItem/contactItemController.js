({
	clickEdit: function(component, event, helper) {
            let newContact = component.get("v.contactRecord");
            helper.createContact(component, newContact);
    },
})