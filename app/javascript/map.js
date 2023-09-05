let map;
let geocoder;
let marker = [];
let infoWindow = [];
const spots = gon.spots;

const initMap = () => {
  //geocoderの初期化
  geocoder = new google.maps.Geocoder()

  // 初期値を設定
  const tokyoStation = { lat:35.6814104752183, lng:139.76721062882686};

  let map = new google.maps.Map(document.getElementById('map'), {
  center: tokyoStation,
  zoom: 8
  });

  for(let i = 0; i < spots.length; i++) {
    console.log(spots[i])
    let latlng = {
      lat: spots[i].lat,
      lng: spots[i].lng,
    };

    geocoder.geocode({ 'location': latlng }, function(results, status){
      if (status == 'OK') {
        map.setCenter(results[0].geometry.location);
        marker[i] = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
        })

      }
    })
  }
}

window.addEventListener('turbo:load', initMap);