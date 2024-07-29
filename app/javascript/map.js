let map;
let geocoder;
let marker = [];
let infoWindow = [];


async function initMap() {
  
  const mapContent = document.getElementById('map')
  if(!mapContent) return null;
  
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
  const spots = gon.spots;
  const hotel = gon.hotel;
  
  //geocoderの初期化
  geocoder = new google.maps.Geocoder()

  // 初期値を設定
  const tokyoStation = { lat:35.6814104752183, lng:139.76721062882686};

  map = new Map(document.getElementById("map"), {
    center: tokyoStation,
    zoom: 8,
    mapId: gon.MAPID
  });
  
  if (spots != null) {
    for(let i = 0; i < spots.length; i++) {
      let latlng = {
        lat: spots[i].lat,
        lng: spots[i].lng,
      };
      // データベースの中から経度緯度を取り出して、ピン留め
      geocoder.geocode({ 'location': latlng }, function(results, status){
        if (status == 'OK') {
          map.setCenter(results[0].geometry.location);

          marker[i] = new google.maps.marker.AdvancedMarkerElement({
            map: map,
            position: results[0].geometry.location,
            title: `${i + 1}`
          })
          let address = results[0].formatted_address.split('、')
          infoWindow[i] = new google.maps.InfoWindow({
            HeaderDisabled: true,
            content: `
                    <h1>${gon.spots[i].place}</h1>
                    <p>
                      ${address[1]}
                    </p>
                    `
          });
      
          marker[i].addListener('click', () => {
            // クリックされた時に他のマーカーを閉じる
            for (const j in marker) {
              infoWindow[j].close(map, marker[j]);
            }

            infoWindow[i].open({
              anchor: marker[i],
              map,
            })
          })
        }

      })
    }
  } else {
    let latlng = {
      lat: hotel["latitude"],
      lng: hotel["longitude"],
    };
    // データベースの中から経度緯度を取り出して、ピン留め
    geocoder.geocode({ 'location': latlng }, function(results, status){
      if (status == 'OK') {
        map.setCenter(results[0].geometry.location);
        marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location,
        })

        let address = results[0].formatted_address.split('、')
        infoWindow = new google.maps.InfoWindow({
          content: `
                  <h1>${hotel.hotelName}</h1>
                  <p>
                    ${address}
                  </p>
                  `
        });
          marker.addListener('click', () => {
            infoWindow.open({
              anchor: marker,
              map,
            })
          })
      }

    })
  }



}

// Turboイベントリスナーを追加
document.addEventListener('turbo:load', () => {
  if (!document.getElementById('map')) return;
  
  if (!window.google || !window.google.maps) {
    const intervalId = setInterval(() => {
      if (window.google && window.google.maps) {
        initMap();
        clearInterval(intervalId);
      }
    }, 100);
  } else {
    initMap();
  }
});