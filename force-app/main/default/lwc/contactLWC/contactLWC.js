import { LightningElement, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class ContactLWC extends LightningElement {
  @track contactobj = {
    LastName: "",
    Email: " ",
    MobilePhone: null
  };
  @track contactRec;

  handelSavedContact(event) {
    this.contactRec = event.detail.contact;
  }
  handleContactEdit(event) {
    this.contactobj = event.detail;
  }
  handelError() {
    const evt = new ShowToastEvent({
      title: "Error",
      message: "Contact not Insert Or Update",
      variant: "error"
    });
    this.dispatchEvent(evt);
  }
}
