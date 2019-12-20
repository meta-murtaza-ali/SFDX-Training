({
    createContact: function(component, newContact) {
        let createEvent = component.getEvent("updateContact");
        console.log("check of null"+JSON.stringify(newContact));
        createEvent.setParams({ "contactitem": newContact });
        createEvent.fire();
    },
})