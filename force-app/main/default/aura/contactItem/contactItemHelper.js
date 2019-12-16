({
    createContact: function(component, newContact) {
        let createEvent = component.getEvent("updateContact");
        console.log("check of null"+JSON.stringify(newContact));
        createEvent.setParams({ "contactitem": newContact });
        createEvent.fire();
        /*var evt = $A.get("e.force:navigateToComponent");
        evt.setParams({
            componentDef : "c:contactForm",
            componentAttributes: {
                newContact : newContact
            }
        });
        evt.fire();*/
    },
})