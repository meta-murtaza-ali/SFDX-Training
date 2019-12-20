({
	createContact: function(component, newContact) {
        let createEvent = component.getEvent("createNewContact");
        createEvent.setParams({ "contactitem": newContact });
        createEvent.fire();
        component.set("v.newContact",{});
    },
})