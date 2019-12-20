({
  clickCreate: function(component, event, helper) {
    let validExpense = component
      .find("contactform")
      .reduce(function(validSoFar, inputCmp) {
        // Displays error messages for invalid fields
        inputCmp.showHelpMessageIfInvalid();
        return validSoFar && inputCmp.get("v.validity").valid;
      }, true);
    // If we pass error checking, do some real work
    if (validExpense) {
      // Create the new contact
      let createEvent = component.getEvent("createNewContact");
      createEvent.setParams({ contactitem: component.get("v.newContact") });
      createEvent.fire();
      component.set("v.newContact", {});
    }
  }
});
