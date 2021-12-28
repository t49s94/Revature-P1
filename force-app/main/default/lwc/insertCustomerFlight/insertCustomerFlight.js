import { LightningElement, wire, api, track } from 'lwc';
import getCustomers from '@salesforce/apex/CustomerService.getCustomers';
import insertCustomerFlight from '@salesforce/apex/CustomerFlightService.insertCustomerFlight';
import { subscribe, MessageContext } from 'lightning/messageService';
import NEW_MESSAGE_CHANNEL from '@salesforce/messageChannel/flight__c';
import { NavigationMixin } from 'lightning/navigation';

export default class InsertCustomerFlight extends NavigationMixin(LightningElement) {

    subscription = null;
    @wire(MessageContext)
    msgContext;

    @track
    flightId;
    @track
    customers;
    @track customerOptions;

    @track paymentOptions = [
        { label: "Credit card", value: "Credit card" },
        { label: "Debit card", value: "Debit card" },
        { label: "Cash", value: "Cash" },
    ];

    @api customerId;
    @api paymentMethod;

    LikeAndSubscribe() {
        this.subscription = subscribe(this.msgContext, NEW_MESSAGE_CHANNEL, (message) => this.HandleMessage(message));
    }

    connectedCallback(){
        this.LikeAndSubscribe();
    }

    HandleMessage(message){
        this.flightId = message.flightId;
        this.retrieveCustomers();
        console.log(this.flightId);
    }

    retrieveCustomers() {
        getCustomers()
            .then((result) => {
                this.customers = result;
                this.getcustomerOptions();
               
            })
            .catch((error) => {
            this.error = error;
            });
    }

    getcustomerOptions() {

        this.customerOptions = this.customers.map(customer => ({
            label: customer.First_Name__c + ' ' + customer.Last_Name__c,
            value: customer.Id
          }));
    }

    handleCustomerChange(event) {
        this.customerId = event.target.value;
    }

    handlePaymentChange(event) {
        this.paymentMethod = event.target.value;
    }

    handleBookClick(event) {

        insertCustomerFlight(
            {
                customerId: this.customerId,
                flightId: this.flightId,
                checkedLuggage: this.template.querySelector(".checkedLuggage").value,
                pointsUsed: this.template.querySelector(".pointsUsed").value,
                paymentMethod: this.paymentMethod
            }
        )
        .then((result) => {
            console.log("result  " + result);
            this.navigateToHomePage("Success");
        })
        .catch((error) => {
            console.log(error);
            this.navigateToHomePage("Failure");
        });
            
    }

    //Navigate to home page
    navigateToHomePage(status) {
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
            },
            state: {
                c__sample: status
            }
        });
    }

    
}