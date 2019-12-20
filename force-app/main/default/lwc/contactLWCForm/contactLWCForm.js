import { LightningElement, track, api } from "lwc";
import saveContact from "@salesforce/apex/ContactController.saveContact";
//import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactLWCForm extends LightningElement {
  @api
  get contactObject() {
    return this.state.contact;
  }
  set contactObject(value = {}) {
    this.state.contact = { ...value };
  }

  @track state = {
    error: null,
    contact: {
      LastName: "",
      Email: "",
      MobilePhone: null
    }
  };

  handleSubmit() {
    var inp = this.template.querySelectorAll("lightning-input");

    inp.forEach(function(element) {
      if (element.name === "contactname") {
        this.state.contact.LastName = element.value;
      } else if (element.name === "contactemail") {
        this.state.contact.Email = element.value;
      } else if (element.name === "contactphone") {
        this.state.contact.MobilePhone = element.value;
      }
    }, this);

    saveContact({ record: this.state.contact })
      .then(result => {
        this.state.contact = result;
        const config = {
          title: "Message",
          message: "Contact Creation Successful...!!!"
        };
        config.contact = this.state.contact;
        const event = new CustomEvent("savedcontact", {
          detail: config
        });
        this.state = {
          error: null,
          contact: {
            LastName: "",
            Email: "",
            MobilePhone: null
          }
        };
        this.dispatchEvent(event);
      })
      .catch(error => {
        const event = new CustomEvent("error", {
          detail: error
        });
        this.dispatchEvent(event);
      });
  }
}
