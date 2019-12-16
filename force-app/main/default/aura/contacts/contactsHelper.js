({
    saveContacts: function(component, contact, callback) {
        var action = component.get("c.saveContact");
        action.setParams({
            "saveContact": contact
        });
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },
    createContact: function(component, contact) {
        this.saveContacts(component, contact, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contactRec", response.getReturnValue());
				component.set("v.renderCard", true);                
            }else{
                alert("Contact not Insert Or Update");
            }
        });
    },
    
})