import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="place-search"
export default class extends Controller {
  static targets = ["place"]
  search() {
    const input = this.placeTarget;
    const autocomplete = new google.maps.places.Autocomplete(input, {
      componentRestrictions: {country: "jp"},
      fields: ["adr_address", "geometry", "name"],
      types: ["premise","point_of_interest"],
    });

    autocomplete.addListener("place_changed", () => {
      const placeName = autocomplete.getPlace().name;
      console.log(autocomplete.getPlace().geometry.)
      input.value = placeName;
    })
  }
}