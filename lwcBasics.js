///////////////////////////////////////////////////////////////////////////////// 
// 
// Name: LWC Basics 
// Author: Jared Longnecker, Salesforce Team
// Created: 07/07/21
// Updated: 12/14/21
// Description: A basic overview of LWC.
// 
/////////////////////////////////////////////////////////////////////////////////

import { LightningElement } from 'lwc';

export default class LwcBasics extends LightningElement {

    // This is a field of the class. An instance of a field is called a property
    btnLabel = "Hide";
    detailsActive = true;

    myStarter = [
        { name: "Squirtle", image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png" },
        { name: "Wartortle", image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/8.png" },
        { name: "Blastoise", image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png"}
    ];

    // We're not manipulating the DOM here! Very important, we only change our properties
    handleClick() {
        this.detailsActive = !this.detailsActive;
        this.btnLabel = (!this.detailsActive ? "Show" : "Hide");
    }
}