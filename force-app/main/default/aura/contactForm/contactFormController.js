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
      helper.createContact(component, component.get("v.newContact"));
    }
  }
});
