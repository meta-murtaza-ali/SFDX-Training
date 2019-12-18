import { LightningElement, api } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import CONTACT from "@salesforce/schema/contact";
export default class ContactLWCItem extends NavigationMixin(LightningElement) {
  @api contactRecord;
  clickEdit() {
    const event = new CustomEvent("editcontact", {
      detail: this.contactRecord
    });
    this.dispatchEvent(event);
  }

  gotoRecord() {
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.contactRecord.Id,
        objectApiName: CONTACT, // objectApiName is optional
        actionName: "view"
      }
    });
  }
}
