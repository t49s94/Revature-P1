import { LightningElement, track, wire } from 'lwc';
import getFlights from '@salesforce/apex/FlightService.getFlights';
import { publish, subscribe, MessageContext } from 'lightning/messageService';
import NEW_MESSAGE_CHANNEL from '@salesforce/messageChannel/searchAirports__c';
import FLIGHT_MESSAGE_CHANNEL from '@salesforce/messageChannel/flight__c';

export default class SearchResults extends LightningElement {

    subscription = null;
    @wire(MessageContext) 
    msgContext;

    @wire(MessageContext) 
    msgContextPublish;

    @track
    flightCriteria = {
        airportFromId: "",
        airportFromName: "",
        airportToId: "",
        airportToName: "",
        date: ""
    }

    @track flights;
    @track error;

    LikeAndSubscribe() {
        this.subscription = subscribe(this.msgContext, NEW_MESSAGE_CHANNEL, (message) => this.HandleMessage(message));
    }

    HandleMessage(message){
        this.flightCriteria.airportFromId = message.airportFromId;
        this.flightCriteria.airportFromName = message.airportFromName;
        this.flightCriteria.airportToId = message.airportToId;
        this.flightCriteria.airportToName = message.airportToName;
        this.flightCriteria.date = message.date;
        
        this.retrieveFlights();
        
    }

    connectedCallback(){
        this.LikeAndSubscribe();
    }

    // If we have a method that takes a parameter, we pass in the parameter via object syntax.
    retrieveFlights() {
        getFlights({airportFrom: this.flightCriteria.airportFromId,
        airportTo: this.flightCriteria.airportToId,
        flightDate: this.flightCriteria.date})
            .then((result) => {
                this.flights = result;
                console.log(result);
            })
            .catch((error) => {
            this.error = error;
            });
    }

    handleFlightClick(event){
        console.log("Flight id: " + event.currentTarget.dataset.id)
        const messageSent = {
            flightId: event.currentTarget.dataset.id
        }
		
        publish(this.msgContextPublish, FLIGHT_MESSAGE_CHANNEL, messageSent);
    }

}