import { LightningElement, wire, track, api } from 'lwc';
import getAirports from '@salesforce/apex/AirportService.getAirports';
import { publish, MessageContext } from 'lightning/messageService';
import NEW_MESSAGE_CHANNEL from '@salesforce/messageChannel/searchAirports__c';
import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SearchFlight extends LightningElement {

	@wire(MessageContext)
    msgContext;

	@wire(CurrentPageReference)
    currentPageReference;

    @track searchKeyFrom;
	@track searchKeyTo;
	@track airportsFrom;
	@track airportsTo;

	@track error;

	@track airportFrom = {
		id: "",
		name: ""
	};
	@track airportTo = {
		id: "",
		name: ""
	};

	@api airportFromListOpen = false;
	@api airportToListOpen = false;

	connectedCallback() {
       
		if(this.currentPageReference.state.c__sample == "Success")
			this.showToastSuccess();
        else if(this.currentPageReference.state.c__sample == "Failure")
			this.showToastError();
   
    }

	@wire (getAirports,{strCityName: '$searchKeyFrom'})
	wiredAirportsFrom({data, error}){
		if(data) {
			this.airportsFrom = data;
			this.airportFromListOpen = true;
			this.error = undefined;
			
		}else {
			this.airportsFrom =undefined;
			this.airportFromListOpen = false;
			this.error = error;
		}
	}

	handleKeyChangeAirportFrom(event){
		this.searchKeyFrom = event.target.value;
	}

	handleAirportFromClick(event){
		
		this.airportFrom.id = event.target.dataset.id;
		this.airportFrom.name = event.target.dataset.name;
		this.airportFromListOpen = false;
	}

	@wire (getAirports,{strCityName: '$searchKeyTo'})
	wiredAirportsTo({data, error}){
		if(data) {
			this.airportsTo = data;
			this.airportToListOpen = true;
			this.error = undefined;
			
		}else {
			this.airportsTo =undefined;
			this.airportToListOpen = false;
			this.error = error;
		}
	}

	handleKeyChangeAirportTo(event){
		this.searchKeyTo = event.target.value;
	}

	handleAirportToClick(event){
		
		this.airportTo.id = event.target.dataset.id;
		this.airportTo.name = event.target.dataset.name;
		this.airportToListOpen = false;
		console.log("id " + this.airportTo.id + " name " + this.airportTo.name);
	}

	handleSearchButtonClick(){
        const messageSent = {
            airportFromId: this.airportFrom.id,
			airportFromName: this.airportFrom.name,
			airportToId: this.airportTo.id,
			airportToName: this.airportTo.name,
			date: this.template.querySelector(".flightDate").value
        };
		
        publish(this.msgContext, NEW_MESSAGE_CHANNEL, messageSent);
    }

	showToastSuccess() {
        const event = new ShowToastEvent({
            title: 'Success',
            message: 'You flight is booked!',
            variant: 'success',
            mode: 'sticky',
        });

        this.dispatchEvent(event);
    }

    showToastError() {
        const event = new ShowToastEvent({
            title: 'Error',
            message: 'Couldn\'t book your flight!',
            variant: 'error',
            mode: 'sticky',
        });

        this.dispatchEvent(event);
    }

}