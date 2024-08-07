import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="place-search"
export default class extends Controller {
  static targets = ["place", "lat", "lng"]

  search() {
    // GoogleAPIの読み込みを確認
    if (typeof google === 'undefined' || typeof google.maps === 'undefined' || typeof google.maps.places === 'undefined') {
      console.error("Google Maps API not loaded");
      return;
    }
    
    const input = this.placeTarget;
    const lat = this.latTarget;
    const lng = this.lngTarget;

    const autocomplete = new google.maps.places.Autocomplete(input, {
      componentRestrictions: {country: "jp"},
      fields: ["adr_address", "geometry", "name"],
      types: ["premise","point_of_interest"],
    });

    autocomplete.addListener("place_changed", () => {
      const placeName = autocomplete.getPlace().name;
      input.value = placeName;
      lat.value = autocomplete.getPlace().geometry.location.lat()
      lng.value = autocomplete.getPlace().geometry.location.lng()
      
    })
  }
}